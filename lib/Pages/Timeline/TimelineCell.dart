import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedi/Pages/Timeline/StatusFavoritePage.dart';
import 'package:fedi/Pages/Timeline/StatusRepostPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fedi/Pages/Statuses/ImageViewPage.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Accounts.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Status.dart' as StatusRequest;
import 'package:fedi/Pleroma/Models/Account.dart';
import 'package:fedi/Pleroma/Models/Status.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fedi/Views/VideoPlayer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:fedi/Pleroma/Foundation/Requests/Accounts.dart'
    as AccountRequests;

class TimelineCell extends StatefulWidget {
  final Status status;
  final Function(Account) viewAccount;
  final Function(Status) viewStatusContext;
  final bool showCommentBtn;

  TimelineCell(this.status,
      {this.viewAccount, this.viewStatusContext, this.showCommentBtn});

  @override
  State<StatefulWidget> createState() {
    return _TimelineCell();
  }
}

class _TimelineCell extends State<TimelineCell> {
  double deviceWidth;
  double targetWidth;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    Status status =
        widget.status.reblog != null ? widget.status.reblog : widget.status;

    return Card(
      child: Column(
        children: <Widget>[
          // reposted status
          if (widget.status.reblog != null)
            GestureDetector(
              onTap: () {
                print("view account");
                if (widget.viewAccount != null) {
                  widget.viewAccount(widget.status.account);
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.status.account.avatar,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getUserName(widget.status),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.cached),
                        SizedBox(
                          width: 8,
                        ),
                        Text("repeated")
                      ],
                    )
                  ],
                ),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print("view account");
                    if (widget.viewAccount != null) {
                      widget.viewAccount(status.account);
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          imageUrl: status.account.avatar,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 40,
                          width: 40,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: getUserName(status),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[Text("${status.account.acct}")],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      tooltip: 'More',
                      onPressed: () {
                        showMoreOptions(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              print("view status context");
              if (widget.viewStatusContext != null) {
                widget.viewStatusContext(status);
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                if (widget.status.mediaAttachments.length > 0)
                  getMeidaWidget(widget.status),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 0, top: 8, left: 12.0, right: 12),
                  child: Html(
                    onImageTap: (String source) {
                      print("source $source");
                    },
                    customTextStyle: (dom.Node node, TextStyle baseStyle) {
                      if (node is dom.Element) {
                        switch (node.localName) {
                          case "p":
                            return baseStyle.merge(TextStyle(fontSize: 18));
                        }
                      }
                      return baseStyle.merge(TextStyle(fontSize: 18));
                    },
                    onImageError: (dynamic exception, StackTrace stackTrace) {
                      print("Image error!!!");
                      print(exception);
                      print(stackTrace);
                    },
                    data: getHTMLWithCustomEmoji(widget.status),
                    onLinkTap: (String link) {
                      for (int i = 0; i < widget.status.mentions.length; i++) {
                        Mention mention = widget.status.mentions[i];
                        print("MENTIONS: ${mention.url} == $link");
                        if (mention.url == link) {
                          CurrentInstance.instance.currentClient
                              .run(
                                  path: AccountRequests.Accounts.account(
                                      id: mention.id),
                                  method: HTTPMethod.GET)
                              .then((response) {
                            Account account = accountFromJson(response.body);
                            widget.viewAccount(account);
                          }).catchError((error) {
                            print(error.toString());
                          });

                          return;
                        }
                      }

                      print("link $link");
                      canLaunch(link).then((result) {
                        launch(link);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        color: widget.status.favourited
                            ? Colors.blue
                            : Colors.grey,
                        icon: Icon(Icons.thumb_up),
                        tooltip: 'Like',
                        onPressed: () {
                          like();
                        },
                      ),
                      if (widget.showCommentBtn == true ||
                          widget.showCommentBtn == null)
                        IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.add_comment),
                          tooltip: 'comment',
                          onPressed: () {
                            widget.viewStatusContext(widget.status);
                          },
                        ),
                      if (widget.status.repliesCount != 0 &&
                          (widget.showCommentBtn == true ||
                              widget.showCommentBtn == null))
                        Text(widget.status.repliesCount.toString()),
                      IconButton(
                        color:
                            widget.status.reblogged ? Colors.blue : Colors.grey,
                        icon: Icon(Icons.cached),
                        tooltip: 'repost',
                        onPressed: () {
                          repost();
                        },
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 19),
                        child: Text(
                          Jiffy(status.createdAt).fromNow(),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.status.favouritesCount > 0 ||
                    widget.status.reblogsCount > 0 ||
                    widget.status.reblog != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: <Widget>[
                        if (widget.status.favouritesCount > 0)
                          getFavoritesButton(),
                        if (widget.status.reblogsCount > 0) getRepostsButton()
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getFavoritesButton() {
    int count = 0;
    if (widget.status.reblog != null) {
      count += widget.status.reblog.favouritesCount ?? 0;
    }
    count += widget.status.favouritesCount ?? 0;

    String favs = "$count Favorites";
    if (count == 1) {
      favs = "$count Favorite";
    }
    return FlatButton(
      child: Text(favs),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StatusFavoritePage(widget.status)),
        );
      },
    );
  }

  Widget getRepostsButton() {
    int count = 0;
    count += widget.status.reblogsCount ?? 0;
    if (widget.status.reblog != null) {
      count += widget.status.reblog.reblogsCount ?? 0;
    }
    String reposts = "$count Reposts";
    if (widget.status.reblogsCount == 1) {
      reposts = "$count Repost";
    }
    return FlatButton(
      child: Text(reposts),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StatusRepostPage(widget.status)),
        );
      },
    );
  }

  like() {
    String path = StatusRequest.Status.favouriteStatus(widget.status.id);
    if (widget.status.favourited == true) {
      path = StatusRequest.Status.unfavouriteStatus(widget.status.id);
      widget.status.favouritesCount = widget.status.favouritesCount - 1;
    } else {
      widget.status.favouritesCount = widget.status.favouritesCount + 1;
    }
    widget.status.favourited = !widget.status.favourited;

    CurrentInstance.instance.currentClient
        .run(path: path, method: HTTPMethod.POST)
        .then((response) {
      print(response.body);
    }).catchError((error) {
      print(error);
    });
    if (mounted) setState(() {});
  }

  repost() {
    String path = StatusRequest.Status.reblogStatus(widget.status.id);
    if (widget.status.reblogged == true) {
      path = StatusRequest.Status.reblogStatus(widget.status.id);
      widget.status.reblogsCount = widget.status.reblogsCount - 1;
    } else {
      widget.status.reblogsCount = widget.status.reblogsCount + 1;
    }
    widget.status.reblogged = !widget.status.favourited;
    CurrentInstance.instance.currentClient
        .run(path: path, method: HTTPMethod.POST)
        .then((response) {
      print(response.body);
    }).catchError((error) {
      print(error);
    });
    if (mounted) setState(() {});
  }

  showMoreOptions(BuildContext context) {
    Status status = widget.status;
    if (widget.status.reblog != null) {
      status = widget.status.reblog;
    }

    showModalBottomSheet(
        builder: (BuildContext context) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Status Actions",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Copy status link")],
                          ),
                          onPressed: () {
                            print(status.uri);
                            Clipboard.setData(ClipboardData(text: status.uri));
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                                msg: "Copied",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Open in browser")],
                          ),
                          onPressed: () {
                            canLaunch(status.uri).then((result) {
                              launch(status.uri);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "More actions for:",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      "${status.account.acct}",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                // public button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Follow")],
                          ),
                          onPressed: () {
                            CurrentInstance.instance.currentClient
                                .run(
                                    path:
                                        Accounts.account(id: status.account.id),
                                    method: HTTPMethod.GET)
                                .then((response) {
                              Account account = accountFromJson(response.body);
                              CurrentInstance.instance.currentClient
                                  .run(
                                      path: Accounts.followAccount(account.id),
                                      method: HTTPMethod.POST)
                                  .then((response) {
                                print("following response");
                                print("following ${response.statusCode}");
                                print(response.body);
                              }).catchError((error) {
                                print(error);
                              });
                            }).catchError((error) {
                              print(error);
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // public button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Mute")],
                          ),
                          onPressed: () {
                            CurrentInstance.instance.currentClient
                                .run(
                                    path:
                                        Accounts.muteAccount(status.account.id),
                                    method: HTTPMethod.POST)
                                .then((response) {
                              print(response.body);
                            }).catchError((error) {
                              print(error);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Unlisted
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Block")],
                          ),
                          onPressed: () {
                            CurrentInstance.instance.currentClient
                                .run(
                                    path: Accounts.blockAccount(
                                        status.account.id),
                                    method: HTTPMethod.POST)
                                .then((response) {
                              print(response.body);
                            }).catchError((error) {
                              print(error);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Private
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Report")],
                          ),
                          onPressed: () {
                            var params = {"account_id": status.account.id};
                            CurrentInstance.instance.currentClient
                                .run(
                                    path: Accounts.reportAccount(),
                                    params: params,
                                    method: HTTPMethod.POST)
                                .then((response) {
                              print(response.body);
                            }).catchError((error) {
                              print(error);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                ),
                // Cancel
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                " Cancel",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        context: context);
  }

  Widget getMeidaWidget(Status status) {
    List<Widget> items = <Widget>[];

    for (var i = 0; i < status.mediaAttachments.length; i++) {
      MediaAttachment attachment = status.mediaAttachments[i];
      if (attachment.type == "image") {
        var image = CachedNetworkImage(
          imageUrl: attachment.url,
          placeholder: (context, url) => Center(
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );

        var imageprovider = Image.network(
          attachment.url,
          height: 15.0,
          width: 15.0,
        );
        var container = GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageViewPage(imageprovider.image)),
              );
            },
            child: image);
        items.add(container);
      } else if (attachment.type == "video" || attachment.type == "audio") {
        items.add(
          CellVideoPlayer(
            attachment.url,
          ),
        );
      } else {
        if (status.mediaAttachments.length == 1) {
          return Container();
        }
      }
    }

    return Container(
      height: targetWidth,
      width: targetWidth,
      color: Colors.white,
      child: Carousel(
        overlayShadowColors: Colors.transparent,
        overlayShadowSize: 0.0,
        images: items,
        dotIncreasedColor: Colors.blue,
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.blue.withOpacity(0.5),
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius: true,
        autoplay: false,
      ),
    );
  }

  String getHTMLWithCustomEmoji(Status status) {
    List customEmoji = status.emojis;
    String html = status.content;
    for (int i = 0; i < customEmoji.length; i++) {
      var emoji = customEmoji[i];
      String shortcode = emoji["shortcode"];
      String url = emoji["url"];

      html = html.replaceAll(":$shortcode:", '<img src="$url" width="20">');
    }
    html = "<html> <body>$html</body></html>";
    return html;
  }

  List<Widget> getUserName(Status status) {
    var username = status.account.displayName;
    var emojis = status.account.emojis;
    emojis.addAll(status.emojis);
    List<Widget> usernameWidget = [];
    var emojiUsername = username.split(":");

    if (emojiUsername.length == 0) {
      usernameWidget.add(Text(
        username,
        style: TextStyle(fontSize: 17.0),
      ));
      return usernameWidget;
    }

    for (var i = 0; i < emojiUsername.length; i++) {
      var emojiOrText = emojiUsername[i];
      var foundEmoji = false;
      for (var j = 0; j < emojis.length; j++) {
        var emoji = emojis[j];
        String shortcode = emoji["shortcode"];
        String url = emoji["url"];
        if (shortcode == emojiOrText) {
          var image = CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
            height: 15,
            width: 15,
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
          usernameWidget.add(image);
          foundEmoji = true;
        }
      }

      if (foundEmoji == false) {
        var text = Text(
          emojiOrText,
          style: TextStyle(fontSize: 17.0),
        );
        usernameWidget.add(text);
      }
    }

    return usernameWidget;
  }
}
