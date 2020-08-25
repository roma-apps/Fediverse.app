import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/async/pleroma_async_operation_helper.dart';
import 'package:fedi/app/chat/chat_page.dart';
import 'package:fedi/app/chat/repository/chat_repository.dart';
import 'package:fedi/pleroma/chat/pleroma_chat_service.dart';
import 'package:flutter/widgets.dart';

void goToChatWithAccount(
    {@required BuildContext context, @required IAccount account}) async {
  var chatRepository = IChatRepository.of(context, listen: false);
  var chat = await chatRepository.findByAccount(account: account);
  if (chat != null) {
    goToChatPage(context, chat: chat);
  } else {
    var dialogResult =
        await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
            context: context,
            asyncCode: () async {
              var pleromaChatService =
                  IPleromaChatService.of(context, listen: false);

              var remoteChat = await pleromaChatService
                  .getOrCreateChatByAccountId(accountId: account.remoteId);

              await chatRepository.upsertRemoteChat(remoteChat);

              return await chatRepository.findByRemoteId(remoteChat.id);
            });
    chat = dialogResult.result;
    if (chat != null) {
      goToChatPage(context, chat: chat);
    }
  }
}
