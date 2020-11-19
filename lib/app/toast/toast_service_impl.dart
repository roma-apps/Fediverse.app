import 'package:fedi/app/toast/settings/toast_settings_bloc.dart';
import 'package:fedi/app/toast/toast_model.dart';
import 'package:fedi/app/toast/toast_service.dart';
import 'package:fedi/app/toast/toast_widget.dart';
import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/overlay_notification/overlay_notification_service.dart';
import 'package:flutter/widgets.dart';

class ToastService extends DisposableOwner implements IToastService {
  final IToastSettingsBloc toastSettingsBloc;
  final IOverlayNotificationService overlayNotificationService;

  ToastService({
    @required this.toastSettingsBloc,
    @required this.overlayNotificationService,
  });

  @override
  void showErrorToast({
    @required BuildContext context,
    @required String title,
    String content,
  }) {
    assert(title != null);
    overlayNotificationService.showNotification(
      child: ToastWidget(
        toastType: ToastType.error,
        title: title,
        content: content,
      ),
      slideDismissible: true,
      key: ValueKey(title),
      duration: Duration(seconds: 1),
    );
  }

  @override
  void showInfoToast({
    @required BuildContext context,
    @required String title,
    String content,
  }) {
    assert(title != null);
    overlayNotificationService.showNotification(
      child: ToastWidget(
        toastType: ToastType.info,
        title: title,
        content: content,
      ),
      slideDismissible: true,
      key: ValueKey(title),
      duration: Duration(seconds: 1),
    );
  }
}
