import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/Pages/Push/PushHelper.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Foundation/InstanceStorage.dart';
import 'package:fedi/Pleroma/visibility/pleroma_visibility_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Notification.dart'
    as NotificationRequest;
import 'package:fedi/Pleroma/Models/Notification.dart' as NotificationModel;
import 'NotificationCell.dart';
import 'package:fedi/Pleroma/account/pleroma_account_model.dart';
import 'package:fedi/Pleroma/status/pleroma_status_model.dart';

class Mentions extends StatefulWidget {
  final Function(IPleromaAccount) viewAccount;
  final Function(IPleromaStatus) viewStatusDetail;
  final List<NotificationModel.Notification> notifications = [];
  Mentions(this.viewAccount, this.viewStatusDetail, {Key key})
      : super(key: key);

  @override
  _Mentions createState() => _Mentions();
}

class _Mentions extends State<Mentions> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  get account => null;

  @override
  Widget build(BuildContext context) {
    return getSmartRefresher();
  }

  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => fetchStatuses(context));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PushHelper pushHelper = PushHelper.of(context, listen: false);
    if (pushHelper.notificationId != null) {
      loadPushNotification(context, pushHelper.notificationId);
    }
  }

  void fetchStatuses(BuildContext context) {
    _refreshController.requestRefresh();
    InstanceStorage.clearAccountAlert(account, "mention");
  }

  void _onRefresh() {
    print("ONREFRESH");
    // monitor network fetch
    // if failed,use refreshFailed()
    CurrentInstance.instance.currentClient
        .run(
            path: NotificationRequest.Notification.getMentionsNotifications(
                minId: "", maxId: "", sinceId: "", limit: "20"),
            method: HTTPMethod.GET)
        .then((response) {
      List<NotificationModel.Notification> newNotifications =
          NotificationModel.Notification.listFromJsonString(response.body);
      newNotifications.removeWhere((notification) {
        print(notification.status.visibilityPleroma);
        return notification.status.visibilityPleroma ==
                PleromaVisibility.PRIVATE ||
            notification.status.visibilityPleroma == PleromaVisibility.DIRECT;
      });
      if (mounted)
        setState(() {
          widget.notifications.clear();
          widget.notifications.addAll(newNotifications);
          _refreshController.refreshCompleted();
        });
    }).catchError((error) {
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() {
    print("ONLOAD");
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    var lastId = "";
    NotificationModel.Notification lastNotification = widget.notifications.last;
    if (lastNotification != null) {
      lastId = lastNotification.id;
    }

    CurrentInstance.instance.currentClient
        .run(
            path: NotificationRequest.Notification.getMentionsNotifications(
                minId: "", maxId: lastId, sinceId: "", limit: "400"),
            method: HTTPMethod.GET)
        .then((response) {
      List<NotificationModel.Notification> newNotifications =
          NotificationModel.Notification.listFromJsonString(response.body);
      newNotifications.removeWhere((notification) {
        print(notification.status.visibilityPleroma);
        return notification.status.visibilityPleroma ==
                PleromaVisibility.PRIVATE ||
            notification.status.visibilityPleroma == PleromaVisibility.DIRECT;
      });
      widget.notifications.addAll(newNotifications);
      if (mounted)
        setState(() {
          _refreshController.loadComplete();
        });
    }).catchError((error) {
      if (mounted) setState(() {});
      _refreshController.loadFailed();
    });
  }

  loadPushNotification(BuildContext context, String notificationId) {
    String getnotificationByid =
        NotificationRequest.Notification.getNotificationById(notificationId);
    CurrentInstance.instance.currentClient
        .run(path: getnotificationByid, method: HTTPMethod.GET)
        .then((response) {
      NotificationModel.Notification notification =
          NotificationModel.Notification.fromJson(json.decode(response.body));

      if (notification.type == "follow") {
        widget.viewAccount(notification.account);
      } else if (notification.type == "mention") {
        widget.viewStatusDetail(notification.status);
      }
    }).catchError((onError) {
      print("$onError");
    });
    PushHelper pushHelper = PushHelper.of(context, listen: false);
    pushHelper.notificationId = null;
    pushHelper.notifcationType = null;
  }

  Widget getSmartRefresher() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
          complete: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.done,
                color: Colors.grey,
              ),
              Container(
                width: 15.0,
              ),
              Text(
                AppLocalizations.of(context)
                    .tr("notifications.mentions.update.up_to_date"),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          failed: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              Container(
                width: 15.0,
              ),
              Text(
                  AppLocalizations.of(context)
                      .tr("notifications.mentions.update.unable_to_fetch"),
                  style: TextStyle(color: Colors.grey))
            ],
          )),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("");
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text(AppLocalizations.of(context)
                .tr("notifications.mentions.update.failed"));
          } else {
            body = Text(AppLocalizations.of(context)
                .tr("notifications.mentions.update.no_more_data"));
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
        itemBuilder: (c, i) => NotificationCell(
          widget.notifications[i],
          viewAccount: widget.viewAccount,
          viewStatusContext: widget.viewStatusDetail,
        ),
        itemCount: widget.notifications.length,
      ),
    );
  }
}
