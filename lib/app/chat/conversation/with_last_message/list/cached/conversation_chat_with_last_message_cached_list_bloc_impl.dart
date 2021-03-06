import 'package:fedi/app/chat/conversation/conversation_chat_model.dart';
import 'package:fedi/app/chat/conversation/repository/conversation_chat_repository.dart';
import 'package:fedi/app/chat/conversation/repository/conversation_chat_repository_model.dart';
import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_model.dart';
import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_repository.dart';
import 'package:fedi/app/chat/conversation/with_last_message/list/cached/conversation_chat_with_last_message_cached_list_bloc.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/conversation/pleroma_api_conversation_model.dart';
import 'package:fedi/pleroma/api/conversation/pleroma_api_conversation_service.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:logging/logging.dart';

var _logger =
    Logger('pleroma_chat_with_last_message_cached_list_bloc_impl.dart');

class ConversationChatWithLastMessageCachedListBloc
    extends IConversationChatWithLastMessageCachedListBloc {
  final IPleromaApiConversationService conversationChatService;
  final IConversationChatRepository conversationRepository;
  final IConversationChatWithLastMessageRepository
      chatWithLastMessageRepository;

  ConversationChatWithLastMessageCachedListBloc({
    required this.conversationChatService,
    required this.conversationRepository,
    required this.chatWithLastMessageRepository,
  });

  @override
  IPleromaApi get pleromaApi => conversationChatService;

  @override
  Future refreshItemsFromRemoteForPage({
    required int? limit,
    required IConversationChatWithLastMessage? newerThan,
    required IConversationChatWithLastMessage? olderThan,
  }) async {
    _logger.fine(() => 'start refreshItemsFromRemoteForPage \n'
        '\t newerThan = $newerThan'
        '\t olderThan = $olderThan');

    List<IPleromaApiConversation>? remoteConversations;

    remoteConversations = await conversationChatService.getConversations(
      pagination: PleromaApiPaginationRequest(
        maxId: olderThan?.chat.remoteId,
        sinceId: newerThan?.chat.remoteId,
        limit: limit,
      ),
    );

    await conversationRepository.upsertAllInRemoteType(
      remoteConversations,
      batchTransaction: null,
    );
  }

  @override
  Future<List<IConversationChatWithLastMessage>> loadLocalItems({
    required int? limit,
    required IConversationChatWithLastMessage? newerThan,
    required IConversationChatWithLastMessage? olderThan,
  }) async {
    _logger.finest(() => 'start loadLocalItems \n'
        '\t newerThan=$newerThan'
        '\t olderThan=$olderThan');

    var chats =
        await chatWithLastMessageRepository.getConversationsWithLastMessage(
      filters: null,
      pagination: RepositoryPagination<IConversationChat>(
        olderThanItem: olderThan?.chat,
        newerThanItem: newerThan?.chat,
        limit: limit,
      ),
      orderingTermData:
          ConversationRepositoryChatOrderingTermData.updatedAtDesc,
    );

    _logger.finer(() => 'finish loadLocalItems chats ${chats.length}');

    return chats;
  }

  @override
  Stream<List<IConversationChatWithLastMessage>> watchLocalItemsNewerThanItem(
    IConversationChatWithLastMessage? item,
  ) =>
      chatWithLastMessageRepository.watchConversationsWithLastMessage(
        filters: null,
        pagination: RepositoryPagination<IConversationChat>(
          newerThanItem: item?.chat,
        ),
        orderingTermData:
            ConversationRepositoryChatOrderingTermData.updatedAtDesc,
      );
}
