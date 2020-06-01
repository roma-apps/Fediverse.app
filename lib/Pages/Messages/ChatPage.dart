import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/Pages/Messages/ChatCell.dart';
import 'package:fedi/Pages/Profile/OtherAccount.dart';
import 'package:fedi/Pleroma/Foundation/Requests/chat.dart';
import 'package:fedi/Pleroma/Models/Account.dart';
import 'package:fedi/Pleroma/Models/message.dart';
import 'package:fedi/Pleroma/Models/user_chat.dart';
import 'package:fedi/app/dm/media/dm_media_capture_widget.dart';
import 'package:fedi/app/dm/media/dm_media_page.dart';
import 'package:fedi/file/picker/file_picker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fedi/Pages/Push/PushHelper.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Models/Context.dart';
import 'package:fedi/Pleroma/Models/Status.dart';
import 'package:fedi/Views/Alert.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:path/path.dart' as path;

const heicExtension = ".heic";
var _logger = Logger("StatusDetail.dart");

class ChatPage extends StatefulWidget {
  final Function refreshMesagePage;
  final UserChat conversation;
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
  bool fetchByContext = false;

  var txtController = TextEditingController();
  List<Message> messages = <Message>[];
  String title;
  bool backgroundCheckStatus = true;
  Account otherAccount;
  update() {
    widget.refreshMasterList();
    backgroundCheck();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.account != null) {
    } else {
      otherAccount = widget.conversation.account;
    }
    print("OTHER ACCOUNT HERE");
    print(otherAccount);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              if (widget.refreshMesagePage != null) widget.refreshMesagePage();
              Navigator.of(context).pop();
            },
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherAccount(otherAccount)),
              );
            },
            child: Row(
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
                FittedBox(fit: BoxFit.fitWidth, child: Text(otherAccount.acct)),
              ],
            ),
          ),
          actions: <Widget>[],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: getMessageList(),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200, minHeight: 80),
              child: Padding(
                padding: EdgeInsets.all(10),
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
                              builder: (context) => CaptureDMMediaWidget(
                                    mediaUploaded: mediaUploaded,
                                    selectedTab: FilePickerTab.captureVideo,
                                  )));
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
                              builder: (context) => CaptureDMMediaWidget(
                                    mediaUploaded: mediaUploaded,
                                    selectedTab: FilePickerTab.captureImage,
                                  )));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _openMediaPicker();
                    },
                  ),
                  Spacer(),
                  OutlineButton(
                    child: Text(
                      AppLocalizations.of(context)
                          .tr("messages.chat.send_message.action.send"),
                      style: TextStyle(color: Colors.blue),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                     sendMessage(context);
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

    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => fetchStatuses(context));
    }

    PushHelper pushHelper = PushHelper.instance;
    pushHelper.notificationUpdater = update;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // similar to init state but with valid context

    if (widget.account != null) {
      title = AppLocalizations.of(context)
          .tr("messages.chat.title.with_account", args: [widget.account.acct]);
    } else {
      title = AppLocalizations.of(context).tr("messages.chat.title.no_account");
    }
  }

  Future<void> _openMediaPicker() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var file = FilePickerFile(file: image, type: )
    var isNeedDeleteAfterUsage = false;
    var filePath = file.absolute.path;
    _logger.fine(() => "retrieveFile \n"
        "\t file $filePath");

    var extension = path.extension(filePath);
    if (extension == heicExtension || Platform.isIOS) {
      // gallery may return photos in HEIC format from iOS gallery
      // in this case we should re-compress them to jpg
      // gallery on iOS is selecting the old
      file = await _compressToJpeg(file);
      isNeedDeleteAfterUsage = true;
    }
    var newFile = FilePickerFile(
        file: file,
        type: FilePickerFileType.image,
        isNeedDeleteAfterUsage: isNeedDeleteAfterUsage);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DMMediaPage(
            filePickerFile: newFile,
            popParent: () {},
            mediaUploaded: gallerySelectedUploaded,
          ),
        ));
  }

  Future<File> _compressToJpeg(File file) async {
    var originPath = file.absolute.path;
    final Directory extDir = await getTemporaryDirectory();
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String dirPath = path.join(extDir.path, "gallery_picker", timestamp);
    await Directory(dirPath).create(recursive: true);
    var originalFileNameWithoutExtension =
        path.basenameWithoutExtension(file.path);
    final String resultPath =
        path.join(dirPath, "$originalFileNameWithoutExtension.jpg");
    _logger.fine(() => "_compressToJpeg \n"
        "\t originPath $originPath"
        "\t resultPath $resultPath");
    file = await FlutterImageCompress.compressAndGetFile(
      originPath,
      resultPath,
      format: CompressFormat.jpeg,
      quality: 88,
    );
    return file;
  }

  gallerySelectedUploaded(BuildContext context, String id) {
    Navigator.of(context).pop();
    sendMessageWithAttachment(context, id);
  }

  mediaUploaded(BuildContext context, String id) {
    print("MY ID!!! $id");

    // should be refactored
    Navigator.pop(context);
    Navigator.pop(context);
    // below strings throw strange exceptions
//    Navigator.of(context)
//        .popUntil((route) => route.settings.name == "/ChatPage");

     sendMessageWithAttachment(context, id);
  }

  void fetchStatuses(BuildContext context) {
    if (messages.length == 0) {
      _refreshController.requestRefresh();
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  backgroundCheck() {
    if (widget.conversation != null && fetchByContext == false) {
      refreshFromConversation();
    } else {
      if (widget.conversation == null) {
        refreshFromContext();
      }
    }

    if (this.mounted) {
      Future.delayed(const Duration(milliseconds: 5000), () {
        backgroundCheck();
      });
    } else {
      return;
    }
  }

  fetchFromContext() {
    if (messages.length == 0) {
      _refreshController.refreshCompleted();
      return;
    }
    var path = Chat.getChatMessages(widget.conversation.id);
    CurrentInstance.instance.currentClient
        .run(path: path, method: HTTPMethod.GET)
        .then((response) {
      _refreshController.refreshCompleted();
      messages = messageFromJson(response.body);
      if (mounted) setState(() {});
      Future.delayed(const Duration(milliseconds: 5000), () {
        backgroundCheck();
      });
    }).catchError((error) {
      _refreshController.refreshCompleted();
      Future.delayed(const Duration(milliseconds: 5000), () {
        backgroundCheck();
      });
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  fetchFromConversation() {
    var path = Chat.getChatMessages(widget.conversation.id);

    CurrentInstance.instance.currentClient
        .run(path: path, method: HTTPMethod.GET)
        .then((response) {
      _refreshController.refreshCompleted();
      if (response.statusCode == 404) {
        fetchByContext = true;
        return;
      }
      _refreshController.refreshCompleted();
      messages = messageFromJson(response.body);

      if (mounted) setState(() {});
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

  refreshFromContext() {
    var path = Chat.getChatMessages(widget.conversation.id);
    CurrentInstance.instance.currentClient
        .run(path: path, method: HTTPMethod.GET)
        .then((response) {
      messages = messageFromJson(response.body);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  refreshFromConversation() {
    var path = Chat.getChatMessages(widget.conversation.id);
    CurrentInstance.instance.currentClient
        .run(path: path, method: HTTPMethod.GET)
        .then((response) {
      _refreshController.refreshCompleted();
      if (response.statusCode == 404) {
        fetchByContext = true;
      }
      messages = messageFromJson(response.body);
      if (mounted) setState(() {});
    }).catchError((error) {
      print(error.toString());
      if (mounted) setState(() {});
      _refreshController.refreshFailed();
    });
  }

  void _onRefresh() async {
    if (widget.conversation == null || fetchByContext == true) {
      fetchFromContext();
    } else {
      fetchFromConversation();
    }

    // if failed,use refreshFailed()
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
              AppLocalizations.of(context)
                  .tr("messages.chat.update.unable_to_fetch"),
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
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          Message status = messages[index];

          return ChatCell(status, otherAccount, timeago.format(status.createdAt));
        },
      ),
    );
  }

  void sendMessageWithAttachment(BuildContext context, String id) {
    // Account atAccount = statuses.first.account;
    // if (widget.conversation.accounts.length > 0) {
    //   atAccount = getOtherAccount(widget.conversation.accounts);
    // }

    print("sending attachment! $id");
    var messagePath = Chat.postMessage(widget.conversation.id);
    Map<String, dynamic> params = {
      "content":"",
      "media_id":id
    };

    CurrentInstance.instance.currentClient
        .run(path: messagePath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      _refreshController.refreshCompleted();
      txtController.clear();
      var message = Message.fromJson(jsonDecode(statusResponse.body));
      messages.insert(0, message);
      setState(() {});
    }).catchError((e) {
      print(e);
      var appLocalizations = AppLocalizations.of(context);
      var alert = Alert(
          context,
          appLocalizations.tr("messages.chat.send_message.error.alert.title"),
          appLocalizations.tr("messages.chat.send_message.error.alert.content"),
          () => {});
      alert.showAlert();
    });
  }

  void sendMessage(BuildContext context) {

   if (txtController.text.isEmpty) {
      print("too short");
      return;
    }

   var messagePath = Chat.postMessage(widget.conversation.id);
    Map<String, dynamic> params = {
      "content":"${txtController.text}",
      "media_ids":""
    };

    CurrentInstance.instance.currentClient
        .run(path: messagePath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      _refreshController.refreshCompleted();
      txtController.clear();
      var message = Message.fromJson(jsonDecode(statusResponse.body));
      messages.insert(0, message);
      setState(() {});
    }).catchError((e) {
      print(e);
      var appLocalizations = AppLocalizations.of(context);
      var alert = Alert(
          context,
          appLocalizations.tr("messages.chat.send_message.error.alert.title"),
          appLocalizations.tr("messages.chat.send_message.error.alert.content"),
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
    backgroundCheckStatus = false;
    super.dispose();
  }
}
