import 'dart:convert';

import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/json/json_model.dart';
import 'package:fedi/pleroma/account/my/pleroma_my_account_model.dart';
import 'package:fedi/pleroma/account/pleroma_account_model.dart';
import 'package:fedi/pleroma/emoji/pleroma_emoji_model.dart';
import 'package:fedi/pleroma/field/pleroma_field_model.dart';
import 'package:fedi/pleroma/tag/pleroma_tag_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_account_model.g.dart';

abstract class IMyAccount extends IAccount implements IJsonObject {
  PleromaMyAccountPleromaPartNotificationsSettings
      get pleromaNotificationSettings;

  Map<String, dynamic> get pleromaSettingsStore;

  int get pleromaUnreadNotificationsCount;

  int get pleromaUnreadConversationCount;

  String get pleromaChatToken;

  bool get discoverable;

  int get followRequestsCount;

  String get fqn;

  IPleromaMyAccountSource get source;

  IPleromaMyAccountPleromaPart get pleroma;

  @override
  IMyAccount copyWith({
    int id,
    String remoteId,
    String username,
    String url,
    String note,
    bool locked,
    String headerStatic,
    String header,
    int followingCount,
    int followersCount,
    int statusesCount,
    String displayName,
    DateTime createdAt,
    bool bot,
    String avatarStatic,
    String avatar,
    String acct,
    DateTime lastStatusAt,
    List<PleromaField> fields,
    List<PleromaEmoji> emojis,
    List<PleromaTag> pleromaTags,
    PleromaAccountRelationship pleromaRelationship,
    bool pleromaIsAdmin,
    bool pleromaIsModerator,
    bool pleromaConfirmationPending,
    bool pleromaHideFavorites,
    bool pleromaHideFollowers,
    bool pleromaHideFollows,
    bool pleromaHideFollowersCount,
    bool pleromaHideFollowsCount,
    bool pleromaDeactivated,
    bool pleromaAllowFollowingMove,
    bool pleromaSkipThreadContainment,
    String pleromaBackgroundImage,
    bool pleromaAcceptsChatMessages,
    PleromaMyAccountPleromaPartNotificationsSettings
        pleromaNotificationSettings,
    int pleromaUnreadConversationCount,
    String pleromaChatToken,
    bool discoverable,
    int followRequestsCount,
    IPleromaMyAccountSource source,
    Map<String, dynamic> pleromaSettingsStore,
    int pleromaUnreadNotificationsCount,
  });
}

// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 53)
@JsonSerializable(explicitToJson: true)
class MyAccountRemoteWrapper extends IMyAccount {
  @HiveField(0)
  @JsonKey(name: "remote_account")
  final PleromaMyAccount remoteAccount;

  MyAccountRemoteWrapper({
    this.remoteAccount,
  });

  @override
  IPleromaMyAccountSource get source => remoteAccount.source;

  @override
  IPleromaMyAccountPleromaPart get pleroma => remoteAccount.pleroma;

  @override
  bool get discoverable =>
      remoteAccount.discoverable ?? source.pleroma.discoverable ?? false;

  @override
  String get acct => remoteAccount.acct;

  @override
  String get avatar => remoteAccount.avatar;

  @override
  String get avatarStatic => remoteAccount.avatarStatic;

  @override
  bool get bot => remoteAccount.bot;

  @override
  DateTime get createdAt => remoteAccount.createdAt;

  @override
  String get displayName => remoteAccount.displayName;

  @override
  List<IPleromaEmoji> get emojis => remoteAccount.emojis;

  @override
  List<IPleromaField> get fields => remoteAccount.fields;

  @override
  int get followersCount => remoteAccount.followersCount;

  @override
  int get followingCount => remoteAccount.followingCount;

  @override
  String get header => remoteAccount.header;

  @override
  String get headerStatic => remoteAccount.headerStatic;

  @override
  DateTime get lastStatusAt => remoteAccount.lastStatusAt;

  @override
  int get localId => null;

  @override
  bool get locked => remoteAccount.locked;

  @override
  String get note => remoteAccount.note;

  @override
  bool get pleromaAllowFollowingMove =>
      remoteAccount.pleroma?.allowFollowingMove;

  @override
  bool get pleromaConfirmationPending =>
      remoteAccount.pleroma?.confirmationPending;

  @override
  bool get pleromaDeactivated => remoteAccount.pleroma?.deactivated;

  @override
  bool get pleromaHideFavorites => remoteAccount.pleroma?.hideFavorites;

  @override
  bool get pleromaHideFollowers => remoteAccount.pleroma?.hideFollowers;

  @override
  bool get pleromaHideFollowersCount =>
      remoteAccount.pleroma?.hideFollowersCount;

  @override
  bool get pleromaHideFollows => remoteAccount.pleroma?.hideFollows;

  @override
  bool get pleromaHideFollowsCount => remoteAccount.pleroma?.hideFollowsCount;

  @override
  bool get pleromaIsAdmin => remoteAccount.pleroma?.isAdmin;

  @override
  bool get pleromaIsModerator => remoteAccount.pleroma?.isModerator;

  @override
  PleromaAccountRelationship get pleromaRelationship =>
      remoteAccount.pleroma?.relationship;

  @override
  bool get pleromaSkipThreadContainment =>
      remoteAccount.pleroma?.skipThreadContainment;

  @override
  List<dynamic> get pleromaTags => remoteAccount.pleroma?.tags;

  @override
  String get remoteId => remoteAccount.id;

  @override
  int get statusesCount => remoteAccount.statusesCount;

  @override
  String get url => remoteAccount.url;

  @override
  String get username => remoteAccount.username;

  @override
  int get followRequestsCount =>
      // pleroma
      remoteAccount?.followRequestsCount ??
      // mastodon
      remoteAccount?.source?.followRequestsCount;

  @override
  String get fqn => remoteAccount.fqn;

  @override
  IMyAccount copyWith({
    int id,
    String remoteId,
    String username,
    String url,
    String note,
    bool locked,
    String headerStatic,
    String header,
    int followingCount,
    int followersCount,
    int statusesCount,
    String displayName,
    DateTime createdAt,
    bool bot,
    String avatarStatic,
    String avatar,
    String acct,
    DateTime lastStatusAt,
    List<PleromaField> fields,
    List<PleromaEmoji> emojis,
    List<PleromaTag> pleromaTags,
    PleromaAccountRelationship pleromaRelationship,
    bool pleromaIsAdmin,
    bool pleromaIsModerator,
    bool pleromaConfirmationPending,
    bool pleromaHideFavorites,
    bool pleromaHideFollowers,
    bool pleromaHideFollows,
    bool pleromaHideFollowersCount,
    bool pleromaHideFollowsCount,
    bool pleromaDeactivated,
    bool pleromaAllowFollowingMove,
    bool pleromaSkipThreadContainment,
    String pleromaBackgroundImage,
    bool pleromaAcceptsChatMessages,
    PleromaMyAccountPleromaPartNotificationsSettings
        pleromaNotificationSettings,
    int pleromaUnreadConversationCount,
    String pleromaChatToken,
    bool discoverable,
    int followRequestsCount,
    IPleromaMyAccountSource source,
    Map<String, dynamic> pleromaSettingsStore,
    int pleromaUnreadNotificationsCount,
    String fqn,
  }) =>
      MyAccountRemoteWrapper(
        remoteAccount: remoteAccount.copyWith(
          id: remoteId,
          username: username,
          url: url,
          note: note,
          locked: locked,
          headerStatic: headerStatic,
          header: header,
          followingCount: followingCount,
          followersCount: followersCount,
          statusesCount: statusesCount,
          displayName: displayName,
          createdAt: createdAt,
          bot: bot,
          avatarStatic: avatarStatic,
          avatar: avatar,
          acct: acct,
          lastStatusAt: lastStatusAt,
          fields: fields,
          emojis: emojis,
          source: source,
          fqn: fqn,
          discoverable: discoverable,
          followRequestsCount: followRequestsCount,
          pleroma: PleromaMyAccountPleromaPart(
            tags: pleromaTags ?? this.pleromaTags,
            relationship: pleromaRelationship ?? this.pleromaRelationship,
            isAdmin: pleromaIsAdmin ?? this.pleromaIsAdmin,
            isModerator: pleromaIsModerator ?? this.pleromaIsModerator,
            confirmationPending:
                pleromaConfirmationPending ?? this.pleromaConfirmationPending,
            hideFavorites: pleromaHideFavorites ?? this.pleromaHideFavorites,
            hideFollowers: pleromaHideFollowers ?? this.pleromaHideFollowers,
            hideFollows: pleromaHideFollows ?? this.pleromaHideFollows,
            hideFollowersCount:
                pleromaHideFollowersCount ?? this.pleromaHideFollowersCount,
            hideFollowsCount:
                pleromaHideFollowsCount ?? this.pleromaHideFollowsCount,
            deactivated: pleromaDeactivated ?? this.pleromaDeactivated,
            allowFollowingMove:
                pleromaAllowFollowingMove ?? this.pleromaAllowFollowingMove,
            skipThreadContainment: pleromaSkipThreadContainment ??
                this.pleromaSkipThreadContainment,
            unreadConversationCount: pleromaUnreadConversationCount ??
                this.pleromaUnreadConversationCount,
            unreadNotificationsCount: pleromaUnreadNotificationsCount ??
                this.pleromaUnreadNotificationsCount,
            notificationSettings:
                pleromaNotificationSettings ?? this.pleromaNotificationSettings,
            settingsStore: pleromaSettingsStore ?? this.pleromaSettingsStore,
          ),
        ),
      );

  @override
  String get pleromaChatToken => remoteAccount.pleroma?.chatToken;

  @override
  PleromaMyAccountPleromaPartNotificationsSettings
      get pleromaNotificationSettings =>
          remoteAccount.pleroma?.notificationSettings;

  @override
  Map<String, dynamic> get pleromaSettingsStore =>
      remoteAccount.pleroma?.settingsStore;

  @override
  int get pleromaUnreadConversationCount =>
      remoteAccount.pleroma?.unreadConversationCount;

  @override
  int get pleromaUnreadNotificationsCount =>
      remoteAccount.pleroma?.unreadNotificationsCount;

  @override
  bool get pleromaAcceptsChatMessages =>
      remoteAccount.pleroma?.acceptsChatMessages;

  @override
  String toString() => 'MyAccountRemoteWrapper{remoteAccount: $remoteAccount}';

  @override
  String get pleromaBackgroundImage => remoteAccount.pleroma?.backgroundImage;

  factory MyAccountRemoteWrapper.fromJson(Map<String, dynamic> json) =>
      _$MyAccountRemoteWrapperFromJson(json);

  factory MyAccountRemoteWrapper.fromJsonString(String jsonString) =>
      _$MyAccountRemoteWrapperFromJson(jsonDecode(jsonString));

  static List<MyAccountRemoteWrapper> listFromJsonString(String str) =>
      List<MyAccountRemoteWrapper>.from(
          json.decode(str).map((x) => MyAccountRemoteWrapper.fromJson(x)));

  @override
  Map<String, dynamic> toJson() => _$MyAccountRemoteWrapperToJson(this);

  String toJsonString() => jsonEncode(_$MyAccountRemoteWrapperToJson(this));
}

class SelfActionNotPossibleException implements Exception {
  const SelfActionNotPossibleException();

  @override
  String toString() {
    return 'SelfActionNotPossibleException: '
        '"You cant retrieve or perform actions with yourself"';
  }
}
