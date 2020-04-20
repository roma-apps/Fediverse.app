import 'package:async/async.dart';
import 'package:fedi/refactored/dialog/progress/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IndeterminateProgressDialog extends ProgressDialog {
  IndeterminateProgressDialog(
      {String contentMessage,
      bool cancelable = false,
      @required CancelableOperation cancelableOperation})
      : super(
            contentMessage: contentMessage,
            cancelable: cancelable,
            cancelableOperation: cancelableOperation);

  @override
  Widget buildDialogContent(BuildContext context) =>
      buildDialogContentMessage(context);
}
