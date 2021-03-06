import 'package:fedi/app/chat/conversation/repository/conversation_chat_repository.dart';
import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_model.dart';
import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_repository.dart';
import 'package:fedi/app/chat/conversation/with_last_message/list/cached/conversation_chat_with_last_message_cached_list_bloc.dart';
import 'package:fedi/app/chat/conversation/with_last_message/list/cached/conversation_chat_with_last_message_cached_list_bloc_impl.dart';
import 'package:fedi/app/chat/conversation/with_last_message/list/conversation_chat_with_last_message_list_bloc.dart';
import 'package:fedi/app/chat/conversation/with_last_message/pagination/conversation_chat_with_last_message_pagination_bloc.dart';
import 'package:fedi/app/chat/conversation/with_last_message/pagination/conversation_chat_with_last_message_pagination_bloc_impl.dart';
import 'package:fedi/app/chat/conversation/with_last_message/pagination/list/conversation_chat_with_last_message_pagination_list_with_new_items_bloc.dart';
import 'package:fedi/app/chat/conversation/with_last_message/pagination/list/conversation_chat_with_last_message_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_bloc.dart';
import 'package:fedi/app/web_sockets/web_sockets_handler_manager_bloc.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:fedi/pleroma/api/conversation/pleroma_api_conversation_service.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:flutter/material.dart';

class ConversationChatWithLastMessageListBloc extends DisposableOwner
    implements IConversationChatWithLastMessageListBloc {
  @override
  // ignore: avoid-late-keyword
  late IConversationChatWithLastMessageCachedListBloc cachedListBloc;

  @override
  // ignore: avoid-late-keyword
  late IConversationChatWithLastMessagePaginationBloc paginationBloc;

  @override
  IPaginationListBloc<PaginationPage<IConversationChatWithLastMessage>,
          IConversationChatWithLastMessage>
      get chatPaginationListBloc => paginationListWithNewItemsBloc;

  @override
  // ignore: avoid-late-keyword
  late IConversationChatWithLastMessagePaginationListWithNewItemsBloc<
          CachedPaginationPage<IConversationChatWithLastMessage>>
      paginationListWithNewItemsBloc;

  final IConversationChatRepository conversationRepository;
  final IConversationChatWithLastMessageRepository
      conversationChatWithLastMessageRepository;

  final IPaginationSettingsBloc paginationSettingsBloc;

  ConversationChatWithLastMessageListBloc({
    required IPleromaApiConversationService conversationService,
    required this.conversationRepository,
    required this.paginationSettingsBloc,
    required this.conversationChatWithLastMessageRepository,
    required IWebSocketsHandlerManagerBloc webSocketsHandlerManagerBloc,
  }) : cachedListBloc = ConversationChatWithLastMessageCachedListBloc(
          conversationChatService: conversationService,
          chatWithLastMessageRepository:
              conversationChatWithLastMessageRepository,
          conversationRepository: conversationRepository,
        ) {

    paginationBloc = ConversationChatWithLastMessagePaginationBloc(
      paginationSettingsBloc: paginationSettingsBloc,
      listService: cachedListBloc,
      maximumCachedPagesCount: null,
    );

    paginationListWithNewItemsBloc =
        ConversationChatWithLastMessagePaginationListWithNewItemsBloc(
      paginationBloc: paginationBloc,
      cachedListBloc: cachedListBloc,
      mergeNewItemsImmediately: true,
    );

    cachedListBloc.disposeWith(this);
    paginationBloc.disposeWith(this);
    paginationListWithNewItemsBloc.disposeWith(this);
    webSocketsHandlerManagerBloc.listenConversationChannel(
      listenType: WebSocketsListenType.foreground,
    ).disposeWith(this);
  }

  static ConversationChatWithLastMessageListBloc createFromContext(
    BuildContext context,
  ) =>
      ConversationChatWithLastMessageListBloc(
        conversationRepository: IConversationChatRepository.of(
          context,
          listen: false,
        ),
        conversationService: IPleromaApiConversationService.of(
          context,
          listen: false,
        ),
        webSocketsHandlerManagerBloc: IWebSocketsHandlerManagerBloc.of(
          context,
          listen: false,
        ),
        conversationChatWithLastMessageRepository:
            IConversationChatWithLastMessageRepository.of(
          context,
          listen: false,
        ),
        paginationSettingsBloc: IPaginationSettingsBloc.of(
          context,
          listen: false,
        ),
      );
}
