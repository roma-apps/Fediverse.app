import 'dart:convert';

import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/card/pleroma_api_card_model.dart';
import 'package:fedi/pleroma/api/emoji/pleroma_api_emoji_model.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pleroma_api_chat_model.g.dart';

abstract class IPleromaApiChat {
  String get id;

  int get unread;

  DateTime? get updatedAt;

  IPleromaApiAccount get account;

  IPleromaApiChatMessage? get lastMessage;
}

@JsonSerializable(explicitToJson: true)
class PleromaApiChat implements IPleromaApiChat {
  @override
  final String id;
  @override
  final int unread;

  @override
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @override
  final PleromaApiAccount account;

  @override
  @JsonKey(name: "last_message")
  final PleromaApiChatMessage? lastMessage;

  PleromaApiChat({
    required this.id,
    required this.unread,
    required this.account,
    required this.updatedAt,
    required this.lastMessage,
  });

  PleromaApiChat copyWith({
    String? id,
    bool? unread,
    PleromaApiAccount? account,
    DateTime? updatedAt,
    PleromaApiChatMessage? lastMessage,
  }) =>
      PleromaApiChat(
        id: id ?? this.id,
        unread: unread as int? ?? this.unread,
        account: account ?? this.account,
        updatedAt: updatedAt ?? this.updatedAt,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory PleromaApiChat.fromJson(Map<String, dynamic> json) =>
      _$PleromaApiChatFromJson(json);

  factory PleromaApiChat.fromJsonString(String jsonString) =>
      _$PleromaApiChatFromJson(jsonDecode(jsonString));

  static List<PleromaApiChat> listFromJsonString(String str) =>
      List<PleromaApiChat>.from(
        json.decode(str).map((x) => PleromaApiChat.fromJson(x)),
      );

  Map<String, dynamic> toJson() => _$PleromaApiChatToJson(this);

  String toJsonString() => jsonEncode(_$PleromaApiChatToJson(this));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaApiChat &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          unread == other.unread &&
          updatedAt == other.updatedAt &&
          account == other.account &&
          lastMessage == other.lastMessage;

  @override
  int get hashCode =>
      id.hashCode ^
      unread.hashCode ^
      updatedAt.hashCode ^
      account.hashCode ^
      lastMessage.hashCode;

  @override
  String toString() {
    return 'PleromaApiChat{'
        'id: $id, '
        'unread: $unread, '
        'updatedAt: $updatedAt, '
        'account: $account, '
        'lastMessage: $lastMessage'
        '}';
  }
}

abstract class IPleromaApiChatMessage {
  String get id;

  String get chatId;

  String get accountId;

  String? get content;

  DateTime get createdAt;

  List<IPleromaApiEmoji>? get emojis;

  IPleromaApiMediaAttachment? get mediaAttachment;

  IPleromaApiCard? get card;
}

@JsonSerializable(explicitToJson: true)
class PleromaApiChatMessage extends IPleromaApiChatMessage {
  @override
  final String id;
  @override
  @JsonKey(name: "chat_id")
  final String chatId;
  @override
  @JsonKey(name: "account_id")
  final String accountId;
  @override
  final String? content;
  @override
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @override
  final List<PleromaApiEmoji>? emojis;
  @override
  @JsonKey(name: "attachment")
  final PleromaApiMediaAttachment? mediaAttachment;

  @override
  final PleromaApiCard? card;

  PleromaApiChatMessage({
    required this.id,
    required this.chatId,
    required this.accountId,
    required this.content,
    required this.createdAt,
    required this.emojis,
    required this.mediaAttachment,
    required this.card,
  });

  @override
  String toString() {
    return 'PleromaApiChatMessage{'
        'id: $id, '
        'chatId: $chatId, '
        'accountId: $accountId, '
        'content: $content, '
        'createdAt: $createdAt, '
        'emojis: $emojis, '
        'mediaAttachment: $mediaAttachment '
        'card: $card'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaApiChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          chatId == other.chatId &&
          accountId == other.accountId &&
          content == other.content &&
          createdAt == other.createdAt &&
          emojis == other.emojis &&
          mediaAttachment == other.mediaAttachment &&
          card == other.card;

  @override
  int get hashCode =>
      id.hashCode ^
      chatId.hashCode ^
      accountId.hashCode ^
      content.hashCode ^
      createdAt.hashCode ^
      emojis.hashCode ^
      mediaAttachment.hashCode ^
      card.hashCode;

  factory PleromaApiChatMessage.fromJson(Map<String, dynamic> json) =>
      _$PleromaApiChatMessageFromJson(json);

  factory PleromaApiChatMessage.fromJsonString(String jsonString) =>
      _$PleromaApiChatMessageFromJson(jsonDecode(jsonString));

  static List<PleromaApiChatMessage> listFromJsonString(String str) =>
      List<PleromaApiChatMessage>.from(
        json.decode(str).map((x) => PleromaApiChatMessage.fromJson(x)),
      );

  Map<String, dynamic> toJson() => _$PleromaApiChatMessageToJson(this);

  String toJsonString() => jsonEncode(_$PleromaApiChatMessageToJson(this));
}

abstract class IPleromaApiChatMessageSendData {
  String? get content;

  String? get mediaId;

  String? get idempotencyKey;

  IPleromaApiChatMessageSendData copyWith({
    String? content,
    String? mediaId,
    String? idempotencyKey,
  });

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class PleromaApiChatMessageSendData implements IPleromaApiChatMessageSendData {
  @override
  final String? content;
  @override
  @JsonKey(name: "media_id")
  final String? mediaId;

  @override
  @JsonKey(name: "idempotency_key")
  final String? idempotencyKey;

  PleromaApiChatMessageSendData({
    required this.content,
    required this.mediaId,
    required this.idempotencyKey,
  });

  @override
  PleromaApiChatMessageSendData copyWith({
    String? content,
    String? mediaId,
    String? idempotencyKey,
  }) =>
      PleromaApiChatMessageSendData(
        content: content ?? this.content,
        mediaId: mediaId ?? this.mediaId,
        idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaApiChatMessageSendData &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          mediaId == other.mediaId;

  @override
  int get hashCode => content.hashCode ^ mediaId.hashCode;

  @override
  String toString() {
    return 'PleromaApiChatMessageSendData{'
        'content: $content, '
        'mediaId: $mediaId'
        '}';
  }

  factory PleromaApiChatMessageSendData.fromJson(Map<String, dynamic> json) =>
      _$PleromaApiChatMessageSendDataFromJson(json);

  factory PleromaApiChatMessageSendData.fromJsonString(String jsonString) =>
      _$PleromaApiChatMessageSendDataFromJson(jsonDecode(jsonString));

  static List<PleromaApiChatMessageSendData> listFromJsonString(String str) =>
      List<PleromaApiChatMessageSendData>.from(
        json.decode(str).map((x) => PleromaApiChatMessageSendData.fromJson(x)),
      );

  @override
  Map<String, dynamic> toJson() => _$PleromaApiChatMessageSendDataToJson(this);

  String toJsonString() => jsonEncode(_$PleromaApiChatMessageSendDataToJson(this));
}