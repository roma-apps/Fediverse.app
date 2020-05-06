import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/account/my/edit/edit_my_account_bloc.dart';
import 'package:fedi/refactored/app/account/my/edit/edit_my_account_bloc_impl.dart';
import 'package:fedi/refactored/app/account/my/edit/edit_my_account_widget.dart';
import 'package:fedi/refactored/app/async/pleroma_async_operation_button_builder_widget.dart';
import 'package:fedi/refactored/disposable/disposable_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

class EditMyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var editMyAccountBloc = IEditMyAccountBloc.of(context, listen: false);
    return WillPopScope(
      // override back button
      onWillPop: () async {
        handleBackPressed(context, editMyAccountBloc);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              handleBackPressed(context, editMyAccountBloc);
            },
          ),
          title: Text(
              AppLocalizations.of(context).tr("app.account.my.edit.title")),
          actions: <Widget>[
            StreamBuilder<bool>(
                stream: editMyAccountBloc.isSomethingChangedStream,
                initialData: editMyAccountBloc.isSomethingChanged,
                builder: (context, snapshot) {
                  var isSomethingChanged = snapshot.data;

                  return PleromaAsyncOperationButtonBuilderWidget(
                    showProgressDialog: true,
                    progressContentMessage: AppLocalizations.of(context)
                        .tr("app.status.post.dialog.async.content"),
                    asyncButtonAction: () async {
                      await editMyAccountBloc.submitChanges();
                      Navigator.pop(context);
                    },
                    errorAlertDialogBuilders: [
                      // todo: handle specific cases by error code
//                          (context, error) => SimpleAlertDialog(
//                          title: AppLocalizations.of(context)
//                              .tr("app.status.post.dialog.error.title"),
//                          content: AppLocalizations.of(context).tr(
//                              "app.status.post.dialog.error.content",
//                              args: [error.toString()]),
//                          context: context)
                    ],
                    builder: (BuildContext context, onPressed) {
                      return FlatButton(
                        child: Text(
                          AppLocalizations.of(context)
                              .tr("app.account.my.edit.action.save"),
                          style: TextStyle(
                              color: isSomethingChanged
                                  ? Colors.white
                                  : Colors.white70),
                        ),
                        onPressed: isSomethingChanged ? onPressed : null,
                      );
                    },
                  );
                }),
          ],
        ),
        body: EditMyAccountWidget(),
      ),
    );
  }

  void handleBackPressed(
      BuildContext context, IEditMyAccountBloc editMyAccountBloc) {
    if (editMyAccountBloc.isSomethingChanged) {
      alertUnsaved(context);
    } else {
      Navigator.pop(context);
    }
  }

  void alertUnsaved(BuildContext context) {
    showAlert(
      context: context,
      title: AppLocalizations.of(context)
          .tr("app.account.my.edit.unsaved.dialog.title"),
      //      body:
      // "",
      actions: [
        AlertAction(
          text: AppLocalizations.of(context)
              .tr("app.account.my.edit.unsaved.dialog.action.discard"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      cancelable: true,
    );
  }
}

void goToEditMyAccountPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => DisposableProvider<IEditMyAccountBloc>(
            create: (context) => EditMyAccountBloc.createFromContext(context),
            child: EditMyAccountPage())),
  );
}
