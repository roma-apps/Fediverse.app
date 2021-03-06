import 'package:fedi/app/chat/pleroma/message/list/cached/pleroma_chat_message_cached_list_bloc.dart';
import 'package:fedi/app/chat/pleroma/message/pleroma_chat_message_model.dart';
import 'package:fedi/app/chat/pleroma/message/repository/pleroma_chat_message_repository.dart';
import 'package:fedi/app/chat/pleroma/message/repository/pleroma_chat_message_repository_model.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_model.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_service.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

var _logger = Logger('pleroma_chat_message_cached_list_bloc_impl.dart');

class PleromaChatMessageCachedListBloc extends DisposableOwner
    implements IPleromaChatMessageCachedListBloc {
  final IPleromaApiChatService pleromaChatService;
  final IPleromaChatMessageRepository chatMessageRepository;
  final IPleromaChat chat;

  PleromaChatMessageRepositoryFilters
      get _pleromaChatMessageRepositoryFilters =>
          PleromaChatMessageRepositoryFilters(
            onlyInChats: [
              chat,
            ],
            onlyPendingStatePublishedOrNull: false,
            onlyNotDeleted: true,
            onlyNotHiddenLocallyOnDevice: true,
          );

  PleromaChatMessageCachedListBloc({
    required this.chat,
    required this.pleromaChatService,
    required this.chatMessageRepository,
  });

  @override
  IPleromaApi get pleromaApi => pleromaChatService;

  @override
  Future refreshItemsFromRemoteForPage({
    required int? limit,
    required IPleromaChatMessage? newerThan,
    required IPleromaChatMessage? olderThan,
  }) async {
    _logger.fine(() => 'start refreshItemsFromRemoteForPage \n'
        '\t chat = $chat'
        '\t newerThan = $newerThan'
        '\t olderThan = $olderThan');

    var remoteMessages = await pleromaChatService.getChatMessages(
      chatId: chat.remoteId,
      pagination: PleromaApiPaginationRequest(
        maxId: olderThan?.remoteId,
        sinceId: newerThan?.remoteId,
        limit: limit,
      ),
    );

    await chatMessageRepository.upsertAllInRemoteType(
      remoteMessages,
      batchTransaction: null,
    );
  }

  @override
  Future<List<IPleromaChatMessage>> loadLocalItems({
    required int? limit,
    required IPleromaChatMessage? newerThan,
    required IPleromaChatMessage? olderThan,
  }) async {
    _logger.finest(() => 'start loadLocalItems \n'
        '\t newerThan=$newerThan'
        '\t olderThan=$olderThan');

    var messages = await chatMessageRepository.findAllInAppType(
      filters: _pleromaChatMessageRepositoryFilters,
      pagination: RepositoryPagination(
        olderThanItem: olderThan,
        newerThanItem: newerThan,
        limit: limit,
      ),
      orderingTerms: [
        PleromaChatMessageRepositoryOrderingTermData.createdAtDesc,
      ],
    );

    _logger.finer(
      () => 'finish loadLocalItems for $chat messages ${messages.length}',
    );

    return messages;
  }

  @override
  Stream<List<IPleromaChatMessage>> watchLocalItemsNewerThanItem(
    IPleromaChatMessage? item,
  ) {
    return chatMessageRepository.watchFindAllInAppType(
      filters: _pleromaChatMessageRepositoryFilters,
      pagination: RepositoryPagination(
        newerThanItem: item,
      ),
      orderingTerms: [
        PleromaChatMessageRepositoryOrderingTermData.createdAtDesc,
      ],
    );
  }

  static PleromaChatMessageCachedListBloc createFromContext(
    BuildContext context, {
    required IPleromaChat chat,
  }) =>
      PleromaChatMessageCachedListBloc(
        chat: chat,
        pleromaChatService: IPleromaApiChatService.of(context, listen: false),
        chatMessageRepository:
            IPleromaChatMessageRepository.of(context, listen: false),
      );

  static Widget provideToContext(
    BuildContext context, {
    required IPleromaChat chat,
    required Widget child,
  }) {
    return DisposableProvider<IPleromaChatMessageCachedListBloc>(
      create: (context) => PleromaChatMessageCachedListBloc.createFromContext(
        context,
        chat: chat,
      ),
      child: child,
    );
  }
}
