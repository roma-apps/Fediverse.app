import 'package:fedi/app/status/post/app_bar/post_status_app_bar_post_action.dart';
import 'package:fedi/app/status/post/new/new_post_status_bloc_impl.dart';
import 'package:fedi/app/status/post/post_status_bloc.dart';
import 'package:fedi/app/status/post/post_status_compose_widget.dart';
import 'package:fedi/app/status/post/post_status_model.dart';
import 'package:fedi/app/status/post/unsaved/post_status_unsaved_dialog.dart';
import 'package:fedi/app/ui/button/icon/fedi_dismiss_icon_button.dart';
import 'package:fedi/app/ui/page/app_bar/fedi_page_title_app_bar.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void _newPostStatusPageHandleBackPressed(
  BuildContext context,
  IPostStatusBloc postStatusBloc,
) {
  var isSomethingChanged = postStatusBloc.isAnyDataEntered;
  if (isSomethingChanged) {
    showPostStatusUnsavedDialog(context, postStatusBloc);
  } else {
    Navigator.pop(context);
  }
}

class NewPostStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var postStatusBloc = IPostStatusBloc.of(context, listen: false);

    return WillPopScope(
      // override back button
      onWillPop: () async {
        _newPostStatusPageHandleBackPressed(context, postStatusBloc);

        return true;
      },
      child: Scaffold(
        appBar: const NewPostStatusPageAppBar(),
        body: const _NewPostStatusPageBodyWidget(),
      ),
    );
  }

  const NewPostStatusPage();
}

class _NewPostStatusPageBodyWidget extends StatelessWidget {
  const _NewPostStatusPageBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _NewPostStatusPageComposeWidget(),
            ),
          ],
        ),
      );
}

class _NewPostStatusPageComposeWidget extends StatelessWidget {
  const _NewPostStatusPageComposeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const PostStatusComposeWidget(
        autofocus: true,
        goBackOnSuccess: true,
        expanded: true,
        maxLines: null,
        displayAccountAvatar: false,
        showPostAction: false,
        displaySubjectField: true,
      );
}

class NewPostStatusPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NewPostStatusPageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postStatusBloc = IPostStatusBloc.of(context);

    return FediPageTitleAppBar(
      title: S.of(context).app_status_post_new_title,
      leading: FediDismissIconButton(
        customOnPressed: () {
          _newPostStatusPageHandleBackPressed(context, postStatusBloc);
        },
      ),
      actions: [
        const PostStatusAppBarPostAction(),
      ],
    );
  }

  @override
  Size get preferredSize => FediPageTitleAppBar.calculatePreferredSize();
}

void goToNewPostStatusPageWithInitial(
  BuildContext context, {
  String? initialText,
  String? initialSubject,
  List<PleromaApiMediaAttachment>? initialMediaAttachments,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NewPostStatusBloc.provideToContextWithInitial(
        context,
        initialText: initialText,
        initialSubject: initialSubject,
        initialMediaAttachments: initialMediaAttachments,
        child: const NewPostStatusPage(),
      ),
    ),
  );
}

void goToNewPostStatusPage(
  BuildContext context, {
  required PostStatusData initialData,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NewPostStatusBloc.provideToContext(
        context,
        initialData: initialData,
        child: const NewPostStatusPage(),
      ),
    ),
  );
}
