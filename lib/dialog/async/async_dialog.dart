import 'package:async/async.dart';
import 'package:fedi/app/ui/progress/fedi_indeterminate_progress_dialog.dart';
import 'package:fedi/dialog/async/async_dialog_model.dart';
import 'package:fedi/error/error_data_model.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';


Logger _logger = Logger('async_dialog.dart');

typedef ErrorDataBuilder = ErrorData? Function(
  BuildContext context,
  dynamic error,
  StackTrace stackTrace,
);

typedef ErrorCallback = void Function(
  BuildContext? context,
  ErrorData errorData,
);

// todo: refactor long-parameter-list, long-method
// ignore: long-parameter-list, long-method
Future<AsyncDialogResult<T?>> doAsyncOperationWithDialog<T>({
  required BuildContext context,
  required Future<T> Function() asyncCode,
  required ErrorCallback? errorCallback,
  String? contentMessage,
  List<ErrorDataBuilder> errorDataBuilders = const [],
  bool showDefaultErrorAlertDialogOnUnhandledError = true,
  bool showProgressDialog = true,
  bool cancelable = false,
}) async {
  T? result;
  var cancelableOperation =
      CancelableOperation<T>.fromFuture(asyncCode());

  // ignore: avoid-late-keyword
  FediIndeterminateProgressDialog? progressDialog;
  if (showProgressDialog) {
    progressDialog = FediIndeterminateProgressDialog(
      cancelable: cancelable,
      contentMessage: contentMessage,
      cancelableOperation: cancelableOperation,
    );
    // ignore: unawaited_futures
    progressDialog.show(context);
  }

  var error;
  ErrorData? errorData;

  var needRethrow = true;

  try {
    result = await cancelableOperation.valueOrCancellation(null);
  } catch (e, stackTrace) {
    error = e;
    for (var builder in errorDataBuilders) {
      errorData = builder(context, e, stackTrace);
      if (errorData != null) {
        needRethrow = false;
        break;
      }
    }

    if (errorData == null && showDefaultErrorAlertDialogOnUnhandledError) {
      errorData = ErrorData(
        titleCreator: (context) => S.of(context).dialog_error_title,
        contentCreator: (context) => S.of(context).dialog_error_content(
              error.toString(),
            ),
        stackTrace: null,
        error: null,
      );
    }

    if (needRethrow) {
      _logger.severe(
        () => 'rethrow error during '
            'doAsyncOperationWithFediDialog',
        error,
        stackTrace,
      );
    } else {
      _logger.warning(
        () => 'handled error during '
            'doAsyncOperationWithFediDialog',
        error,
        stackTrace,
      );
    }
  } finally {
    // ignore: unawaited_futures
    progressDialog?.hide(context);
  }

  // wait until progress dialog actually hides
  await Future.delayed(
    Duration(
      // ignore: no-magic-number
      milliseconds: 100,
    ),
  );

  AsyncDialogResult<T> dialogResult;
  if (progressDialog?.isCanceled == true) {
    dialogResult = AsyncDialogResult<T>.canceled();
    _logger.fine(() => 'canceled doAsyncOperationWithFediDialog');
  } else if (error != null) {
    if (errorData != null) {
      if (errorCallback != null) {
        errorCallback(context, errorData);
      }
    }

    if (needRethrow) {
      throw error;
    }
    dialogResult = AsyncDialogResult<T>.withError(error);
  } else {
    _logger.finest(() => 'success doAsyncOperationWithFediDialog =$result}');
    dialogResult = AsyncDialogResult<T>.success(result);
  }

  return dialogResult;
}
