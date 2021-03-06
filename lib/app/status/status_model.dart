import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/pending/pending_model.dart';
import 'package:fedi/obj/equal_comparable_obj.dart';
import 'package:fedi/pleroma/api/application/pleroma_api_application_model.dart';
import 'package:fedi/pleroma/api/card/pleroma_api_card_model.dart';
import 'package:fedi/pleroma/api/content/pleroma_api_content_model.dart';
import 'package:fedi/pleroma/api/emoji/pleroma_api_emoji_model.dart';
import 'package:fedi/pleroma/api/field/pleroma_api_field_model.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_model.dart';
import 'package:fedi/pleroma/api/mention/pleroma_api_mention_model.dart';
import 'package:fedi/pleroma/api/poll/pleroma_api_poll_model.dart';
import 'package:fedi/pleroma/api/status/pleroma_api_status_model.dart';
import 'package:fedi/pleroma/api/tag/pleroma_api_tag_model.dart';
import 'package:fedi/pleroma/api/visibility/pleroma_api_visibility_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

final _logger = Logger('status_model.dart');

typedef StatusAndContextCallback = Function(
  BuildContext context,
  IStatus status,
);
typedef StatusCallback = Function(IStatus? status);

abstract class IStatus implements IEqualComparableObj<IStatus> {
  static bool isItemsEqual(IStatus a, IStatus b) => a.remoteId == b.remoteId;

  static int compareItemsToSort(IStatus? a, IStatus? b) {
    if (a == null && b == null) {
      return 0;
    } else if (a != null && b == null) {
      return 1;
    } else if (a == null && b != null) {
      return -1;
    } else {
      return a!.remoteId!.compareTo(b!.remoteId!);
    }
  }

  IStatus? get reblog;

  int? get localId;

  String? get remoteId;

  DateTime get createdAt;

  IStatus? get inReplyToStatus;

  String? get inReplyToRemoteId;

  String? get inReplyToAccountRemoteId;

  bool get nsfwSensitive;

  String? get spoilerText;

  String get uri;

  String? get url;

  int get repliesCount;

  int get reblogsCount;

  int get favouritesCount;

  bool get favourited;

  bool get reblogged;

  bool get pinned;

  bool get muted;

  bool get bookmarked;

  String? get content;

  String? get reblogStatusRemoteId;

  PleromaApiApplication? get application;

  IAccount get account;

  List<PleromaApiMediaAttachment>? get mediaAttachments;

  List<PleromaApiMention>? get mentions;

  List<PleromaApiTag>? get tags;

  List<PleromaApiEmoji>? get emojis;

  PleromaApiPoll? get poll;

  PleromaApiCard? get card;

  PleromaApiVisibility get visibility;

  String? get language;

  // expanded pleroma object fields

  /// a map consisting of alternate representations of the content property with
  /// the key being it's mimetype.
  /// Currently the only alternate representation supported is text/plain
  PleromaApiContent? get pleromaContent;

  /// the ID of the AP context the status is associated with (if any)

  int? get pleromaConversationId;

  /// the ID of the Mastodon direct message conversation the status
  /// is associated with (if any)
  int? get pleromaDirectConversationId;

  /// the acct property of User entity for replied user (if any)
  String? get pleromaInReplyToAccountAcct;

  bool? get pleromaLocal;

  /// a map consisting of alternate representations of the spoiler_text property
  /// with the key being it's mimetype. Currently the only alternate
  /// representation supported is text/plain
  PleromaApiContent? get pleromaSpoilerText;

  /// a datetime (iso8601) that states when
  /// the post will expire (be deleted automatically),
  /// or empty if the post wont expire
  DateTime? get pleromaExpiresAt;

  bool? get pleromaThreadMuted;

  /// A list with emoji / reaction maps. The format is
  /// {name: '☕', count: 1, me: true}.
  /// Contains no information about the reacting users,
  /// for that use the /statuses/:id/reactions endpoint.
  List<PleromaApiStatusEmojiReaction>? get pleromaEmojiReactions;

  bool get isReply =>
      inReplyToAccountRemoteId != null && inReplyToRemoteId != null;

  bool get isHaveReblog => reblogStatusRemoteId != null;

  bool get deleted;

  PendingState? get pendingState;

  String? get oldPendingRemoteId;

  bool get hiddenLocallyOnDevice;

  String? get wasSentWithIdempotencyKey;

  IStatus copyWith({
    IAccount? account,
    IStatus? reblog,
    int? id,
    String? remoteId,
    DateTime? createdAt,
    IStatus? inReplyToStatus,
    String? inReplyToRemoteId,
    String? inReplyToAccountRemoteId,
    bool? nsfwSensitive,
    String? spoilerText,
    PleromaApiVisibility? visibility,
    String? uri,
    String? url,
    int? repliesCount,
    int? reblogsCount,
    int? favouritesCount,
    bool? favourited,
    bool? reblogged,
    bool? muted,
    bool? bookmarked,
    bool? pinned,
    String? content,
    String? reblogStatusRemoteId,
    PleromaApiApplication? application,
    String? accountRemoteId,
    List<PleromaApiMediaAttachment>? mediaAttachments,
    List<PleromaApiMention>? mentions,
    List<PleromaApiTag>? tags,
    List<PleromaApiEmoji>? emojis,
    PleromaApiPoll? poll,
    PleromaApiCard? card,
    String? language,
    PleromaApiContent? pleromaContent,
    int? pleromaConversationId,
    int? pleromaDirectConversationId,
    String? pleromaInReplyToAccountAcct,
    bool? pleromaLocal,
    PleromaApiContent? pleromaSpoilerText,
    DateTime? pleromaExpiresAt,
    bool? pleromaThreadMuted,
    List<PleromaApiStatusEmojiReaction>? pleromaEmojiReactions,
    bool? deleted,
    PendingState? pendingState,
    String? oldPendingRemoteId,
    bool? hiddenLocallyOnDevice,
    String? wasSentWithIdempotencyKey,
  });
}

extension IStatusDbExtension on IStatus {
  DbStatusPopulatedWrapper toDbStatusPopulatedWrapper() {
    if (this is DbStatusPopulatedWrapper) {
      return this as DbStatusPopulatedWrapper;
    } else {
      return DbStatusPopulatedWrapper(
        dbStatusPopulated: toDbStatusPopulated(),
      );
    }
  }

  DbStatusPopulated toDbStatusPopulated() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated;
    } else {
      return DbStatusPopulated(
        dbStatus: toDbStatus(),
        dbAccount: toDbAccount(),
        reblogDbStatus: toReblogDbStatus(),
        reblogDbStatusAccount: toReblogStatusDbAccount(),
        replyDbStatus: toReplyDbStatus(),
        replyDbStatusAccount: toReplyStatusDbAccount(),
        replyReblogDbStatus: toReplyReblogDbStatus(),
        replyReblogDbStatusAccount: toReplyReblogStatusDbAccount(),
      );
    }
  }

  DbStatus toDbStatus() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.dbStatus;
    } else {
      return DbStatus(
        id: localId,
        remoteId: remoteId!,
        createdAt: createdAt,
        inReplyToRemoteId: inReplyToRemoteId,
        inReplyToAccountRemoteId: inReplyToAccountRemoteId,
        sensitive: nsfwSensitive,
        spoilerText: spoilerText,
        visibility: visibility,
        uri: uri,
        url: url,
        repliesCount: repliesCount,
        reblogsCount: reblogsCount,
        favouritesCount: favouritesCount,
        favourited: favourited,
        reblogged: reblogged,
        muted: muted,
        bookmarked: bookmarked,
        pinned: pinned,
        content: content,
        reblogStatusRemoteId: reblogStatusRemoteId,
        application: application,
        accountRemoteId: account.remoteId,
        mediaAttachments: mediaAttachments,
        mentions: mentions,
        tags: tags,
        emojis: emojis,
        poll: poll,
        card: card,
        language: language,
        pleromaContent: pleromaContent,
        pleromaConversationId: pleromaConversationId,
        pleromaDirectConversationId: pleromaDirectConversationId,
        pleromaInReplyToAccountAcct: pleromaInReplyToAccountAcct,
        pleromaLocal: pleromaLocal,
        pleromaSpoilerText: pleromaSpoilerText,
        pleromaExpiresAt: pleromaExpiresAt,
        pleromaThreadMuted: pleromaThreadMuted,
        pleromaEmojiReactions: pleromaEmojiReactions,
        deleted: deleted,
        oldPendingRemoteId: oldPendingRemoteId,
        hiddenLocallyOnDevice: hiddenLocallyOnDevice,
        pendingState: pendingState,
        wasSentWithIdempotencyKey: wasSentWithIdempotencyKey,
      );
    }
  }

  DbAccount toDbAccount() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.dbAccount;
    } else {
      return account.toDbAccount();
    }
  }

  DbStatus? toReblogDbStatus() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.reblogDbStatus;
    } else {
      return reblog?.toDbStatus();
    }
  }

  DbAccount? toReblogStatusDbAccount() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.reblogDbStatusAccount;
    } else {
      return reblog?.account.toDbAccount();
    }
  }

  DbStatus? toReplyDbStatus() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.replyDbStatus;
    } else {
      return inReplyToStatus?.toDbStatus();
    }
  }

  DbAccount? toReplyStatusDbAccount() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.replyDbStatusAccount;
    } else {
      return inReplyToStatus?.account.toDbAccount();
    }
  }

  DbStatus? toReplyReblogDbStatus() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper.dbStatusPopulated.replyReblogDbStatus;
    } else {
      return reblog?.inReplyToStatus?.toDbStatus();
    }
  }

  DbAccount? toReplyReblogStatusDbAccount() {
    if (this is DbStatusPopulatedWrapper) {
      var dbStatusPopulatedWrapper = this as DbStatusPopulatedWrapper;

      return dbStatusPopulatedWrapper
          .dbStatusPopulated.replyReblogDbStatusAccount;
    } else {
      return reblog?.inReplyToStatus?.account.toDbAccount();
    }
  }
}

class DbStatusPopulatedWrapper extends IStatus {
  final DbStatusPopulated dbStatusPopulated;

  DbStatusPopulatedWrapper({
    required this.dbStatusPopulated,
  });

  @override
  DbAccountPopulatedWrapper get account => DbAccountPopulatedWrapper(
        dbAccountPopulated: DbAccountPopulated(
          dbAccount: dbStatusPopulated.dbAccount,
        ),
      );

  @override
  PleromaApiApplication? get application =>
      dbStatusPopulated.dbStatus.application;

  @override
  bool get bookmarked => dbStatusPopulated.dbStatus.bookmarked == true;

  @override
  PleromaApiCard? get card => dbStatusPopulated.dbStatus.card;

  @override
  String? get content => dbStatusPopulated.dbStatus.content;

  @override
  DateTime get createdAt => dbStatusPopulated.dbStatus.createdAt;

  @override
  List<PleromaApiEmoji>? get emojis => dbStatusPopulated.dbStatus.emojis;

  @override
  bool get favourited => dbStatusPopulated.dbStatus.favourited;

  @override
  int get favouritesCount => dbStatusPopulated.dbStatus.favouritesCount;

  @override
  IStatus? get inReplyToStatus {
    var replyDbStatus = dbStatusPopulated.replyDbStatus;
    var replyDbStatusAccount = dbStatusPopulated.replyDbStatusAccount;
    if (replyDbStatus != null && replyDbStatusAccount != null) {
      return DbStatusPopulatedWrapper(
        dbStatusPopulated: DbStatusPopulated(
          dbStatus: replyDbStatus,
          dbAccount: replyDbStatusAccount,
          reblogDbStatus: dbStatusPopulated.replyReblogDbStatus,
          reblogDbStatusAccount: dbStatusPopulated.replyReblogDbStatusAccount,
          replyDbStatus: null,
          replyReblogDbStatusAccount: null,
          replyReblogDbStatus: null,
          replyDbStatusAccount: null,
        ),
      );
    } else {
      return null;
    }
  }

  @override
  String? get inReplyToAccountRemoteId =>
      dbStatusPopulated.dbStatus.inReplyToAccountRemoteId;

  @override
  String? get inReplyToRemoteId => dbStatusPopulated.dbStatus.inReplyToRemoteId;

  @override
  int? get localId => dbStatusPopulated.dbStatus.id;

  @override
  List<PleromaApiMediaAttachment>? get mediaAttachments =>
      dbStatusPopulated.dbStatus.mediaAttachments;

  @override
  List<PleromaApiMention>? get mentions => dbStatusPopulated.dbStatus.mentions;

  @override
  bool get muted => dbStatusPopulated.dbStatus.muted;

  @override
  PleromaApiContent? get pleromaContent =>
      dbStatusPopulated.dbStatus.pleromaContent;

  @override
  int? get pleromaConversationId =>
      dbStatusPopulated.dbStatus.pleromaConversationId;

  @override
  int? get pleromaDirectConversationId =>
      dbStatusPopulated.dbStatus.pleromaDirectConversationId;

  @override
  List<PleromaApiStatusEmojiReaction>? get pleromaEmojiReactions =>
      dbStatusPopulated.dbStatus.pleromaEmojiReactions;

  @override
  DateTime? get pleromaExpiresAt => dbStatusPopulated.dbStatus.pleromaExpiresAt;

  @override
  String? get pleromaInReplyToAccountAcct =>
      dbStatusPopulated.dbStatus.pleromaInReplyToAccountAcct;

  @override
  bool? get pleromaLocal => dbStatusPopulated.dbStatus.pleromaLocal;

  @override
  PleromaApiContent? get pleromaSpoilerText =>
      dbStatusPopulated.dbStatus.pleromaSpoilerText;

  @override
  bool? get pleromaThreadMuted => dbStatusPopulated.dbStatus.pleromaThreadMuted;

  @override
  PleromaApiPoll? get poll => dbStatusPopulated.dbStatus.poll;

  @override
  String? get reblogStatusRemoteId =>
      dbStatusPopulated.dbStatus.reblogStatusRemoteId;

  @override
  bool get reblogged => dbStatusPopulated.dbStatus.reblogged;

  @override
  int get reblogsCount => dbStatusPopulated.dbStatus.reblogsCount;

  @override
  String get remoteId => dbStatusPopulated.dbStatus.remoteId;

  @override
  int get repliesCount => dbStatusPopulated.dbStatus.repliesCount;

  @override
  bool get nsfwSensitive => dbStatusPopulated.dbStatus.sensitive;

  @override
  String? get spoilerText => dbStatusPopulated.dbStatus.spoilerText;

  @override
  List<PleromaApiTag>? get tags => dbStatusPopulated.dbStatus.tags;

  @override
  String get uri => dbStatusPopulated.dbStatus.uri;

  @override
  String? get url => dbStatusPopulated.dbStatus.url;

  @override
  PleromaApiVisibility get visibility => dbStatusPopulated.dbStatus.visibility;

  @override
  String? get language => dbStatusPopulated.dbStatus.language;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbStatusPopulatedWrapper &&
          runtimeType == other.runtimeType &&
          dbStatusPopulated == other.dbStatusPopulated;

  @override
  int get hashCode => dbStatusPopulated.hashCode;

  @override
  String toString() {
    return 'DbStatusPopulatedWrapper{dbStatusPopulated: $dbStatusPopulated}';
  }

  @override
  bool get pinned => dbStatusPopulated.dbStatus.pinned == true;

  @override
  bool get deleted => dbStatusPopulated.dbStatus.deleted == true;

  @override
  bool get hiddenLocallyOnDevice =>
      dbStatusPopulated.dbStatus.hiddenLocallyOnDevice == true;

  @override
  PendingState? get pendingState => dbStatusPopulated.dbStatus.pendingState;

  @override
  String? get oldPendingRemoteId =>
      dbStatusPopulated.dbStatus.oldPendingRemoteId;

  @override
  IStatus? get reblog {
    var reblogDbStatus = dbStatusPopulated.reblogDbStatus;
    var reblogDbStatusAccount = dbStatusPopulated.reblogDbStatusAccount;
    if (reblogDbStatus != null && reblogDbStatusAccount != null) {
      return DbStatusPopulatedWrapper(
        dbStatusPopulated: DbStatusPopulated(
          dbStatus: reblogDbStatus,
          dbAccount: reblogDbStatusAccount,
          reblogDbStatus: null,
          reblogDbStatusAccount: null,
          replyDbStatus: null,
          replyReblogDbStatusAccount: null,
          replyDbStatusAccount: null,
          replyReblogDbStatus: null,
        ),
      );
    } else {
      return null;
    }
  }

  @override
  // ignore: long-parameter-list, code-metrics, long-method
  DbStatusPopulatedWrapper copyWith({
    IAccount? account,
    IStatus? reblog,
    int? id,
    String? remoteId,
    DateTime? createdAt,
    IStatus? inReplyToStatus,
    String? inReplyToRemoteId,
    String? inReplyToAccountRemoteId,
    bool? nsfwSensitive,
    String? spoilerText,
    PleromaApiVisibility? visibility,
    String? uri,
    String? url,
    int? repliesCount,
    int? reblogsCount,
    int? favouritesCount,
    bool? favourited,
    bool? reblogged,
    bool? muted,
    bool? bookmarked,
    bool? pinned,
    String? content,
    String? reblogStatusRemoteId,
    PleromaApiApplication? application,
    String? accountRemoteId,
    List<PleromaApiMediaAttachment>? mediaAttachments,
    List<PleromaApiMention>? mentions,
    List<PleromaApiTag>? tags,
    List<PleromaApiEmoji>? emojis,
    PleromaApiPoll? poll,
    PleromaApiCard? card,
    String? language,
    PleromaApiContent? pleromaContent,
    int? pleromaConversationId,
    int? pleromaDirectConversationId,
    String? pleromaInReplyToAccountAcct,
    bool? pleromaLocal,
    PleromaApiContent? pleromaSpoilerText,
    DateTime? pleromaExpiresAt,
    bool? pleromaThreadMuted,
    List<PleromaApiStatusEmojiReaction>? pleromaEmojiReactions,
    bool? deleted,
    PendingState? pendingState,
    String? oldPendingRemoteId,
    bool? hiddenLocallyOnDevice,
    String? wasSentWithIdempotencyKey,
  }) {
    var reblogStatus = reblog?.toDbStatus();
    var reblogStatusAccount = reblog?.account.toDbAccount();

    var replyStatus = inReplyToStatus?.toDbStatus();
    var replyStatusAccount = inReplyToStatus?.account.toDbAccount();

    var replyReblogStatus = inReplyToStatus?.reblog?.toDbStatus();
    var replyReblogStatusAccount =
        inReplyToStatus?.reblog?.account.toDbAccount();

    return DbStatusPopulatedWrapper(
      dbStatusPopulated: dbStatusPopulated.copyWith(
        dbStatus: dbStatusPopulated.dbStatus.copyWith(
          id: id,
          remoteId: remoteId,
          createdAt: createdAt,
          inReplyToRemoteId: inReplyToRemoteId,
          inReplyToAccountRemoteId: inReplyToAccountRemoteId,
          sensitive: nsfwSensitive,
          spoilerText: spoilerText,
          visibility: visibility,
          uri: uri,
          url: url,
          repliesCount: repliesCount,
          reblogsCount: reblogsCount,
          favouritesCount: favouritesCount,
          favourited: favourited,
          reblogged: reblogged,
          muted: muted,
          bookmarked: bookmarked,
          pinned: pinned,
          content: content,
          reblogStatusRemoteId: reblogStatusRemoteId,
          application: application,
          accountRemoteId: accountRemoteId,
          mediaAttachments: mediaAttachments,
          mentions: mentions,
          tags: tags,
          emojis: emojis,
          poll: poll,
          card: card,
          language: language,
          pleromaContent: pleromaContent,
          pleromaConversationId: pleromaConversationId,
          pleromaDirectConversationId: pleromaDirectConversationId,
          pleromaInReplyToAccountAcct: pleromaInReplyToAccountAcct,
          pleromaLocal: pleromaLocal,
          pleromaSpoilerText: pleromaSpoilerText,
          pleromaExpiresAt: pleromaExpiresAt,
          pleromaThreadMuted: pleromaThreadMuted,
          pleromaEmojiReactions: pleromaEmojiReactions,
          deleted: deleted,
          pendingState: pendingState,
          oldPendingRemoteId: oldPendingRemoteId,
          hiddenLocallyOnDevice: hiddenLocallyOnDevice,
          wasSentWithIdempotencyKey: wasSentWithIdempotencyKey,
        ),
        dbAccount: dbStatusPopulated.dbAccount.copyWith(
          id: account?.localId,
          remoteId: account?.remoteId,
          username: account?.username,
          url: account?.url,
          note: account?.note,
          locked: account?.locked,
          headerStatic: account?.headerStatic,
          header: account?.header,
          followingCount: account?.followingCount,
          followersCount: account?.followersCount,
          statusesCount: account?.statusesCount,
          displayName: account?.displayName,
          createdAt: account?.createdAt,
          bot: account?.bot,
          avatarStatic: account?.avatarStatic,
          avatar: account?.avatar,
          acct: account?.acct,
          lastStatusAt: account?.lastStatusAt,
          fields: account?.fields?.toPleromaApiFields(),
          emojis: account?.emojis?.toPleromaApiEmojis(),
          pleromaRelationship: account?.pleromaRelationship,
          pleromaTags: account?.pleromaTags?.toPleromaApiTags(),
          pleromaIsAdmin: account?.pleromaIsAdmin,
          pleromaIsModerator: account?.pleromaIsModerator,
          pleromaConfirmationPending: account?.pleromaConfirmationPending,
          pleromaHideFavorites: account?.pleromaHideFavorites,
          pleromaHideFollowers: account?.pleromaHideFollowers,
          pleromaHideFollows: account?.pleromaHideFollows,
          pleromaHideFollowersCount: account?.pleromaHideFollowersCount,
          pleromaHideFollowsCount: account?.pleromaHideFollowsCount,
          pleromaDeactivated: account?.pleromaDeactivated,
          pleromaAllowFollowingMove: account?.pleromaAllowFollowingMove,
          pleromaSkipThreadContainment: account?.pleromaSkipThreadContainment,
        ),
        reblogDbStatus: reblogStatus,
        reblogDbStatusAccount: reblogStatusAccount,
        replyDbStatus: replyStatus,
        replyDbStatusAccount: replyStatusAccount,
        replyReblogDbStatus: replyReblogStatus,
        replyReblogDbStatusAccount: replyReblogStatusAccount,
      ),
    );
  }

  @override
  String? get wasSentWithIdempotencyKey =>
      dbStatusPopulated.dbStatus.wasSentWithIdempotencyKey;

  @override
  int compareTo(IStatus b) => IStatus.compareItemsToSort(this, b);

  @override
  bool isEqualTo(IStatus b) => IStatus.isItemsEqual(this, b);
}

class DbStatusPopulated {
  final DbStatus dbStatus;
  final DbAccount dbAccount;
  final DbStatus? reblogDbStatus;
  final DbAccount? reblogDbStatusAccount;
  final DbStatus? replyDbStatus;
  final DbAccount? replyDbStatusAccount;
  final DbStatus? replyReblogDbStatus;
  final DbAccount? replyReblogDbStatusAccount;

  DbStatusPopulated({
    required this.dbStatus,
    required this.dbAccount,
    required this.reblogDbStatus,
    required this.reblogDbStatusAccount,
    required this.replyDbStatus,
    required this.replyDbStatusAccount,
    required this.replyReblogDbStatus,
    required this.replyReblogDbStatusAccount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbStatusPopulated &&
          runtimeType == other.runtimeType &&
          dbStatus == other.dbStatus &&
          dbAccount == other.dbAccount &&
          reblogDbStatus == other.reblogDbStatus &&
          reblogDbStatusAccount == other.reblogDbStatusAccount &&
          replyDbStatus == other.replyDbStatus &&
          replyDbStatusAccount == other.replyDbStatusAccount &&
          replyReblogDbStatus == other.replyReblogDbStatus &&
          replyReblogDbStatusAccount == other.replyReblogDbStatusAccount;

  @override
  int get hashCode =>
      dbStatus.hashCode ^
      dbAccount.hashCode ^
      reblogDbStatus.hashCode ^
      reblogDbStatusAccount.hashCode ^
      replyDbStatus.hashCode ^
      replyDbStatusAccount.hashCode ^
      replyReblogDbStatus.hashCode ^
      replyReblogDbStatusAccount.hashCode;

  @override
  String toString() {
    return 'DbStatusPopulated{'
        'dbStatus: $dbStatus, '
        'dbAccount: $dbAccount, '
        'reblogDbStatus: $reblogDbStatus, '
        'reblogDbStatusAccount: $reblogDbStatusAccount, '
        'replyDbStatus: $replyDbStatus, '
        'replyDbStatusAccount: $replyDbStatusAccount, '
        'replyReblogDbStatus: $replyReblogDbStatus, '
        'replyReblogDbStatusAccount: $replyReblogDbStatusAccount'
        '}';
  }

  // ignore: long-parameter-list
  DbStatusPopulated copyWith({
    DbStatus? dbStatus,
    DbAccount? dbAccount,
    DbStatus? reblogDbStatus,
    DbAccount? reblogDbStatusAccount,
    DbStatus? replyDbStatus,
    DbAccount? replyDbStatusAccount,
    DbStatus? replyReblogDbStatus,
    DbAccount? replyReblogDbStatusAccount,
  }) =>
      DbStatusPopulated(
        dbStatus: dbStatus ?? this.dbStatus,
        dbAccount: dbAccount ?? this.dbAccount,
        reblogDbStatus: reblogDbStatus ?? this.reblogDbStatus,
        reblogDbStatusAccount:
            reblogDbStatusAccount ?? this.reblogDbStatusAccount,
        replyDbStatus: replyDbStatus ?? this.replyDbStatus,
        replyDbStatusAccount: replyDbStatusAccount ?? this.replyDbStatusAccount,
        replyReblogDbStatus: replyReblogDbStatus ?? this.replyReblogDbStatus,
        replyReblogDbStatusAccount:
            replyReblogDbStatusAccount ?? this.replyReblogDbStatusAccount,
      );
}

extension IStatusExtension on IStatus {
  Uri get urlRemoteHostUri {
    var uri = Uri.parse(url ?? this.uri);

    var resultUrl = '${uri.scheme}://${uri.host}';

    return Uri.parse(resultUrl);
  }

  String get urlRemoteId {
    try {
      // todo: perhaps need improvements
      var splitResult = (url ?? uri).split('/');

      var isHaveEndingSlash = splitResult.last.isNotEmpty;
      if (isHaveEndingSlash) {
        return splitResult.last;
      } else {
        // ignore: no-magic-number
        var middleIndex = splitResult.length - 2;

        return splitResult[middleIndex];
      }
    } catch (e, stackTrace) {
      var exception = CantExtractStatusRemoteIdFromStatusUrlException(
        e: e,
        status: this,
      );
      _logger.shout(() => '$exception', stackTrace);
      throw exception;
    }
  }
}

extension DbStatusPopulatedExtension on DbStatusPopulated {
  DbStatusPopulatedWrapper toDbStatusPopulatedWrapper() =>
      DbStatusPopulatedWrapper(dbStatusPopulated: this);
}

extension DbStatusPopulatedListExtension on List<DbStatusPopulated> {
  List<DbStatusPopulatedWrapper> toDbStatusPopulatedWrappers() => map(
        (item) => item.toDbStatusPopulatedWrapper(),
      ).toList();
}

class CantExtractStatusRemoteIdFromStatusUrlException implements Exception {
  final IStatus status;
  final dynamic e;

  CantExtractStatusRemoteIdFromStatusUrlException({
    required this.status,
    this.e,
  });

  @override
  String toString() {
    return 'CantExtractStatusRemoteIdFromStatusUrlException{'
        'status: $status, '
        'e: $e'
        '}';
  }
}

extension IPleromaApiMentionStatusListExtension on List<IStatus> {
  List<IPleromaApiMention> findAllMentions() {
    var statuses = this;
    var mentions = <IPleromaApiMention>{};

    statuses.forEach(
      (status) {
        mentions.addAll(status.mentions ?? []);
      },
    );

    return mentions.toList();
  }
}
