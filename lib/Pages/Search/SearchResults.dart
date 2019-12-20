import 'package:fedi/Pages/Profile/OtherAccount.dart';
import 'package:fedi/Pages/Timeline/AccountCell.dart';
import 'package:fedi/Pages/Timeline/StatusDetail.dart';
import 'package:fedi/Pages/Timeline/TimelineCell.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Search.dart';
import 'package:fedi/Pleroma/Models/Account.dart';
import 'package:fedi/Pleroma/Models/Results.dart';
import 'package:fedi/Pleroma/Models/Status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResults extends StatefulWidget {
  final TextEditingController searchController;
  final Results results = Results(accounts: [], statuses: []);

  SearchResults(this.searchController);
  @override
  State<StatefulWidget> createState() {
    return _SearchReults();
  }
}

class _SearchReults extends State<SearchResults> {
  void initState() {
    super.initState();
    widget.searchController.addListener(_onRefresh);
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => fetchStatuses(context));
    }
  }

  void fetchStatuses(BuildContext context) {
    if (widget.results.accounts.length == 0 &&
        widget.results.statuses.length == 0) {
      _refreshController.requestRefresh();
    }
  }

  viewAccount(Account account) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OtherAccount(account)),
    );
  }

  viewStatusDetail(Status status) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusDetail(
          status: status,
        ),
      ),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // if failed,use refreshFailed()
    CurrentInstance.instance.currentClient
        .run(
            path: Search.search(
              q: widget.searchController.text,
            ),
            method: HTTPMethod.GET)
        .then((response) {
      Results newResult = resultsFromJson(response.body);
      widget.results.accounts = newResult.accounts;
      widget.results.statuses = newResult.statuses;
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  viewStatus(Status status) {}
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
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
              "Everything up to date",
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
              "Unable to fetch data",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("No more Messages");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed! Click retry!");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
        itemBuilder: (c, i) {
          if (i < widget.results.accounts.length) {
            Account account = widget.results.accounts[i];
            return AccountCell(viewAccount, account);
          } else {
            var index = i - widget.results.accounts.length;
            Status status = widget.results.statuses[index];
            return TimelineCell(
              status,
              viewAccount: viewAccount,
              viewStatusContext: viewStatusDetail,
            );
          }
        },
        itemCount:
            (widget.results.accounts.length + widget.results.statuses.length),
      ),
    );
  }
}
