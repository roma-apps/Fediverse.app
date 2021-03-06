import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/json/json_model.dart';
import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/emoji/pleroma_api_emoji_model.dart';
import 'package:fedi/pleroma/api/field/pleroma_api_field_model.dart';
import 'package:fedi/pleroma/api/tag/pleroma_api_tag_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

// ignore_for_file: no-magic-number
part 'my_account_model.g.dart';

abstract class IMyAccount extends IAccount implements IJsonObject {
  PleromaApiMyAccountPleromaPartNotificationsSettings?
      get pleromaNotificationSettings;

  Map<String, dynamic>? get pleromaSettingsStore;

  int? get pleromaUnreadNotificationsCount;

  int? get pleromaUnreadConversationCount;

  String? get pleromaChatToken;

  bool get discoverable;

  int? get followRequestsCount;

  IPleromaApiMyAccountSource? get source;

  IPleromaApiMyAccountPleromaPart? get pleroma;

  @override
  IMyAccount copyWith({
    int? id,
    String? remoteId,
    String? username,
    String? url,
    String? note,
    bool? locked,
    String? headerStatic,
    String? header,
    int? followingCount,
    int? followersCount,
    int? statusesCount,
    String? displayName,
    DateTime? createdAt,
    bool? bot,
    String? avatarStatic,
    String? avatar,
    String? acct,
    DateTime? lastStatusAt,
    List<PleromaApiField>? fields,
    List<PleromaApiEmoji>? emojis,
    List<PleromaApiTag>? pleromaTags,
    IPleromaApiAccountRelationship? pleromaRelationship,
    bool? pleromaIsAdmin,
    bool? pleromaIsModerator,
    bool? pleromaConfirmationPending,
    bool? pleromaHideFavorites,
    bool? pleromaHideFollowers,
    bool? pleromaHideFollows,
    bool? pleromaHideFollowersCount,
    bool? pleromaHideFollowsCount,
    bool? pleromaDeactivated,
    bool? pleromaAllowFollowingMove,
    bool? pleromaSkipThreadContainment,
    String? pleromaBackgroundImage,
    bool? pleromaAcceptsChatMessages,
    PleromaApiMyAccountPleromaPartNotificationsSettings?
        pleromaNotificationSettings,
    int? pleromaUnreadConversationCount,
    String? pleromaChatToken,
    bool? discoverable,
    int? followRequestsCount,
    IPleromaApiMyAccountSource? source,
    Map<String, dynamic>? pleromaSettingsStore,
    int? pleromaUnreadNotificationsCount,
    List<String>? pleromaAlsoKnownAs,
    String? pleromaApId,
    String? pleromaFavicon,
    bool? pleromaIsConfirmed,
  });
}

extension IMyAccountPleromaExtension on IMyAccount {
  PleromaApiMyAccount toPleromaApiMyAccount() {
    if (this is PleromaMyAccountWrapper) {
      return (this as PleromaMyAccountWrapper).pleromaAccount;
    } else {
      return PleromaApiMyAccount(
        header: header,
        headerStatic: headerStatic,
        username: username,
        url: url,
        statusesCount: statusesCount,
        note: note,
        locked: locked,
        id: remoteId,
        followingCount: followingCount,
        followersCount: followersCount,
        fields: fields?.toPleromaApiFields(),
        emojis: emojis?.toPleromaApiEmojis(),
        displayName: displayName,
        createdAt: createdAt,
        bot: bot,
        avatarStatic: avatarStatic,
        avatar: avatar,
        acct: acct,
        pleroma: pleroma?.toPleromaApiMyAccountPleromaPart(),
        lastStatusAt: lastStatusAt,
        source: source?.toPleromaApiMyAccountSource(),
        discoverable: discoverable,
        followRequestsCount: followRequestsCount,
        fqn: fqn,
      );
    }
  }
}

extension IMyAccountExtension on IMyAccount {
  PleromaMyAccountWrapper toPleromaApiMyAccountWrapper() {
    if (this is PleromaMyAccountWrapper) {
      return this as PleromaMyAccountWrapper;
    } else {
      return PleromaMyAccountWrapper(
        pleromaAccount: toPleromaApiMyAccount(),
      );
    }
  }
}

// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 53)
@JsonSerializable(explicitToJson: true)
class PleromaMyAccountWrapper extends IMyAccount {
  @HiveField(0)
  @JsonKey(name: 'remote_account')
  final PleromaApiMyAccount pleromaAccount;

  PleromaMyAccountWrapper({
    required this.pleromaAccount,
  });

  @override
  IPleromaApiMyAccountSource? get source => pleromaAccount.source;

  @override
  IPleromaApiMyAccountPleromaPart? get pleroma => pleromaAccount.pleroma;

  @override
  bool get discoverable =>
      pleromaAccount.discoverable ?? source?.pleroma?.discoverable ?? false;

  @override
  String get acct => pleromaAccount.acct;

  @override
  String get avatar => pleromaAccount.avatar;

  @override
  String get avatarStatic => pleromaAccount.avatarStatic;

  @override
  bool? get bot => pleromaAccount.bot;

  @override
  DateTime get createdAt => pleromaAccount.createdAt;

  @override
  String? get displayName => pleromaAccount.displayName;

  @override
  List<IPleromaApiEmoji>? get emojis => pleromaAccount.emojis;

  @override
  List<IPleromaApiField>? get fields => pleromaAccount.fields;

  @override
  int get followersCount => pleromaAccount.followersCount;

  @override
  int get followingCount => pleromaAccount.followingCount;

  @override
  String get header => pleromaAccount.header;

  @override
  String get headerStatic => pleromaAccount.headerStatic;

  @override
  DateTime? get lastStatusAt => pleromaAccount.lastStatusAt;

  @override
  int? get localId => null;

  @override
  bool get locked => pleromaAccount.locked;

  @override
  String? get note => pleromaAccount.note;

  @override
  bool? get pleromaAllowFollowingMove =>
      pleromaAccount.pleroma?.allowFollowingMove;

  @override
  bool? get pleromaConfirmationPending =>
      pleromaAccount.pleroma?.confirmationPending;

  @override
  bool? get pleromaDeactivated => pleromaAccount.pleroma?.deactivated;

  @override
  bool? get pleromaHideFavorites => pleromaAccount.pleroma?.hideFavorites;

  @override
  bool? get pleromaHideFollowers => pleromaAccount.pleroma?.hideFollowers;

  @override
  bool? get pleromaHideFollowersCount =>
      pleromaAccount.pleroma?.hideFollowersCount;

  @override
  bool? get pleromaHideFollows => pleromaAccount.pleroma?.hideFollows;

  @override
  bool? get pleromaHideFollowsCount => pleromaAccount.pleroma?.hideFollowsCount;

  @override
  bool? get pleromaIsAdmin => pleromaAccount.pleroma?.isAdmin;

  @override
  bool? get pleromaIsModerator => pleromaAccount.pleroma?.isModerator;

  @override
  PleromaApiAccountRelationship? get pleromaRelationship =>
      pleromaAccount.pleroma?.relationship;

  @override
  bool? get pleromaSkipThreadContainment =>
      pleromaAccount.pleroma?.skipThreadContainment;

  @override
  List<PleromaApiTag>? get pleromaTags => pleromaAccount.pleroma?.tags;

  @override
  String get remoteId => pleromaAccount.id;

  @override
  int get statusesCount => pleromaAccount.statusesCount;

  @override
  String get url => pleromaAccount.url;

  @override
  String get username => pleromaAccount.username;

  @override
  int? get followRequestsCount =>
      // pleroma
      pleromaAccount.followRequestsCount ??
      // mastodon
      pleromaAccount.source?.followRequestsCount;

  @override
  String? get fqn => pleromaAccount.fqn;

  @override
  // ignore: long-parameter-list, code-metrics, long-method
  IMyAccount copyWith({
    int? id,
    String? remoteId,
    String? username,
    String? url,
    String? note,
    bool? locked,
    String? headerStatic,
    String? header,
    int? followingCount,
    int? followersCount,
    int? statusesCount,
    String? displayName,
    DateTime? createdAt,
    bool? bot,
    String? avatarStatic,
    String? avatar,
    String? acct,
    DateTime? lastStatusAt,
    List<PleromaApiField>? fields,
    List<PleromaApiEmoji>? emojis,
    List<PleromaApiTag>? pleromaTags,
    IPleromaApiAccountRelationship? pleromaRelationship,
    bool? pleromaIsAdmin,
    bool? pleromaIsModerator,
    bool? pleromaConfirmationPending,
    bool? pleromaHideFavorites,
    bool? pleromaHideFollowers,
    bool? pleromaHideFollows,
    bool? pleromaHideFollowersCount,
    bool? pleromaHideFollowsCount,
    bool? pleromaDeactivated,
    bool? pleromaAllowFollowingMove,
    bool? pleromaSkipThreadContainment,
    String? pleromaBackgroundImage,
    bool? pleromaAcceptsChatMessages,
    PleromaApiMyAccountPleromaPartNotificationsSettings?
        pleromaNotificationSettings,
    int? pleromaUnreadConversationCount,
    String? pleromaChatToken,
    bool? discoverable,
    int? followRequestsCount,
    IPleromaApiMyAccountSource? source,
    Map<String, dynamic>? pleromaSettingsStore,
    int? pleromaUnreadNotificationsCount,
    List<String>? pleromaAlsoKnownAs,
    String? pleromaApId,
    String? pleromaFavicon,
    bool? pleromaIsConfirmed,
  }) =>
      PleromaMyAccountWrapper(
        pleromaAccount: pleromaAccount.copyWith(
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
          source: source?.toPleromaApiMyAccountSource(),
          fqn: fqn,
          discoverable: discoverable,
          followRequestsCount: followRequestsCount,
          pleroma: PleromaApiMyAccountPleromaPart(
            tags: pleromaTags?.toPleromaApiTags() ?? this.pleromaTags,
            relationship:
                pleromaRelationship?.toPleromaApiAccountRelationship() ??
                    this.pleromaRelationship,
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
            alsoKnownAs: pleromaAlsoKnownAs ?? this.pleromaAlsoKnownAs,
            backgroundImage:
                pleromaBackgroundImage ?? this.pleromaBackgroundImage,
            apId: pleromaApId ?? this.pleromaApId,
            acceptsChatMessages:
                pleromaAcceptsChatMessages ?? this.pleromaAcceptsChatMessages,
            chatToken: pleromaChatToken ?? this.pleromaChatToken,
            favicon: pleromaFavicon ?? this.pleromaFavicon,
            isConfirmed: pleromaIsConfirmed ?? this.pleromaIsConfirmed,
          ),
        ),
      );

  @override
  String? get pleromaChatToken => pleromaAccount.pleroma?.chatToken;

  @override
  PleromaApiMyAccountPleromaPartNotificationsSettings?
      get pleromaNotificationSettings =>
          pleromaAccount.pleroma?.notificationSettings;

  @override
  Map<String, dynamic>? get pleromaSettingsStore =>
      pleromaAccount.pleroma?.settingsStore;

  @override
  int? get pleromaUnreadConversationCount =>
      pleromaAccount.pleroma?.unreadConversationCount;

  @override
  int? get pleromaUnreadNotificationsCount =>
      pleromaAccount.pleroma?.unreadNotificationsCount;

  @override
  bool? get pleromaAcceptsChatMessages =>
      pleromaAccount.pleroma?.acceptsChatMessages;

  @override
  List<String>? get pleromaAlsoKnownAs => pleromaAccount.pleroma?.alsoKnownAs;

  @override
  String? get pleromaApId => pleromaAccount.pleroma?.apId;

  @override
  String? get pleromaFavicon => pleromaAccount.pleroma?.favicon;

  @override
  bool? get pleromaIsConfirmed => pleromaAccount.pleroma?.isConfirmed;

  @override
  String toString() => 'MyAccountRemoteWrapper{remoteAccount: $pleromaAccount}';

  @override
  String? get pleromaBackgroundImage => pleromaAccount.pleroma?.backgroundImage;

  static PleromaMyAccountWrapper fromJson(Map<String, dynamic> json) =>
      _$PleromaMyAccountWrapperFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PleromaMyAccountWrapperToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaMyAccountWrapper &&
          runtimeType == other.runtimeType &&
          pleromaAccount == other.pleromaAccount;

  @override
  int get hashCode => pleromaAccount.hashCode;
}

class SelfActionNotPossibleException implements Exception {
  const SelfActionNotPossibleException();

  @override
  String toString() {
    return 'SelfActionNotPossibleException: '
        'You cant retrieve or perform actions with yourself';
  }
}
