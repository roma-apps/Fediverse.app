import 'package:fedi/generated/l10n.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/conversation/conversation_bloc.dart';
import 'package:fedi/app/conversation/status/context_api/conversation_status_list_context_api_bloc_impl.dart';
import 'package:fedi/app/conversation/status/conversation_api/conversation_status_list_conversation_api_bloc_impl.dart';
import 'package:fedi/app/conversation/status/conversation_status_list_widget.dart';
import 'package:fedi/app/conversation/status/list/cached/conversation_status_list_bloc_impl.dart';
import 'package:fedi/app/message/post_message_bloc.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc_impl.dart';
import 'package:fedi/app/status/pagination/list/status_cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/status/post/post_status_widget.dart';
import 'package:fedi/app/ui/async/fedi_async_init_loading_widget.dart';
import 'package:fedi/app/ui/divider/fedi_ultra_light_grey_divider.dart';
import 'package:fedi/app/ui/fedi_padding.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:fedi/ui/scroll/unfocus_on_scroll_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConversationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var conversationBloc = IConversationBloc.of(context, listen: true);
    return FediAsyncInitLoadingWidget(
        asyncInitLoadingBloc: conversationBloc,
        loadingFinishedBuilder: (context) {
          return DisposableProvider<IStatusCachedListBloc>(
            create: (context) {
              return _createStatusListBloc(context, conversationBloc);
            },
            child: StatusCachedPaginationBloc.provideToContext(
              context,
              child:
                  StatusCachedPaginationListWithNewItemsBloc.provideToContext(
                context,
                mergeNewItemsImmediately: true,
                child: _buildBody(context, conversationBloc),
                mergeOwnStatusesImmediately: false,
              ),
            ),
          );
        });
  }

  Widget _buildBody(
    BuildContext context,
    IConversationBloc conversationBloc,
  ) {
    var postMessageBloc = IPostMessageBloc.of(context, listen: false);
    return StreamBuilder<bool>(
        stream: postMessageBloc.isExpandedStream,
        initialData: postMessageBloc.isExpanded,
        builder: (context, snapshot) {
          var isPostMessageExpanded = snapshot.data;

          var postMessageWidget = const _ConversationPostStatusWidget();

          if (isPostMessageExpanded) {
            return postMessageWidget;
          } else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: UnfocusOnScrollAreaWidget(
                    child: Padding(
                      padding: FediPadding.horizontalBigPadding,
                      child: ConversationStatusListWidget(
                        key: PageStorageKey(
                            conversationBloc.conversation.remoteId),
                      ),
                    ),
                  ),
                ),
                const FediUltraLightGreyDivider(),
                postMessageWidget
              ],
            );
          }
        });
  }

  ConversationStatusListBloc _createStatusListBloc(
      BuildContext context, IConversationBloc conversationBloc) {
    var currentInstanceBloc =
        ICurrentAuthInstanceBloc.of(context, listen: false);

    if (currentInstanceBloc.currentInstance.isPleromaInstance) {
      // pleroma instances support loading by conversation id
      return ConversationStatusListConversationApiBloc.createFromContext(
          context,
          conversation: conversationBloc.conversation);
    } else {
      // mastodon instances support conversation
      // only by status context
      return ConversationStatusListContextApiBloc.createFromContext(context,
          conversation: conversationBloc.conversation,
          statusToFetchContext: conversationBloc.lastStatus);
    }
  }
}

class _ConversationPostStatusWidget extends StatelessWidget {
  const _ConversationPostStatusWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostStatusWidget(
      hintText: S.of(context).app_chat_post_field_content_hint,
    );
  }
}
