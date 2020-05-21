import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/chat/chat_bloc.dart';
import 'package:fedi/app/ui/fedi_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatTitleWidget extends StatelessWidget {
  final TextStyle textStyle;

  const ChatTitleWidget(
      {this.textStyle = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: FediColors.darkGrey)});

  @override
  Widget build(BuildContext context) {
    var chatBloc = IChatBloc.of(context, listen: false);

    return StreamBuilder<List<IAccount>>(
        stream: chatBloc.accountsStream,
        builder: (context, snapshot) {
          var accounts = snapshot.data;

          if (accounts?.isNotEmpty != true) {
            return SizedBox.shrink();
          }
          var accountsText = accounts.map((account) => account.acct).join(", ");
          return StreamBuilder<int>(
              stream: chatBloc.unreadCountStream,
              initialData: chatBloc.unreadCount,
              builder: (context, snapshot) {
                var unreadCount = snapshot.data;

                var finalText;

                if (unreadCount > 0) {
                  finalText = "$accountsText ($unreadCount)";
                } else {
                  finalText = accountsText;
                }

                return Text(
                  finalText,
                  style: textStyle,
                );
              });
        });
  }
}
