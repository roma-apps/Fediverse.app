import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/notification/notification_bloc.dart';
import 'package:fedi/app/notification/notification_model.dart';
import 'package:fedi/app/notification/repository/notification_repository.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/mastodon/api/notification/mastodon_api_notification_model.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_model.dart';
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_model.dart';
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_service.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:moor/moor.dart';

import 'package:rxdart/rxdart.dart';

var _logger = Logger('notification_bloc_impl.dart');

class NotificationBloc extends DisposableOwner implements INotificationBloc {
  @override
  INotification get notification => _notificationSubject.value;

  @override
  Stream<INotification> get notificationStream =>
      _notificationSubject.stream.distinct();

  static NotificationBloc createFromContext(
    BuildContext context,
    INotification notification, {
    bool isNeedWatchLocalRepositoryForUpdates = true,
  }) =>
      NotificationBloc(
        pleromaNotificationService: IPleromaApiNotificationService.of(
          context,
          listen: false,
        ),
        notificationRepository: INotificationRepository.of(
          context,
          listen: false,
        ),
        notification: notification,
        needRefreshFromNetworkOnInit: false,
        isNeedWatchLocalRepositoryForUpdates:
            isNeedWatchLocalRepositoryForUpdates,
      );

  final BehaviorSubject<INotification> _notificationSubject;

  final IPleromaApiNotificationService pleromaNotificationService;
  final INotificationRepository notificationRepository;
  final bool isNeedWatchLocalRepositoryForUpdates;

  NotificationBloc({
    required this.pleromaNotificationService,
    required this.notificationRepository,
    required INotification notification,
    bool needRefreshFromNetworkOnInit = false,
    this.isNeedWatchLocalRepositoryForUpdates =
        true, // todo: remove hack. Dont init when bloc quickly disposed. Help
    //  improve performance in timeline unnecessary recreations
    bool delayInit = true,
  }) : _notificationSubject = BehaviorSubject.seeded(notification) {
    _notificationSubject.disposeWith(this);

    if (delayInit) {
      Future.delayed(Duration(seconds: 1), () {
        _init(
          notification,
          needRefreshFromNetworkOnInit,
        );
      });
    } else {
      _init(
        notification,
        needRefreshFromNetworkOnInit,
      );
    }
  }

  void _init(
    INotification notification,
    bool needRefreshFromNetworkOnInit,
  ) {
    if (!isDisposed) {
      if (isNeedWatchLocalRepositoryForUpdates) {
        notificationRepository
            .watchByRemoteIdInAppType(
          notification.remoteId,
        )
            .listen(
              (updatedNotification) {
            if (updatedNotification != null) {
              _notificationSubject.add(updatedNotification);
            }
          },
        ).disposeWith(this);
      }
      if (needRefreshFromNetworkOnInit) {
        refreshFromNetwork();
      }
    }
  }

  @override
  IAccount? get account => notification.account;

  @override
  Stream<IAccount?> get accountStream => notificationStream
      .map(
        (notification) => notification.account,
      )
      .distinct();

  @override
  IStatus? get status => notification.status;

  @override
  Stream<IStatus?> get statusStream => notificationStream
      .map(
        (notification) => notification.status,
      )
      .distinct();

  @override
  String? get chatMessageRemoteId => notification.chatMessageRemoteId;

  @override
  Stream<String?> get chatMessageRemoteIdStream => notificationStream.map(
        (notification) => notification.chatMessageRemoteId,
      );

  @override
  String? get chatRemoteId => notification.chatRemoteId;

  @override
  Stream<String?> get chatRemoteIdStream =>
      notificationStream.map((notification) => notification.chatRemoteId);

  @override
  IPleromaApiChatMessage? get chatMessage => notification.chatMessage;

  @override
  Stream<IPleromaApiChatMessage?> get chatMessageStream =>
      notificationStream.map((notification) => notification.chatMessage);

  @override
  DateTime get createdAt => notification.createdAt;

  @override
  Stream<DateTime> get createdAtStream => notificationStream
      .map((notification) => notification.createdAt)
      .distinct();

  @override
  bool get unread => notification.unread == true;

  @override
  Stream<bool> get unreadStream => notificationStream
      .map(
        (notification) => notification.unread == true,
      )
      .distinct();

  Future refreshFromNetwork() async {
    var remoteNotification = await pleromaNotificationService.getNotification(
      notificationRemoteId: remoteId,
    );

    await _updateByRemoteNotification(
      remoteNotification,
      batchTransaction: null,
    );
  }

  Future _updateByRemoteNotification(
    IPleromaApiNotification remoteNotification, {
    required Batch? batchTransaction,
  }) {
    return notificationRepository.updateNotificationByRemoteType(
      appItem: notification,
      remoteItem: remoteNotification,
      unread: notification.unread,
      batchTransaction: batchTransaction,
    );
  }

  @override
  Future dispose() {
    _logger.finest(() => 'dispose');

    return super.dispose();
  }

  @override
  String get remoteId => notification.remoteId;

  @override
  String get type => notification.type;

  @override
  MastodonApiNotificationType get typeMastodon => notification.typeAsMastodonApi;

  @override
  PleromaApiNotificationType get typePleroma => notification.typePleroma;

  @override
  Future dismiss() async {
    await pleromaNotificationService.dismissNotification(
      notificationRemoteId: notification.remoteId,
    );

    await notificationRepository.dismiss(
      notification: notification,
    );
  }

  @override
  Future markAsRead() async {
    await notificationRepository.markAsRead(
      notification: notification,
    );
    if (pleromaNotificationService.isPleroma) {
      // ignore: unawaited_futures
        pleromaNotificationService.markAsReadSingle(
          notificationRemoteId: notification.remoteId,
        );
    }
  }

  @override
  bool get dismissed => notification.dismissed;

  @override
  Stream<bool?> get dismissedStream => notificationStream.map(
        (notification) => notification.dismissed,
      );

  @override
  NotificationState get state => NotificationState(
        dismissed: dismissed,
        unread: unread,
      );

  @override
  Stream<NotificationState> get stateStream => Rx.combineLatest2(
        dismissedStream,
        unreadStream,
        (dynamic dismissed, dynamic unread) => NotificationState(
          dismissed: dismissed,
          unread: unread,
        ),
      ).distinct();
}
