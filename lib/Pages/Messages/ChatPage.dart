import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedi/Pages/Profile/OtherAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fedi/Pages/Push/PushHelper.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Status.dart' as StatusRequest;
import 'package:fedi/Pleroma/Models/Account.dart';
import 'package:fedi/Pleroma/Models/Context.dart';
import 'package:fedi/Pleroma/Models/Conversation.dart';
import 'package:fedi/Pleroma/Models/Status.dart';
import 'package:fedi/Views/Alert.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ChatCell.dart';
import 'Media/CaptureDMMedia.dart';

class ChatPage extends StatefulWidget {
  final Function refreshMesagePage;
  final Conversation conversation;
  final Account account;
  final Function refreshMasterList;
  ChatPage(
      {this.conversation,
      this.account,
      this.refreshMasterList,
      this.refreshMesagePage});

  @override
  State<StatefulWidget> createState() {
    return _ChatPage();
  }
}

class _ChatPage extends State<ChatPage> {
  var txtController = TextEditingController();
  List<Status> statuses = <Status>[];
  String title = "DM";
  bool backgroundCheckStatus = true;
  Account otherAccount;
  update() {
    widget.refreshMasterList();
    backgroundCheck();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.account != null) {
      otherAccount = widget.account;
    } else if (widget.conversation.accounts.length == 0) {
      otherAccount = widget.conversation.lastStatus.account;
    } else {
      otherAccount = getOtherAccount(widget.conversation.accounts);
    }
    print("OTHER ACCOUNT HERE");
    print(otherAccount);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              widget.refreshMesagePage();
              Navigator.of(context).pop();
            },
          ),
          title: GestureDetector(onTap:(){
            Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OtherAccount(otherAccount)),
    );

          },  child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: new BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: otherAccount.avatar,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth, child: Text(otherAccount.displayName)),
            ],
          ),),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.phone),
            //   onPressed: () {
            //     if (widget.account != null) {
            //       print(widget.account.url);
            //       String currentURL = "${widget.account.url}".split("/")[2];

            //       String client = "${widget.account.acct}@$currentURL";
            //       var peer;
            //       var peers = WebRTCManager.instance.peers;
            //       for (var i = 0; i < peers.length; i++) {
            //         print(peers[i]['name']);
            //         String name = peers[i]['name'];
            //         if (name.toLowerCase() == client.toLowerCase()) {
            //           peer = peers[i];
            //         }
            //       }

            //       WebRTCManager.instance.invitePeer(context, peer['id'], false);
            //     } else {
            //       var account = getOtherAccount(widget.conversation.accounts);

            //       String client = "${account.acct}";
            //       print(client);
            //       var peer;
            //       var peers = WebRTCManager.instance.peers;
            //       for (var i = 0; i < peers.length; i++) {
            //         String name = peers[i]['name'];
            //         if (name.toLowerCase() == client.toLowerCase()) {
            //           peer = peers[i];
            //           print(peer);
            //         }
            //       }

            //       WebRTCManager.instance.invitePeer(context, peer['id'], false);
            //     }
            //     WebRTCManager.instance.inCalling = true;

            //   },
            // ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: getMessageList(),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200, minHeight: 80),
              child: Padding(
                padding: EdgeInsets.all(
                    10), // only( bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: txtController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Message',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                right: 20,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.videocam,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CaptureDMMedia(0, mediaUploaded)));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CaptureDMMedia(1, mediaUploaded)));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CaptureDMMedia(2, mediaUploaded)));
                    },
                  ),
                  Spacer(),
                  OutlineButton(
                    child: Text(
                      "Send",
                      style: TextStyle(color: Colors.blue),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      print("sending");
                      if (statuses.length == 0) {
                        startNewConvo();
                      } else {
                        sendMessage();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      backgroundCheck();
    });
    if (widget.account != null) {
      title = "DM ${widget.account.acct}";
    }
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => fetchStatuses(context));
    }

    PushHelper.instance.notificationUpdater = update;
  }

  mediaUploaded(String id) {
    print("MY ID!!! $id");

    Navigator.of(context)
        .popUntil((route) => route.settings.name == "/ChatPage");

    if (statuses.length == 0) {
      startNewConvoWithAccatment(id);
    } else {
      sendMessageWithAttachment(id);
    }
  }

  void fetchStatuses(BuildContext context) {
    if (statuses.length == 0) {
      _refreshController.requestRefresh();
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  backgroundCheck() {
    if (this.mounted) {
      if (statuses.length == 0) {
        Future.delayed(const Duration(milliseconds: 5000), () {
          backgroundCheck();
        });
        return;
      }
    } else {
      return;
    }

    CurrentInstance.instance.currentClient
        .run(
            path: StatusRequest.Status.getStatusContext(statuses.first.id),
            method: HTTPMethod.GET)
        .then((response) {
      Context context = Context.fromJsonString(response.body);

      List<Status> templist = [];
      templist.addAll(context.ancestors);
      templist.add(widget.conversation.lastStatus);
      templist.addAll(context.descendants);
      if (statuses.length < templist.length) {
        statuses.clear();
        statuses.addAll(templist.reversed);
        if (mounted) setState(() {});
      }
      Future.delayed(const Duration(milliseconds: 5000), () {
        backgroundCheck();
      });
    }).catchError((error) {
      Future.delayed(const Duration(milliseconds: 5000), () {
        backgroundCheck();
      });
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  void _onRefresh() async {
    if (widget.conversation == null) {
      _refreshController.refreshCompleted();
      return;
    }
    // if failed,use refreshFailed()
    CurrentInstance.instance.currentClient
        .run(
            path: StatusRequest.Status.getStatusContext(
                widget.conversation.lastStatus.id),
            method: HTTPMethod.GET)
        .then((response) {
      Context context = Context.fromJsonString(response.body);
      statuses.clear();
      List<Status> templist = [];
      templist.addAll(context.ancestors);
      templist.add(widget.conversation.lastStatus);
      templist.addAll(context.descendants);
      statuses.addAll(templist.reversed);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  Widget getMessageList() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.thumb_down,
              color: Colors.grey,
            ),
            Container(
              width: 15.0,
            ),
            Text(
              "",
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
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
        itemCount: statuses.length,
        itemBuilder: (BuildContext context, int index) {
          Status status = statuses[index];

          if (index == statuses.length - 1) {
            return ChatCell(
                status, otherAccount, timeago.format(status.createdAt));
          } else {
            Status lastStatus = statuses[index + 1];
            String lastTime = timeago.format(lastStatus.createdAt);
            String thisTime = timeago.format(status.createdAt);
            if (lastTime == thisTime) {
              return ChatCell(status, otherAccount, null);
            } else {
              return ChatCell(
                  status, otherAccount, timeago.format(status.createdAt));
            }
          }
        },
      ),
    );
  }

  startNewConvoWithAccatment(String id) {
    var statusPath = StatusRequest.Status.postNewStatus;
    Map<String, dynamic> params = {
      "status": "@${widget.account.acct}",
      "visibility": "direct",
      "media_ids": [id]
    };
    print("Starting convo!");
    CurrentInstance.instance.currentClient
        .run(path: statusPath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      var status = Status.fromJson(jsonDecode(statusResponse.body));
      statuses.insert(0, status);
      setState(() {});
    }).catchError((e) {
      print(e);

      var alert = Alert(
          context,
          "Opps",
          "Unable to post status at this time. Please try again later.",
          () => {});
      alert.showAlert();
    });
  }

  startNewConvo() {
    if (txtController.text.length == 0) {
      print("too short");
      return;
    }

    var statusPath = StatusRequest.Status.postNewStatus;
    Map<String, dynamic> params = {
      "status": "@${widget.account.acct} ${txtController.text}",
      "visibility": "direct",
    };

    CurrentInstance.instance.currentClient
        .run(path: statusPath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      txtController.clear();
      var status = Status.fromJson(jsonDecode(statusResponse.body));
      statuses.insert(0, status);
      setState(() {});
    }).catchError((e) {
      print(e);
      var alert = Alert(
          context,
          "Opps",
          "Unable to post status at this time. Please try again later.",
          () => {});
      alert.showAlert();
    });
  }

  sendMessageWithAttachment(String id) {
    Account atAccount = statuses.first.account;
    if (widget.conversation.accounts.length > 0) {
      atAccount = getOtherAccount(widget.conversation.accounts);
    }

    print("sending attachment! $id");
    var statusPath = StatusRequest.Status.postNewStatus;
    Map<String, dynamic> params = {
      "status": "@${atAccount.acct}",
      "visibility": "direct",
      "in_reply_to_conversation_id": widget.conversation.id,
      "to": atAccount,
      "in_reply_to_id": statuses.first.id,
      "media_ids": [id]
    };

    CurrentInstance.instance.currentClient
        .run(path: statusPath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      txtController.clear();
      var status = Status.fromJson(jsonDecode(statusResponse.body));
      statuses.insert(0, status);
      setState(() {});
    }).catchError((e) {
      print(e);
      var alert = Alert(
          context,
          "Opps",
          "Unable to post status at this time. Please try again later.",
          () => {});
      alert.showAlert();
    });
  }

  sendMessage() {
    Account atAccount = statuses.first.account;
    if (widget.conversation.accounts.length > 0) {
      atAccount = getOtherAccount(widget.conversation.accounts);
    }

    if (txtController.text.length == 0) {
      print("too short");
      return;
    }

    var statusPath = StatusRequest.Status.postNewStatus;
    Map<String, dynamic> params = {
      "status": "@${atAccount.acct} ${txtController.text}",
      "to": atAccount,
      "visibility": "direct",
      "in_reply_to_conversation_id": widget.conversation.id,
      "in_reply_to_id": statuses.first.id
    };

    CurrentInstance.instance.currentClient
        .run(path: statusPath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      txtController.clear();
      var status = Status.fromJson(jsonDecode(statusResponse.body));
      statuses.insert(0, status);
      setState(() {});
    }).catchError((e) {
      print(e);
      var alert = Alert(
          context,
          "Opps",
          "Unable to post status at this time. Please try again later.",
          () => {});
      alert.showAlert();
    });
  }

  Account getOtherAccount(List<Account> accounts) {
    for (var i = 0; i < accounts.length; i++) {
      var currentAccount = CurrentInstance.instance.currentAccount;
      var account = accounts[i];
      if (currentAccount != account) {
        return account;
      }
    }

    return accounts.first;
  }

  postMediaId(String id) {}

  @override
  void dispose() {
    print("DISPOSE");
    backgroundCheckStatus = false;
    super.dispose();
  }
}
