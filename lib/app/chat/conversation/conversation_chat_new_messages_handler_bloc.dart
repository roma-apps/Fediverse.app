import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pleroma/api/conversation/pleroma_api_conversation_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IConversationChatNewMessagesHandlerBloc extends IDisposable {
  Future handleChatUpdate(IPleromaApiConversation conversation);

  static IConversationChatNewMessagesHandlerBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IConversationChatNewMessagesHandlerBloc>(
        context,
        listen: listen,
      );
}
