import 'package:fedi/app/auth/instance/auth_instance_model.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/chat/conversation/current/conversation_chat_current_bloc.dart';
import 'package:fedi/app/chat/pleroma/current/pleroma_chat_current_bloc.dart';
import 'package:fedi/app/notification/go_to_notification_extension.dart';
import 'package:fedi/app/notification/push/notification_push_loader_bloc.dart';
import 'package:fedi/app/notification/push/notification_push_loader_model.dart';
import 'package:fedi/app/push/handler/push_handler_bloc.dart';
import 'package:fedi/app/push/handler/push_handler_model.dart';
import 'package:fedi/app/toast/handler/toast_handler_bloc.dart';
import 'package:fedi/app/toast/handling_type/toast_handling_type_model.dart';
import 'package:fedi/app/toast/settings/local_preferences/global/global_toast_settings_local_preferences_bloc.dart';
import 'package:fedi/app/toast/settings/local_preferences/instance/instance_toast_settings_local_preferences_bloc_impl.dart';
import 'package:fedi/app/toast/settings/toast_settings_bloc.dart';
import 'package:fedi/app/toast/settings/toast_settings_bloc_impl.dart';
import 'package:fedi/app/toast/toast_service.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';
import 'package:fedi/pleroma/notification/pleroma_notification_model.dart';
import 'package:fedi/pleroma/push/pleroma_push_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

final _logger = Logger("toast_handler_bloc_impl.dart");

class ToastHandlerBloc extends DisposableOwner implements IToastHandlerBloc {
  static ToastHandlerBloc createFromContext(
    BuildContext context,
    IToastService toastService,
  ) =>
      ToastHandlerBloc(
        context: context,
        toastService: toastService,
        currentInstance:
            ICurrentAuthInstanceBloc.of(context, listen: false).currentInstance,
        pushHandlerBloc: IPushHandlerBloc.of(context, listen: false),
        localPreferencesService:
            ILocalPreferencesService.of(context, listen: false),
        currentInstanceToastSettingsBloc:
            IToastSettingsBloc.of(context, listen: false),
        currentInstanceConversationChatCurrentBloc:
            IConversationChatCurrentBloc.of(context, listen: false),
        currentInstancePleromaChatCurrentBloc:
            IPleromaChatCurrentBloc.of(context, listen: false),
        currentInstanceNotificationPushLoaderBloc:
            INotificationPushLoaderBloc.of(context, listen: false),
        globalToastSettingsLocalPreferencesBloc:
            IGlobalToastSettingsLocalPreferencesBloc.of(context, listen: false),
      );

  // TODO: remote context field?
  final BuildContext context;
  final IToastService toastService;
  final ILocalPreferencesService localPreferencesService;
  final IToastSettingsBloc currentInstanceToastSettingsBloc;
  final AuthInstance currentInstance;
  final IPushHandlerBloc pushHandlerBloc;
  final IConversationChatCurrentBloc currentInstanceConversationChatCurrentBloc;
  final IPleromaChatCurrentBloc currentInstancePleromaChatCurrentBloc;
  final INotificationPushLoaderBloc currentInstanceNotificationPushLoaderBloc;
  final IGlobalToastSettingsLocalPreferencesBloc
      globalToastSettingsLocalPreferencesBloc;

  ToastHandlerBloc({
    @required this.context,
    @required this.toastService,
    @required this.currentInstance,
    @required this.pushHandlerBloc,
    @required this.localPreferencesService,
    @required this.currentInstanceToastSettingsBloc,
    @required this.currentInstanceConversationChatCurrentBloc,
    @required this.currentInstancePleromaChatCurrentBloc,
    @required this.currentInstanceNotificationPushLoaderBloc,
    @required this.globalToastSettingsLocalPreferencesBloc,
  }) {
    pushHandlerBloc.addRealTimeHandler(handlePush);
    addDisposable(
      disposable: CustomDisposable(
        () async {
          pushHandlerBloc.removeRealTimeHandler(handlePush);
        },
      ),
    );

    addDisposable(
      streamSubscription: currentInstanceNotificationPushLoaderBloc
          .handledNotificationsStream
          .listen(
        (handledNotification) {
          _handleCurrentInstanceNotification(handledNotification);
        },
      ),
    );
  }

  Future<bool> handlePush(PushHandlerMessage pushHandlerMessage) async {
    PleromaPushMessageBody pleromaPushMessage = pushHandlerMessage.body;
    var isForCurrentInstance = currentInstance.isInstanceWithHostAndAcct(
        host: pleromaPushMessage.server, acct: pleromaPushMessage.account);

    if (!isForCurrentInstance) {
      _handleNonCurrentInstancePushMessage(pushHandlerMessage);
    } else {
      // current instance push messages handled
      // via currentInstanceNotificationPushLoaderBloc
      // and _handleCurrentInstanceNotification
    }

    return false;
  }

  void _handleCurrentInstanceNotification(
      NotificationPushLoaderNotification handledNotification) {
    var pushHandlerMessage = handledNotification.pushHandlerMessage;
    PleromaPushMessageBody pleromaPushMessage = pushHandlerMessage.body;

    var notificationType = pleromaPushMessage.notificationType;

    var pleromaNotificationType = notificationType.toPleromaNotificationType();
    var enabled = currentInstanceToastSettingsBloc
        .isNotificationTypeEnabled(pleromaNotificationType);

    var isEnabledWhenInstanceSelected = currentInstanceToastSettingsBloc
        .handlingType.isEnabledWhenInstanceSelected;
    _logger.finest(() => "handleCurrentInstancePush "
        "pleromaNotificationType $pleromaNotificationType \n"
        "isEnabledWhenInstanceSelected $isEnabledWhenInstanceSelected \n"
        "enabled $enabled");

    if (enabled && isEnabledWhenInstanceSelected) {
      bool isNeedShowToast;

      var notification = handledNotification.notification;

      if (notification.isContainsChat) {
        isNeedShowToast =
            currentInstancePleromaChatCurrentBloc.currentChat?.remoteId !=
                notification.chatRemoteId;
      } else if (notification.isContainsStatus) {
        var pleromaDirectConversationId =
            notification.status.pleromaDirectConversationId;
        if (pleromaDirectConversationId != null) {
          isNeedShowToast = currentInstanceConversationChatCurrentBloc
                  .currentChat?.remoteId !=
              pleromaDirectConversationId.toString();
        } else {
          isNeedShowToast = true;
        }
      } else {
        isNeedShowToast = true;
      }

      _logger.finest(() => "handleCurrentInstancePush "
          "isNeedShowToast $isNeedShowToast");

      if (isNeedShowToast) {
        _showToast(
          pushHandlerMessage: pushHandlerMessage,
          onClick: () {
            notification.goToRelatedPage(context);
          },
        );
      }
    }
  }

  void _showToast({
    @required PushHandlerMessage pushHandlerMessage,
    @required VoidCallback onClick,
  }) {
    PleromaPushMessageBody pleromaPushMessage = pushHandlerMessage.body;

    var title = "${pleromaPushMessage.account}@${pleromaPushMessage.server}"
        " "
        "${pushHandlerMessage.pushMessage.notification.title}";
    toastService.showInfoToast(
      context: context,
      title: title,
      content: pushHandlerMessage.pushMessage.notification.body,
      onClick: onClick,
    );
  }

  void _handleNonCurrentInstancePushMessage(
      PushHandlerMessage pushHandlerMessage) async {
    PleromaPushMessageBody pleromaPushMessage = pushHandlerMessage.body;

    var notificationType = pleromaPushMessage.notificationType;

    var pleromaNotificationType = notificationType.toPleromaNotificationType();

    var instanceLocalPreferencesBloc =
        InstanceToastSettingsLocalPreferencesBloc(localPreferencesService,
            userAtHost:
                "${pleromaPushMessage.account}@${pleromaPushMessage.server}");

    await instanceLocalPreferencesBloc.performAsyncInit();

    var toastSettingsBloc = ToastSettingsBloc(
      globalLocalPreferencesBloc: globalToastSettingsLocalPreferencesBloc,
      instanceLocalPreferencesBloc: instanceLocalPreferencesBloc,
    );

    var isEnabled =
        toastSettingsBloc.isNotificationTypeEnabled(pleromaNotificationType);

    var isEnabledWhenInstanceNotSelected = currentInstanceToastSettingsBloc
        .handlingType.isEnabledWhenInstanceNotSelected;

    _logger.finest(() => "_handleNonCurrentInstancePushMessage "
        "pleromaNotificationType $pleromaNotificationType \n"
        "isEnabledWhenInstanceNotSelected $isEnabledWhenInstanceNotSelected \n"
        "isEnabled $isEnabled");

    if (isEnabled && isEnabledWhenInstanceNotSelected) {
      _showToast(
        pushHandlerMessage: pushHandlerMessage,
      );
    }
  }
}
