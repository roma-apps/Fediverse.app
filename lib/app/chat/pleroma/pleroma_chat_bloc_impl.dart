import 'dart:async';

import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/chat/chat_bloc_impl.dart';
import 'package:fedi/app/chat/message/chat_message_model.dart';
import 'package:fedi/app/chat/pleroma/message/pleroma_chat_message_model.dart';
import 'package:fedi/app/chat/pleroma/message/repository/pleroma_chat_message_repository.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_bloc.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_model.dart';
import 'package:fedi/app/chat/pleroma/repository/pleroma_chat_repository.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/pending/pending_model.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_model.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_service.dart';
import 'package:fedi/pleroma/api/id/pleroma_api_fake_id_helper.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_model.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easy_dispose/easy_dispose.dart';

final _logger = Logger('pleroma_chat_bloc_impl.dart');

class PleromaChatBloc extends ChatBloc implements IPleromaChatBloc {
  // ignore: close_sinks
  final BehaviorSubject<IPleromaChat> _chatSubject;

  // ignore: close_sinks
  final BehaviorSubject<IPleromaChatMessage?> _lastMessageSubject;

  // ignore: close_sinks
  final BehaviorSubject<IPleromaChatMessage> _lastPublishedMessageSubject =
      BehaviorSubject();

  @override
  IPleromaChat get chat => _chatSubject.value;

  @override
  Stream<IPleromaChat> get chatStream => _chatSubject.stream.distinct();

  @override
  IPleromaChatMessage? get lastChatMessage => _lastMessageSubject.valueOrNull;

  @override
  Stream<IPleromaChatMessage?> get lastChatMessageStream =>
      _lastMessageSubject.stream;

  final IMyAccountBloc myAccountBloc;
  final IPleromaApiChatService pleromaChatService;
  final IPleromaChatRepository chatRepository;
  final IPleromaChatMessageRepository chatMessageRepository;
  final IAccountRepository accountRepository;

  final StreamController<IPleromaChatMessage>
      onMessageLocallyHiddenStreamController = StreamController.broadcast();

  @override
  Stream<IPleromaChatMessage> get onMessageLocallyHiddenStream =>
      onMessageLocallyHiddenStreamController.stream;

  PleromaChatBloc({
    required this.pleromaChatService,
    required this.myAccountBloc,
    required this.chatRepository,
    required this.chatMessageRepository,
    required this.accountRepository,
    required IPleromaChat chat,
    required IPleromaChatMessage? lastChatMessage,
    bool needRefreshFromNetworkOnInit = false,
    bool isNeedWatchLocalRepositoryForUpdates =
        true, // todo: remove hack. Dont init when bloc quickly disposed. Help
    //  improve performance in timeline unnecessary recreations
    bool delayInit = true,
  })  : _chatSubject = BehaviorSubject.seeded(chat),
        _lastMessageSubject = BehaviorSubject.seeded(lastChatMessage),
        super(
          needRefreshFromNetworkOnInit: needRefreshFromNetworkOnInit,
          isNeedWatchLocalRepositoryForUpdates:
              isNeedWatchLocalRepositoryForUpdates,
          delayInit: delayInit,
        ) {
    _logger.finest(() => 'PleromaChatBloc \n'
        ' chat ${chat.remoteId} \n'
        ' lastMessage $lastChatMessage');

    _chatSubject.disposeWith(this);
    _lastMessageSubject.disposeWith(this);
    _lastPublishedMessageSubject.disposeWith(this);
    onMessageLocallyHiddenStreamController.disposeWith(this);
  }

  @override
  void watchLocalRepositoryForUpdates() {
    chatRepository.watchByRemoteIdInAppType(chat.remoteId).listen(
          (updatedChat) {
        if (updatedChat != null) {
          _chatSubject.add(updatedChat);
        }
      },
    ).disposeWith(this);

    chatMessageRepository.watchChatLastChatMessage(chat: chat).listen(
          (lastMessage) {
        _logger.finest(() => 'watchChatLastChatMessage \n'
            ' chat ${chat.remoteId} \n'
            ' lastMessage $lastMessage');
        if (lastMessage != null) {
          _lastMessageSubject.add(lastMessage);

          if (lastMessage.isPendingStatePublishedOrNull) {
            _lastPublishedMessageSubject.add(lastMessage);
          }
        }
      },
    ).disposeWith(this);
  }

  @override
  Future internalAsyncInit() async {
    var chatLastChatMessage =
        await chatMessageRepository.getChatLastChatMessage(chat: chat);
    if (chatLastChatMessage != null) {
      if (!_lastMessageSubject.isClosed) {
        _lastMessageSubject.add(chatLastChatMessage);
      }

      if (chatLastChatMessage.isPendingStatePublishedOrNull) {
        _lastPublishedMessageSubject.add(chatLastChatMessage);
      } else {
        var lastPublishedChatMessage =
            await chatMessageRepository.getChatLastChatMessage(
          chat: chat,
          onlyPendingStatePublishedOrNull: true,
        );
        if (lastPublishedChatMessage != null) {
          if (!_lastPublishedMessageSubject.isClosed) {
            _lastPublishedMessageSubject.add(
              lastPublishedChatMessage,
            );
          }
        }
      }
    }
  }

  @override
  Future refreshFromNetwork() async {
    var remoteChat = await pleromaChatService.getChat(id: chat.remoteId);

    await accountRepository.batch((batch) {
      accountRepository.upsertChatRemoteAccount(
        remoteChat.account,
        chatRemoteId: remoteChat.id,
        batchTransaction: batch,
      );

      var lastMessage = remoteChat.lastMessage;
      if (lastMessage != null) {
        chatMessageRepository.upsertInRemoteTypeBatch(
          lastMessage,
          batchTransaction: batch,
        );
      }

      _updateByRemoteChat(
        remoteChat,
        batchTransaction: batch,
      );
    });
  }

  Future _updateByRemoteChat(
    IPleromaApiChat pleromaApiChat, {
    required Batch? batchTransaction,
  }) =>
      chatRepository.updateAppTypeByRemoteType(
        appItem: chat,
        remoteItem: pleromaApiChat,
        batchTransaction: batchTransaction,
      );

  static PleromaChatBloc createFromContext(
    BuildContext context, {
    required IPleromaChat chat,
    required IPleromaChatMessage? lastChatMessage,
    bool needRefreshFromNetworkOnInit = false,
  }) {
    return PleromaChatBloc(
      pleromaChatService: IPleromaApiChatService.of(context, listen: false),
      myAccountBloc: IMyAccountBloc.of(context, listen: false),
      chat: chat,
      lastChatMessage: lastChatMessage,
      needRefreshFromNetworkOnInit: needRefreshFromNetworkOnInit,
      chatRepository: IPleromaChatRepository.of(context, listen: false),
      chatMessageRepository:
          IPleromaChatMessageRepository.of(context, listen: false),
      accountRepository: IAccountRepository.of(context, listen: false),
    );
  }

  @override
  Future markAsRead() async {
    if (chat.unread > 0) {
      if (pleromaChatService.isApiReadyToUse) {
        var lastReadChatMessageId = lastChatMessage?.remoteId;
        if (lastReadChatMessageId == null) {
          var lastMessage = await chatMessageRepository.getChatLastChatMessage(
            chat: chat,
          );
          lastReadChatMessageId = lastMessage?.remoteId;
        }

        if (lastReadChatMessageId != null) {
          var updatedRemoteChat = await pleromaChatService.markChatAsRead(
            chatId: chat.remoteId,
            lastReadChatMessageId: lastReadChatMessageId,
          );

          await chatRepository.upsertInRemoteType(updatedRemoteChat);
        }
      } else {
        // TODO: mark as read once app receive network connection
        await chatRepository.markAsRead(chat: chat, batchTransaction: null);
      }
    }
  }

  @override
  bool get isCountInUnreadSupported => true;

  @override
  Future deleteMessages(List<IChatMessage> chatMessages) async {
    // create queue instead of parallel requests to avoid throttle limit on server
    for (var chatMessage in chatMessages) {
      var remoteId = chatMessage.remoteId;
      if (chatMessage.isPendingStatePublishedOrNull) {
        await pleromaChatService.deleteChatMessage(
          chatId: chat.remoteId,
          chatMessageRemoteId: remoteId,
        );
      }

      await chatMessageRepository.markChatMessageAsDeleted(
        chatMessageRemoteId: remoteId,
      );
    }
  }

  @override
  Future performActualDelete() {
    throw UnsupportedError('It is not possible to delete pleroma chat');
  }

  @override
  // todo: refactor
  // ignore: long-method
  Future postMessage({
    required IPleromaApiChatMessageSendData pleromaApiChatMessageSendData,
    required IPleromaApiMediaAttachment?
        pleromaApiChatMessageSendDataMediaAttachment,
    required IPleromaChatMessage? oldPendingFailedPleromaChatMessage,
  }) async {
    DbChatMessage dbChatMessage;
    int? localChatMessageId;

    localChatMessageId = oldPendingFailedPleromaChatMessage?.localId;
    if (oldPendingFailedPleromaChatMessage != null &&
        localChatMessageId != null) {
      dbChatMessage =
          oldPendingFailedPleromaChatMessage.toDbChatMessage().copyWith(
                id: localChatMessageId,
              );

      pleromaApiChatMessageSendData = pleromaApiChatMessageSendData.copyWith(
        idempotencyKey: dbChatMessage.wasSentWithIdempotencyKey,
      );

      await chatMessageRepository.updateByDbIdInDbType(
        dbId: localChatMessageId,
        dbItem: dbChatMessage.copyWith(
          pendingState: PendingState.pending,
        ),
        batchTransaction: null,
      );
    } else {
      var createdAt = DateTime.now();
      var fakeUniqueRemoteRemoteId = generateUniquePleromaApiFakeId();

      dbChatMessage = DbChatMessage(
        id: null,
        remoteId: fakeUniqueRemoteRemoteId,
        chatRemoteId: chat.remoteId,
        accountRemoteId: myAccountBloc.account.remoteId,
        createdAt: createdAt,
        content: pleromaApiChatMessageSendData.content,
        emojis: null,
        mediaAttachment: pleromaApiChatMessageSendDataMediaAttachment
            ?.toPleromaApiMediaAttachment(),
        card: null,
        pendingState: PendingState.pending,
        // ignore: no-equal-arguments
        oldPendingRemoteId: fakeUniqueRemoteRemoteId,
        deleted: false,
        hiddenLocallyOnDevice: false,
        wasSentWithIdempotencyKey: null,
      );
      localChatMessageId = await chatMessageRepository.insertInDbType(
        dbChatMessage,
        mode: null,
      );

      pleromaApiChatMessageSendData = pleromaApiChatMessageSendData.copyWith(
        idempotencyKey: fakeUniqueRemoteRemoteId,
      );
    }

    try {
      var pleromaChatMessage = await pleromaChatService.sendMessage(
        chatId: chat.remoteId,
        data: pleromaApiChatMessageSendData,
      );
      onMessageLocallyHiddenStreamController.add(
        DbPleromaChatMessagePopulatedWrapper(
          dbChatMessagePopulated: DbChatMessagePopulated(
            dbChatMessage: dbChatMessage,
            // todo: rework
            dbAccount: myAccountBloc.myAccount!.toDbAccount(),
          ),
        ),
      );

      await chatMessageRepository.batch((batch) {
        chatMessageRepository.updateByDbIdInDbType(
          dbId: localChatMessageId!,
          dbItem: dbChatMessage.copyWith(
            hiddenLocallyOnDevice: true,
            pendingState: PendingState.published,
          ),
          batchTransaction: batch,
        );

        chatMessageRepository.upsertInRemoteTypeBatch(
          pleromaChatMessage,
          batchTransaction: batch,
        );
      });
    } catch (e, stackTrace) {
      _logger.warning(() => 'postMessage error', e, stackTrace);
      await chatMessageRepository.updateByDbIdInDbType(
        dbId: localChatMessageId,
        dbItem: dbChatMessage.copyWith(
          pendingState: PendingState.fail,
        ),
        batchTransaction: null,
      );
      rethrow;
    }
  }

  @override
  Future deleteMessage({
    required IPleromaChatMessage? pleromaChatMessage,
  }) async {
    if (pleromaChatMessage!.isPendingStatePublishedOrNull) {
      await pleromaChatService.deleteChatMessage(
        chatMessageRemoteId: pleromaChatMessage.remoteId,
        chatId: pleromaChatMessage.chatRemoteId,
      );

      await chatMessageRepository.markChatMessageAsDeleted(
        chatMessageRemoteId: pleromaChatMessage.remoteId,
      );
    } else {
      await chatMessageRepository.markChatMessageAsHiddenLocallyOnDevice(
        chatMessageLocalId: pleromaChatMessage.localId!,
      );
      onMessageLocallyHiddenStreamController.add(pleromaChatMessage);
    }
  }

  @override
  IPleromaChatMessage? get lastPublishedChatMessage =>
      _lastPublishedMessageSubject.valueOrNull;

  @override
  bool get isDeletePossible => false;
}
