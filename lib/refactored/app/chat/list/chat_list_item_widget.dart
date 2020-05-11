import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/chat/avatar/chat_avatar_widget.dart';
import 'package:fedi/refactored/app/chat/chat_bloc.dart';
import 'package:fedi/refactored/app/chat/chat_page.dart';
import 'package:fedi/refactored/app/chat/message/chat_message_model.dart';
import 'package:fedi/refactored/app/chat/title/chat_title_widget.dart';
import 'package:fedi/refactored/app/ui/fedi_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListItemWidget extends StatelessWidget {
  ChatListItemWidget();

  @override
  Widget build(BuildContext context) {
    var chatBloc = IChatBloc.of(context, listen: true);

    return GestureDetector(
      onTap: () {
        goToChatPage(context, chat: chatBloc.chat);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ChatAvatarWidget(),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: buildChatPreview(context, chatBloc),
                ),
              ],
            ),
            buildGoToChatButton(context, chatBloc),
          ],
        ),
      ),
    );
  }

  Column buildChatPreview(BuildContext context, IChatBloc chatBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ChatTitleWidget(),
        buildLastMessageText(context, chatBloc),
      ],
    );
  }

  IconButton buildGoToChatButton(BuildContext context, IChatBloc chatBloc) {
    return IconButton(
      icon: Icon(Icons.chevron_right),
      tooltip: AppLocalizations.of(context).tr("app.chat."
          ".action.more"),
      onPressed: () {
        goToChatPage(context,
            chat: chatBloc.chat);
      },
    );
  }

  Widget buildLastMessageText(BuildContext context, IChatBloc chatBloc) {
    return StreamBuilder<IChatMessage>(
        stream: chatBloc.lastChatMessageStream,
        builder: (context, snapshot) {
          var lastMessage = snapshot.data;

          if (lastMessage == null) {
            return SizedBox.shrink();
          }

          // todo: handle emojis
          return Text(
            lastMessage.content,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16,
              color: FediColors.mediumGrey,
            ),
          );
        });
  }
}
