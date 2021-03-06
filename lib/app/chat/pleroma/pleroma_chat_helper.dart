import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/async/pleroma/pleroma_async_operation_helper.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_model.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_page.dart';
import 'package:fedi/app/chat/pleroma/repository/pleroma_chat_repository.dart';
import 'package:fedi/app/toast/toast_service.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_service.dart';
import 'package:flutter/widgets.dart';

Future goToPleromaChatWithAccount({
  required BuildContext context,
  required IAccount account,
}) async {
  var chatRepository = IPleromaChatRepository.of(context, listen: false);
  var chat = await chatRepository.findByAccount(account: account);
  if (chat != null) {
    goToPleromaChatPage(context, chat: chat);
  } else {
    var isAccountAcceptsChatMessages =
        account.pleromaAcceptsChatMessages != false;
    if (isAccountAcceptsChatMessages) {
      var dialogResult = await PleromaAsyncOperationHelper
          .performPleromaAsyncOperation<IPleromaChat?>(
        context: context,
        asyncCode: () async {
          var pleromaChatService =
              IPleromaApiChatService.of(context, listen: false);

          var pleromaApiChat =
              await pleromaChatService.getOrCreateChatByAccountId(
            accountId: account.remoteId,
          );

          await chatRepository.upsertInRemoteType(pleromaApiChat);

          return await chatRepository.findByRemoteIdInAppType(pleromaApiChat.id);
        },
      );
      chat = dialogResult.result;
      if (chat != null) {
        goToPleromaChatPage(context, chat: chat);
      }
    } else {
      var toastService = IToastService.of(
        context,
        listen: false,
      );

      toastService.showErrorToast(
        context: context,
        title:
            S.of(context).app_chat_pleroma_account_notAcceptsChatMessages_toast,
      );
    }
  }
}
