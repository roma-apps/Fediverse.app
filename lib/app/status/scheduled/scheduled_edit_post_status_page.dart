import 'package:fedi/app/async/pleroma/pleroma_async_operation_helper.dart';
import 'package:fedi/app/status/post/app_bar/post_status_app_bar_post_action.dart';
import 'package:fedi/app/status/post/edit/edit_post_status_bloc_impl.dart';
import 'package:fedi/app/status/post/edit/edit_post_status_widget.dart';
import 'package:fedi/app/status/post/post_status_bloc.dart';
import 'package:fedi/app/status/post/post_status_model.dart';
import 'package:fedi/app/status/scheduled/scheduled_status_bloc.dart';
import 'package:fedi/app/ui/button/icon/fedi_dismiss_icon_button.dart';
import 'package:fedi/app/ui/page/app_bar/fedi_page_title_app_bar.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduledEditPostStatusPage extends StatelessWidget {
  final PostStatusDataCallback onBackPressed;

  ScheduledEditPostStatusPage({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // todo: refactor
        // ignore: unawaited_futures
        handleBackPressed(context);

        return true;
      },
      child: Scaffold(
        appBar: FediPageTitleAppBar(
          title: S.of(context).app_status_scheduled_edit_title,
          leading: FediDismissIconButton(
            customOnPressed: () {
              handleBackPressed(context);
            },
          ),
          actions: [
            const PostStatusAppBarPostAction(),
          ],
        ),
        body: const SafeArea(
          child: EditPostStatusWidget(),
        ),
      ),
    );
  }

  Future handleBackPressed(BuildContext context) async {
    var postStatusBloc = IPostStatusBloc.of(context, listen: false);
    await onBackPressed(
      postStatusBloc.calculateCurrentPostStatusData(),
    );
  }
}

void goToScheduledEditPostStatusPage(
  BuildContext context, {
  required IPostStatusData initialData,
  required VoidCallback successCallback,
}) {
  var scheduledStatusBloc = IScheduledStatusBloc.of(context, listen: false);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditPostStatusBloc.provideToContext(
        context,
        postStatusDataCallback: (IPostStatusData postStatusData) async {
          var dialogResult =
              await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
            context: context,
            asyncCode: () async {
              await scheduledStatusBloc.postScheduledPost(
                postStatusData.toPostStatusData(),
              );
            },
          );
          if (dialogResult.success) {
            successCallback();
            Navigator.of(context).pop();
          }

          return dialogResult.success;
        },
        child: ScheduledEditPostStatusPage(
          onBackPressed: (IPostStatusData postStatusData) async {
            Navigator.of(context).pop();

            return true;
          },
        ),
        initialData: initialData,
      ),
    ),
  );
}
