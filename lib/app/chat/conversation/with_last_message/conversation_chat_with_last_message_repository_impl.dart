import 'package:fedi/app/chat/conversation/conversation_chat_model.dart';
import 'package:fedi/app/chat/conversation/message/conversation_chat_message_model.dart';
import 'package:fedi/app/chat/conversation/repository/conversation_chat_repository.dart';
import 'package:fedi/app/chat/conversation/repository/conversation_chat_repository_model.dart';
import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_model.dart';
import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_repository.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:flutter/widgets.dart';

class ConversationChatWithLastMessageRepository extends AsyncInitLoadingBloc
    implements IConversationChatWithLastMessageRepository {
  final IConversationChatRepository conversationChatRepository;
  final IStatusRepository statusRepository;

  ConversationChatWithLastMessageRepository({
    @required this.conversationChatRepository,
    @required this.statusRepository,
  });

  @override
  Future internalAsyncInit() async {
    // nothing by now
  }

  @override
  Future<List<IConversationChatWithLastMessage>>
      getConversationsWithLastMessage({
    @required IConversationChat olderThan,
    @required IConversationChat newerThan,
    @required int limit,
    @required int offset,
    @required ConversationChatOrderingTermData orderingTermData,
  }) async {
    var chats = await conversationChatRepository.getConversations(
      filters: null,
      pagination: RepositoryPagination<IConversationChat>(
        olderThanItem: olderThan,
        newerThanItem: newerThan,
        limit: limit,
        offset: offset,
      ),
      orderingTermData: orderingTermData,
    );

    return await _createConversationWithLastMessageList(chats);
  }

  Future<List<ConversationChatWithLastMessageWrapper>>
      _createConversationWithLastMessageList(
          List<DbConversationChatWrapper> conversations) async {
    var chatLastStatusesMap = await statusRepository.getConversationsLastStatus(
        conversations: conversations);
    return chatLastStatusesMap.entries.map((entry) {
      var chat = entry.key;
      var lastChatStatus = entry.value;
      return ConversationChatWithLastMessageWrapper(
        chat: chat,
        lastChatMessage: ConversationChatMessageStatusAdapter(
          lastChatStatus,
        ),
      );
    }).toList();
  }

  @override
  Stream<List<IConversationChatWithLastMessage>>
      watchConversationsWithLastMessage({
    @required IConversationChat olderThan,
    @required IConversationChat newerThan,
    @required int limit,
    @required int offset,
    @required ConversationChatOrderingTermData orderingTermData,
  }) {
    return conversationChatRepository
        .watchConversations(
          filters: null,
          pagination: RepositoryPagination<IConversationChat>(
            olderThanItem: olderThan,
            newerThanItem: newerThan,
            limit: limit,
            offset: offset,
          ),
          orderingTermData: orderingTermData,
        )
        .asyncMap(
          (chats) => _createConversationWithLastMessageList(chats),
        );
  }
}
