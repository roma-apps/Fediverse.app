import 'package:fedi/app/auth/instance/auth_instance_model.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/auth/instance/list/auth_instance_list_bloc.dart';
import 'package:fedi/app/chat/conversation/current/conversation_chat_current_bloc.dart';
import 'package:fedi/app/chat/pleroma/current/pleroma_chat_current_bloc.dart';
import 'package:fedi/app/notification/go_to_notification_extension.dart';
import 'package:fedi/app/notification/push/notification_push_loader_bloc.dart';
import 'package:fedi/app/notification/push/notification_push_loader_model.dart';
import 'package:fedi/app/push/notification/handler/notifications_push_handler_bloc.dart';
import 'package:fedi/app/push/notification/handler/notifications_push_handler_model.dart';
import 'package:fedi/app/push/notification/rich/rich_notifications_service_background_message_impl.dart';
import 'package:fedi/app/toast/handler/toast_handler_bloc.dart';
import 'package:fedi/app/toast/handling_type/toast_handling_type_model.dart';
import 'package:fedi/app/toast/settings/local_preferences/global/global_toast_settings_local_preference_bloc.dart';
import 'package:fedi/app/toast/settings/local_preferences/instance/instance_toast_settings_local_preference_bloc_impl.dart';
import 'package:fedi/app/toast/settings/toast_settings_bloc.dart';
import 'package:fedi/app/toast/settings/toast_settings_bloc_impl.dart';
import 'package:fedi/app/toast/toast_service.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

final _logger = Logger('toast_handler_bloc_impl.dart');

class ToastHandlerBloc extends DisposableOwner implements IToastHandlerBloc {
  static ToastHandlerBloc createFromContext(
    BuildContext context,
    IToastService toastService,
  ) =>
      ToastHandlerBloc(
        context: context,
        toastService: toastService,
        authInstanceListBloc: IAuthInstanceListBloc.of(context, listen: false),
        currentAuthInstanceBloc:
            ICurrentAuthInstanceBloc.of(context, listen: false),
        notificationsPushHandlerBloc:
            INotificationsPushHandlerBloc.of(context, listen: false),
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
            IGlobalToastSettingsLocalPreferenceBloc.of(context, listen: false),
        localizationContext: S.of(context),
      );

  AuthInstance? get currentInstance => currentAuthInstanceBloc.currentInstance;

  // TODO: remove context field?
  final BuildContext context;
  final IToastService toastService;
  final IAuthInstanceListBloc authInstanceListBloc;
  final ICurrentAuthInstanceBloc currentAuthInstanceBloc;
  final ILocalPreferencesService localPreferencesService;
  final IToastSettingsBloc currentInstanceToastSettingsBloc;
  final INotificationsPushHandlerBloc notificationsPushHandlerBloc;
  final IConversationChatCurrentBloc currentInstanceConversationChatCurrentBloc;
  final IPleromaChatCurrentBloc currentInstancePleromaChatCurrentBloc;
  final INotificationPushLoaderBloc currentInstanceNotificationPushLoaderBloc;
  final IGlobalToastSettingsLocalPreferenceBloc
      globalToastSettingsLocalPreferencesBloc;
  final S localizationContext;

  ToastHandlerBloc({
    required this.context,
    required this.toastService,
    required this.currentAuthInstanceBloc,
    required this.authInstanceListBloc,
    required this.notificationsPushHandlerBloc,
    required this.localPreferencesService,
    required this.currentInstanceToastSettingsBloc,
    required this.currentInstanceConversationChatCurrentBloc,
    required this.currentInstancePleromaChatCurrentBloc,
    required this.currentInstanceNotificationPushLoaderBloc,
    required this.globalToastSettingsLocalPreferencesBloc,
    required this.localizationContext,
  }) {
    notificationsPushHandlerBloc.addRealTimeHandler(handlePush);
    addDisposable(CustomDisposable(
        () async {
          notificationsPushHandlerBloc.removeRealTimeHandler(handlePush);
        },
      ),
    );

    currentInstanceNotificationPushLoaderBloc
        .handledNotificationsStream
        .listen(
          (handledNotification) {
        _handleCurrentInstanceNotification(handledNotification);
      },
    ).disposeWith(this);
  }

  Future<bool> handlePush(
    NotificationsPushHandlerMessage notificationsPushHandlerMessage,
  ) async {
    var pleromaPushMessage = notificationsPushHandlerMessage.body;
    var isForCurrentInstance = currentInstance!.isInstanceWithHostAndAcct(
      host: pleromaPushMessage.server,
      acct: pleromaPushMessage.account,
    );

    if (!isForCurrentInstance) {
      await _handleNonCurrentInstancePushMessage(
        notificationsPushHandlerMessage,
      );
    }
    // else {
    // current instance push messages handled
    // via currentInstanceNotificationPushLoaderBloc
    // and _handleCurrentInstanceNotification
    // }

    return false;
  }

  void _handleCurrentInstanceNotification(
    NotificationPushLoaderNotification handledNotification,
  ) {
    var pushHandlerMessage =
        handledNotification.notificationsPushHandlerMessage;
    var pleromaPushMessage = pushHandlerMessage.body;

    var notificationType = pleromaPushMessage.notificationType;

    var pleromaNotificationType =
        notificationType.toPleromaApiNotificationType();
    var enabled = currentInstanceToastSettingsBloc
        .isNotificationTypeEnabled(pleromaNotificationType);

    var isEnabledWhenInstanceSelected = currentInstanceToastSettingsBloc
        .handlingType.isEnabledWhenInstanceSelected;
    _logger.finest(() => 'handleCurrentInstancePush '
        'pleromaNotificationType $pleromaNotificationType \n'
        'isEnabledWhenInstanceSelected $isEnabledWhenInstanceSelected \n'
        'enabled $enabled');

    if (enabled && isEnabledWhenInstanceSelected) {
      bool isNeedShowToast;

      var notification = handledNotification.notification;

      if (notification.isContainsChat) {
        isNeedShowToast =
            currentInstancePleromaChatCurrentBloc.currentChat?.remoteId !=
                notification.chatRemoteId;
      } else if (notification.isContainsStatus) {
        var pleromaDirectConversationId =
            notification.status!.pleromaDirectConversationId;
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

      _logger.finest(() => 'handleCurrentInstancePush '
          'isNeedShowToast $isNeedShowToast');

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
    required NotificationsPushHandlerMessage pushHandlerMessage,
    required VoidCallback onClick,
  }) {
    if (pushHandlerMessage.pushMessage.isLaunch) {
      return;
    }

    var pleromaPushMessage = pushHandlerMessage.body;

    var acctAtHost =
        '${pleromaPushMessage.account}@${pleromaPushMessage.server}';
    var notification = pushHandlerMessage.pushMessage.notification;
    if (notification != null) {
      var title = '$acctAtHost ${notification.title}';
      var body = notification.body;
      toastService.showInfoToast(
        context: context,
        title: title,
        content: body,
        onClick: onClick,
      );
    } else {
      var pleromaApiNotification =
          pushHandlerMessage.body.pleromaApiNotification!;
      var calculatedTitle = calculatePleromaApiNotificationPushTitle(
        localizationContext: localizationContext,
        pleromaApiNotification: pleromaApiNotification,
      );
      var calculatedBody = calculatePleromaApiNotificationPushBody(
        localizationContext: localizationContext,
        pleromaApiNotification: pleromaApiNotification,
      );
      var title = '$acctAtHost $calculatedTitle';
      toastService.showInfoToast(
        context: context,
        title: title,
        content: calculatedBody,
        onClick: onClick,
      );
    }
  }

  Future _handleNonCurrentInstancePushMessage(
    NotificationsPushHandlerMessage notificationsPushHandlerMessage,
  ) async {
    var pleromaPushMessage = notificationsPushHandlerMessage.body;

    var notificationType = pleromaPushMessage.notificationType;

    var pleromaNotificationType =
        notificationType.toPleromaApiNotificationType();

    var instanceLocalPreferencesBloc = InstanceToastSettingsLocalPreferenceBloc(
      localPreferencesService,
      userAtHost: '${pleromaPushMessage.account}@${pleromaPushMessage.server}',
    );

    await instanceLocalPreferencesBloc.performAsyncInit();

    var toastSettingsBloc = ToastSettingsBloc(
      globalLocalPreferencesBloc: globalToastSettingsLocalPreferencesBloc,
      instanceLocalPreferencesBloc: instanceLocalPreferencesBloc,
    );

    var isEnabled =
        toastSettingsBloc.isNotificationTypeEnabled(pleromaNotificationType);

    var isEnabledWhenInstanceNotSelected = currentInstanceToastSettingsBloc
        .handlingType.isEnabledWhenInstanceNotSelected;

    _logger.finest(() => '_handleNonCurrentInstancePushMessage '
        'pleromaNotificationType $pleromaNotificationType \n'
        'isEnabledWhenInstanceNotSelected $isEnabledWhenInstanceNotSelected \n'
        'isEnabled $isEnabled');

    if (isEnabled && isEnabledWhenInstanceNotSelected) {
      _showToast(
        pushHandlerMessage: notificationsPushHandlerMessage,
        onClick: () async {
          var instanceByCredentials =
              authInstanceListBloc.findInstanceByCredentials(
            host: pleromaPushMessage.server,
            acct: pleromaPushMessage.account,
          );

          _logger.finest(() => '_handleNonCurrentInstancePushMessage '
              'instanceByCredentials $instanceByCredentials');

          if (instanceByCredentials != null) {
            await notificationsPushHandlerBloc
                .markAsLaunchMessage(notificationsPushHandlerMessage);
            await currentAuthInstanceBloc
                .changeCurrentInstance(instanceByCredentials);
          }
        },
      );
    }
  }
}
