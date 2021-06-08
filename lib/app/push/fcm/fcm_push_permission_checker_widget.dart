import 'package:fedi/app/config/config_service.dart';
import 'package:fedi/app/push/fcm/ask_fcm_push_permission_dialog.dart';
import 'package:fedi/app/push/fcm/declined_fcm_push_permission_dialog.dart';
import 'package:fedi/app/push/fcm/fcm_push_permission_checker_bloc.dart';
import 'package:fedi/app/ui/dialog/alert/fedi_base_alert_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

var _logger = Logger('fcm_push_permission_checker_widget.dart');

class FcmPushPermissionCheckerWidget extends StatefulWidget {
  final Widget child;

  const FcmPushPermissionCheckerWidget({
    required this.child,
  });

  @override
  _FcmPushPermissionCheckerWidgetState createState() =>
      _FcmPushPermissionCheckerWidgetState();
}

class _FcmPushPermissionCheckerWidgetState
    extends State<FcmPushPermissionCheckerWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    checkFcmPushPermission();
  }

  Future checkFcmPushPermission() async {
    var configService = IConfigService.of(context, listen: false);

    if (configService.pushFcmEnabled) {
      var fcmPushPermissionCheckerBloc =
          IFcmPushPermissionCheckerBloc.of(context, listen: false);

      var isNeedCheckPermission =
          fcmPushPermissionCheckerBloc.isNeedCheckPermission;
      _logger.finest(() => 'isNeedCheckPermission $isNeedCheckPermission');

      if (isNeedCheckPermission) {
        // todo: refactor
        // ignore: no-magic-number
        Future.delayed(
          // todo: refactor
          // ignore: no-magic-number
          Duration(milliseconds: 100),
          () async {
            // ignore: avoid-late-keyword
            late FediBaseAlertDialog askFcmPushPermissionDialog;
            askFcmPushPermissionDialog = createAskFcmPushPermissionDialog(
              context: context,
              yesAction: (context) async {
                await askFcmPushPermissionDialog.hide(context);
                var success =
                    await fcmPushPermissionCheckerBloc.checkAndSubscribe();
                if (!success) {
                  showDeclinedDialog(context);
                }
              },
              noAction: (context) {
                askFcmPushPermissionDialog.hide(context);
                fcmPushPermissionCheckerBloc.onCheckDismissed();
                showDeclinedDialog(context);
              },
            );

            await askFcmPushPermissionDialog.show(context);
          },
        );
      }
    }
  }

  void showDeclinedDialog(BuildContext context) {
    Future.delayed(
      // todo: refactor
      // ignore: no-magic-number
      Duration(milliseconds: 100),
      () {
        var declinedFcmPushPermissionDialog =
            createDeclinedFcmPushPermissionDialog(context: context);

        declinedFcmPushPermissionDialog.show(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
