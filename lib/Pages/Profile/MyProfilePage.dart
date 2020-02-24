import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/Pages/Timeline/StatusDetail.dart';
import 'package:fedi/Pleroma/visibility/pleroma_visibility_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fedi/Pages/Profile/EditProfile.dart';
import 'package:fedi/Pages/Profile/ProfileHeader.dart';
import 'package:fedi/Pages/Timeline/TimelineCell.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Accounts.dart';
import 'package:fedi/Pleroma/account/pleroma_account_model.dart';
import 'package:fedi/Pleroma/status/pleroma_status_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyProfilePage extends StatefulWidget {
  final List<IPleromaStatus> statuses = <IPleromaStatus>[];
  @override
  State<StatefulWidget> createState() {
    return _MyProfilePage();
  }
}

class _MyProfilePage extends State<MyProfilePage> {
  IPleromaAccount myAccount;

  void initState() {
    super.initState();
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => fetchStatuses(context));
    }
  }

  void fetchStatuses(BuildContext context) {
    if (widget.statuses.length == 0) {
      _refreshController.requestRefresh();
    }
  }

  void editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile(updated)),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  viewStatusDetail(IPleromaStatus status) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusDetail(
          status: status,
        ),
        settings: RouteSettings(name: "/StatusDetail"),
      ),
    );
  }

  void _onRefresh() async {
    refreshAccount();
    // if failed,use refreshFailed()
    CurrentInstance.instance.currentClient
        .run(
            path: Accounts.getAccountStatuses(
                userId: CurrentInstance.instance.currentAccount.id,
                minId: "",
                maxId: "",
                sinceId: "",
                limit: "80"),
            method: HTTPMethod.GET)
        .then((response) {
      List<IPleromaStatus> newStatuses = PleromaStatus.listFromJsonString
        (response
          .body);
      newStatuses.removeWhere((status) {
        return status.visibilityPleroma == PleromaVisibility.DIRECT;
      });
      widget.statuses.clear();
      widget.statuses.addAll(newStatuses);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  refreshAccount() {
    CurrentInstance.instance.currentAccount.refreshAccount().then((response) {
      setState(() {});
    });
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    var lastId = "";
    IPleromaStatus lastStatus = widget.statuses.last;
    if (lastStatus != null) {
      lastId = lastStatus.id;
    }

    CurrentInstance.instance.currentClient
        .run(
            path: Accounts.getAccountStatuses(
                userId: CurrentInstance.instance.currentAccount.id,
                minId: "",
                maxId: lastId,
                sinceId: "",
                limit: "80"),
            method: HTTPMethod.GET)
        .then((response) {
      List<IPleromaStatus> newStatuses = PleromaStatus.listFromJsonString(response.body);
      newStatuses.removeWhere((status) {
        return status.visibilityPleroma == PleromaVisibility.DIRECT;
      });
      widget.statuses.addAll(newStatuses);
      if (mounted) setState(() {});
      _refreshController.loadComplete();
    }).catchError((error) {
      if (mounted) setState(() {});
      _refreshController.loadFailed();
    });
  }

  updated(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: PageStorageKey<String>("MAINTAB"),
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
                AppLocalizations.of(context).tr("profile.my.update.up_to_date"),
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
                  AppLocalizations.of(context).tr("profile.my.update.unable_to_fetch"),
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
            body = Text(
              AppLocalizations.of(context).tr("profile.my.update.failed"),);
          } else {
            body = Text(
              AppLocalizations.of(context).tr("profile.my.update.no_more_data"),
            );
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
        itemBuilder: (BuildContext context, int index) {
          print("rebuilding the list $index");
          if (index == 0) {
            return ProfileHeader(
              profileAccount: CurrentInstance.instance.currentAccount,
              editAccount: editProfile,
            );
          } else {
            return TimelineCell(
              widget.statuses[index - 1],
              viewStatusContext: viewStatusDetail,
              showCommentBtn: true,
            );
          }
        },
        itemCount: (widget.statuses.length + 1),
      ),
    );
  }
}
