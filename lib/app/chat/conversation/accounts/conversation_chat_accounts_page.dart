import 'package:fedi/app/chat/accounts/chat_accounts_widget.dart';
import 'package:fedi/app/chat/chat_bloc.dart';
import 'package:fedi/app/chat/conversation/conversation_chat_bloc.dart';
import 'package:fedi/app/chat/conversation/conversation_chat_bloc_impl.dart';
import 'package:fedi/app/chat/conversation/conversation_chat_model.dart';
import 'package:fedi/app/ui/page/app_bar/fedi_page_title_app_bar.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationChatAccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FediPageTitleAppBar(
        title: S.of(context).app_chat_conversation_accounts_title,
      ),
      body: const SafeArea(
        child: ChatAccountsWidget(),
      ),
    );
  }

  const ConversationChatAccountsPage();
}

void goToConversationChatAccountsPage(
  BuildContext context,
  IConversationChat conversation,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DisposableProvider<IConversationChatBloc>(
        create: (context) => ConversationChatBloc.createFromContext(
          context,
          chat: conversation,
          lastChatMessage: null,
        ),
        child: ProxyProvider<IConversationChatBloc, IChatBloc>(
          update: (context, value, _) => value,
          child: const ConversationChatAccountsPage(),
        ),
      ),
    ),
  );
}
