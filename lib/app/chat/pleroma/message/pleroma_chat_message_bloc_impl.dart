import 'package:collection/collection.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/chat/message/chat_message_bloc_impl.dart';
import 'package:fedi/app/chat/pleroma/message/pleroma_chat_message_bloc.dart';
import 'package:fedi/app/chat/pleroma/message/pleroma_chat_message_model.dart';
import 'package:fedi/app/chat/pleroma/message/repository/pleroma_chat_message_repository.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_bloc.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_model.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_service.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easy_dispose/easy_dispose.dart';

class PleromaChatMessageBloc extends ChatMessageBloc
    implements IPleromaChatMessageBloc {
  static PleromaChatMessageBloc createFromContext(
    BuildContext context,
    IPleromaChatMessage chatMessage, {
    bool isNeedWatchLocalRepositoryForUpdates = true,
    bool delayInit = true,
  }) =>
      PleromaChatMessageBloc(
        pleromaChatService: IPleromaApiChatService.of(context, listen: false),
        pleromaAccountService:
            IPleromaApiAccountService.of(context, listen: false),
        chatMessageRepository:
            IPleromaChatMessageRepository.of(context, listen: false),
        accountRepository: IAccountRepository.of(context, listen: false),
        chatMessage: chatMessage,
        needRefreshFromNetworkOnInit: false,
        delayInit: delayInit,
        isNeedWatchLocalRepositoryForUpdates:
            isNeedWatchLocalRepositoryForUpdates,
        pleromaChatBloc: IPleromaChatBloc.of(
          context,
          listen: false,
        ),
      );

  final BehaviorSubject<IPleromaChatMessage> _chatMessageSubject;

  final IPleromaApiChatService pleromaChatService;
  final IPleromaApiAccountService pleromaAccountService;
  final IPleromaChatMessageRepository chatMessageRepository;
  final IAccountRepository accountRepository;
  final IPleromaChatBloc pleromaChatBloc;

  PleromaChatMessageBloc({
    required this.pleromaChatService,
    required this.pleromaAccountService,
    required this.chatMessageRepository,
    required this.accountRepository,
    required this.pleromaChatBloc,
    required IPleromaChatMessage chatMessage, // for better performance we dont
    // update
    // account too often
    bool needRefreshFromNetworkOnInit =
        false, // todo: remove hack. Dont init when bloc quickly disposed. Help
    //  improve performance in timeline unnecessary recreations
    bool delayInit = true,
    bool isNeedWatchLocalRepositoryForUpdates = true,
  })  : _chatMessageSubject = BehaviorSubject.seeded(chatMessage),
        super(
          isNeedWatchLocalRepositoryForUpdates:
              isNeedWatchLocalRepositoryForUpdates,
          needRefreshFromNetworkOnInit: needRefreshFromNetworkOnInit,
          delayInit: delayInit,
        ) {
    _chatMessageSubject.disposeWith(this);
  }

  @override
  void watchLocalRepositoryChanges() {
    chatMessageRepository
        .watchByRemoteIdInAppType(chatMessage.remoteId)
        .listen(
          (updatedChatMessage) {
        if (updatedChatMessage != null) {
          _chatMessageSubject.add(updatedChatMessage);
        }
      },
    ).disposeWith(this);

    var oldPendingRemoteId = chatMessage.oldPendingRemoteId;
    if (oldPendingRemoteId != null) {
      chatMessageRepository
          .watchByOldPendingRemoteId(oldPendingRemoteId)
          .listen(
            (updatedChatMessage) {
          if (updatedChatMessage != null) {
            _chatMessageSubject.add(updatedChatMessage);
          }
        },
      ).disposeWith(this);
    }
  }

  @override
  IPleromaChatMessage get chatMessage => _chatMessageSubject.value;

  @override
  Stream<IPleromaChatMessage> get chatMessageStream =>
      _chatMessageSubject.stream.distinct();

  @override
  IAccount? get account => chatMessage.account;

  @override
  Future refreshFromNetwork() async {
    throw 'not supported by API yet';
  }

  @override
  Future delete() => pleromaChatBloc.deleteMessage(
        pleromaChatMessage: chatMessage,
      );

  @override
  Future resendPendingFailed() {
    var mediaId = chatMessage.mediaAttachments?.singleOrNull?.id;

    var pleromaApiChatMessageSendData = PleromaApiChatMessageSendData(
      content: chatMessage.content,
      mediaId: mediaId,
      idempotencyKey: chatMessage.wasSentWithIdempotencyKey,
    );

    return pleromaChatBloc.postMessage(
      pleromaApiChatMessageSendData: pleromaApiChatMessageSendData,
      oldPendingFailedPleromaChatMessage: chatMessage,
      pleromaApiChatMessageSendDataMediaAttachment:
          chatMessage.mediaAttachments?.singleOrNull,
    );
  }

  @override
  String get accountRemoteId => chatMessage.accountRemoteId;

  @override
  Stream<String> get accountRemoteIdStream => chatMessageStream.map(
        (chatMessage) => chatMessage.accountRemoteId,
      );
}
