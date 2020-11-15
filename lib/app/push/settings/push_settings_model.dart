import 'dart:convert';

import 'package:fedi/app/settings/settings_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_settings_model.g.dart';

@JsonSerializable()
// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 47)
class PushSettings extends ISettings<PushSettings> {
  @HiveField(1)
  final bool favourite;
  @HiveField(2)
  final bool follow;
  @HiveField(3)
  final bool mention;
  @HiveField(4)
  final bool reblog;
  @HiveField(5)
  final bool poll;
  @HiveField(6)
  final bool chat;
  PushSettings({
    this.favourite,
    this.follow,
    this.mention,
    this.reblog,
    this.poll,
    this.chat,
  });

  PushSettings.defaultAllEnabled()
      : this(
          favourite: true,
          follow: true,
          mention: true,
          reblog: true,
          poll: true,
          chat: true,
        );
  PushSettings.defaultAllDisabled()
      : this(
          favourite: false,
          follow: false,
          mention: false,
          reblog: false,
          poll: false,
          chat: false,
        );


  @override
  String toString() {
    return 'PushSettings{favourite: $favourite,'
        ' follow: $follow, mention: $mention,'
        ' reblog: $reblog, poll: $poll, chat: $chat}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushSettings &&
          runtimeType == other.runtimeType &&
          favourite == other.favourite &&
          follow == other.follow &&
          mention == other.mention &&
          reblog == other.reblog &&
          poll == other.poll &&
          chat == other.chat;

  @override
  int get hashCode =>
      favourite.hashCode ^
      follow.hashCode ^
      mention.hashCode ^
      reblog.hashCode ^
      poll.hashCode ^
      chat.hashCode;

  factory PushSettings.fromJson(
          Map<String, dynamic> json) =>
      _$PushSettingsFromJson(json);

  factory PushSettings.fromJsonString(String jsonString) =>
      _$PushSettingsFromJson(jsonDecode(jsonString));

  @override
  Map<String, dynamic> toJson() =>
      _$PushSettingsToJson(this);
  String toJsonString() =>
      jsonEncode(_$PushSettingsToJson(this));

  PushSettings copyWith({
    bool favourite,
    bool follow,
    bool mention,
    bool reblog,
    bool poll,
    bool chat,
  }) => PushSettings(
      favourite: favourite ?? this.favourite,
      follow: follow ?? this.follow,
      mention: mention ?? this.mention,
      reblog: reblog ?? this.reblog,
      poll: poll ?? this.poll,
      chat: chat ?? this.chat,
    );

  @override
  PushSettings clone() => copyWith();
}
