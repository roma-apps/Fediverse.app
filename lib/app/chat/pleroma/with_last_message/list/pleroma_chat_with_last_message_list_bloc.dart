import 'package:fedi/app/chat/pleroma/with_last_message/list/cached/pleroma_chat_with_last_message_cached_list_bloc.dart';
import 'package:fedi/app/chat/pleroma/with_last_message/pagination/list/pleroma_chat_with_last_message_pagination_list_with_new_items_bloc.dart';
import 'package:fedi/app/chat/pleroma/with_last_message/pagination/pleroma_chat_with_last_message_pagination_bloc.dart';
import 'package:fedi/app/chat/pleroma/with_last_message/pleroma_chat_with_last_message_model.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class IPleromaChatWithLastMessageListBloc extends IDisposable {
  static IPleromaChatWithLastMessageListBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IPleromaChatWithLastMessageListBloc>(
        context,
        listen: listen,
      );

  IPleromaChatWithLastMessageCachedListBloc get chatListBloc;

  IPleromaChatWithLastMessagePaginationBloc get chatPaginationBloc;

  IPaginationListBloc<PaginationPage<IPleromaChatWithLastMessage>,
      IPleromaChatWithLastMessage> get chatPaginationListBloc;

  IPleromaChatWithLastMessagePaginationListWithNewItemsBloc<
          CachedPaginationPage<IPleromaChatWithLastMessage>>
      get chatPaginationListWithNewItemsBloc;
}
