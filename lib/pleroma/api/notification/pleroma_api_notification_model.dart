import 'package:fedi/json/json_model.dart';
import 'package:fedi/mastodon/api/notification/mastodon_api_notification_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_model.dart';
import 'package:fedi/pleroma/api/status/pleroma_api_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pleroma_api_notification_model.g.dart';

extension IPleromaApiNotificationExtension on IPleromaApiNotification {
  PleromaApiNotification toPleromaApiNotification() {
    if (this is PleromaApiNotification) {
      return this as PleromaApiNotification;
    } else {
      return PleromaApiNotification(
        account: account?.toPleromaApiAccount(),
        createdAt: createdAt,
        id: id,
        type: type,
        status: status?.toPleromaApiStatus(),
        chatMessage: chatMessage?.toPleromaApiChatMessage(),
        emoji: emoji,
        pleroma: pleroma,
        report: report?.toPleromaApiAccountReport(),
        target: target?.toPleromaApiAccount(),
      );
    }
  }
}

abstract class IPleromaApiNotification extends IMastodonApiNotification {
  @override
  IPleromaApiAccount? get account;

  IPleromaApiAccount? get target;

  @override
  IPleromaApiStatus? get status;

  IPleromaApiChatMessage? get chatMessage;

  PleromaApiNotificationType get typeAsPleromaApi;

  String? get emoji;

  PleromaApiNotificationPleromaPart? get pleroma;

  IPleromaApiAccountReport? get report;
}

enum PleromaApiNotificationType {
  follow,
  favourite,
  reblog,
  mention,
  poll,
  move,
  followRequest,
  pleromaEmojiReaction,
  pleromaChatMention,
  pleromaReport,
  unknown,
}

const unknownPleromaApiNotificationType = PleromaApiNotificationType.unknown;

const _followPleromaApiNotificationTypeJsonValue = 'follow';
const _favouritePleromaApiNotificationTypeJsonValue = 'favourite';
const _reblogPleromaApiNotificationTypeJsonValue = 'reblog';
const _mentionPleromaApiNotificationTypeJsonValue = 'mention';
const _pollPleromaApiNotificationTypeJsonValue = 'poll';
const _movePleromaApiNotificationTypeJsonValue = 'move';
const _followRequestPleromaApiNotificationTypeJsonValue = 'follow_request';
const _pleromaEmojiReactionRequestPleromaApiNotificationTypeJsonValue =
    'pleroma:emoji_reaction';
const _pleromaChatMentionRequestPleromaApiNotificationTypeJsonValue =
    'pleroma:chat_mention';
const _pleromaReportRequestPleromaApiNotificationTypeJsonValue =
    'pleroma:report';
const _unknownRequestPleromaApiNotificationTypeJsonValue = 'unknown';

extension PleromaApiNotificationTypeListExtension
    on List<PleromaApiNotificationType> {
  List<PleromaApiNotificationType> valuesWithoutSelected(
    List<PleromaApiNotificationType> valuesToExclude,
  ) =>
      where(
        (value) => !valuesToExclude.contains(
          value,
        ),
      ).toList();
}

extension PleromaApiNotificationTypeExtension on PleromaApiNotificationType {
  String toJsonValue() {
    String result;

    switch (this) {
      case PleromaApiNotificationType.follow:
        result = _followPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.favourite:
        result = _favouritePleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.reblog:
        result = _reblogPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.mention:
        result = _mentionPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.poll:
        result = _pollPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.move:
        result = _movePleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.followRequest:
        result = _followRequestPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.pleromaEmojiReaction:
        result =
            _pleromaEmojiReactionRequestPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.pleromaChatMention:
        result = _pleromaChatMentionRequestPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.pleromaReport:
        result = _pleromaReportRequestPleromaApiNotificationTypeJsonValue;
        break;
      case PleromaApiNotificationType.unknown:
        result = _unknownRequestPleromaApiNotificationTypeJsonValue;
        break;
    }

    return result;
  }
}

extension PleromaApiNotificationTypeStringExtension on String {
  PleromaApiNotificationType toPleromaApiNotificationType() {
    PleromaApiNotificationType result;

    switch (this) {
      case _followPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.follow;
        break;
      case _movePleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.move;
        break;
      case _favouritePleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.favourite;
        break;
      case _pollPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.poll;
        break;
      case _mentionPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.mention;
        break;
      case _reblogPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.reblog;
        break;
      case _followRequestPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.followRequest;
        break;
      case _pleromaChatMentionRequestPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.pleromaChatMention;
        break;
      case _pleromaEmojiReactionRequestPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.pleromaEmojiReaction;
        break;
      case _pleromaReportRequestPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.pleromaReport;
        break;
      case _unknownRequestPleromaApiNotificationTypeJsonValue:
        result = PleromaApiNotificationType.unknown;
        break;
      // cant parse, default value
      default:
        result = unknownPleromaApiNotificationType;
        break;
    }

    return result;
  }
}

@JsonSerializable()
class PleromaApiNotificationPleromaPart {
  @JsonKey(name: 'is_seen')
  final bool? isSeen;
  @JsonKey(name: 'is_muted')
  final bool? isMuted;

  PleromaApiNotificationPleromaPart({
    required this.isSeen,
    required this.isMuted,
  });

  PleromaApiNotificationPleromaPart copyWith({
    bool? isSeen,
    bool? isMuted,
  }) =>
      PleromaApiNotificationPleromaPart(
        isSeen: isSeen ?? this.isSeen,
        isMuted: isMuted ?? this.isMuted,
      );

  static PleromaApiNotificationPleromaPart fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PleromaApiNotificationPleromaPartFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PleromaApiNotificationPleromaPartToJson(this);

  @override
  String toString() {
    return 'PleromaApiNotificationPleromaPart{'
        'isSeen: $isSeen, '
        'isMuted: $isMuted'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaApiNotificationPleromaPart &&
          runtimeType == other.runtimeType &&
          isSeen == other.isSeen &&
          isMuted == other.isMuted;

  @override
  int get hashCode => isSeen.hashCode ^ isMuted.hashCode;
}

@JsonSerializable(explicitToJson: true)
class PleromaApiNotification extends IPleromaApiNotification
    implements IJsonObject {
  @override
  final PleromaApiAccount? account;
  @override
  final PleromaApiAccount? target;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final String id;
  @override
  final String type;
  @override
  final PleromaApiStatus? status;
  @override
  final String? emoji;
  @override
  final PleromaApiNotificationPleromaPart? pleroma;

  @override
  @JsonKey(name: 'chat_message')
  final PleromaApiChatMessage? chatMessage;

  @override
  final PleromaApiAccountReport? report;

  PleromaApiNotification({
    required this.account,
    required this.createdAt,
    required this.id,
    required this.type,
    required this.status,
    required this.chatMessage,
    required this.emoji,
    required this.pleroma,
    required this.report,
    required this.target,
  });

  static PleromaApiNotification fromJson(Map<String, dynamic> json) =>
      _$PleromaApiNotificationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PleromaApiNotificationToJson(this);

  @override
  String toString() {
    return 'PleromaApiNotification{'
        'id: $id, '
        'account: $account, '
        'createdAt: $createdAt, '
        'type: $type, '
        'status: $status'
        '}';
  }

  @override
  MastodonApiNotificationType get typeAsMastodonApi =>
      type.toMastodonApiNotificationType();

  @override
  PleromaApiNotificationType get typeAsPleromaApi =>
      type.toPleromaApiNotificationType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaApiNotification &&
          runtimeType == other.runtimeType &&
          account == other.account &&
          target == other.target &&
          createdAt == other.createdAt &&
          id == other.id &&
          type == other.type &&
          status == other.status &&
          emoji == other.emoji &&
          pleroma == other.pleroma &&
          chatMessage == other.chatMessage &&
          report == other.report;

  @override
  int get hashCode =>
      account.hashCode ^
      target.hashCode ^
      createdAt.hashCode ^
      id.hashCode ^
      type.hashCode ^
      status.hashCode ^
      emoji.hashCode ^
      pleroma.hashCode ^
      chatMessage.hashCode ^
      report.hashCode;
}
