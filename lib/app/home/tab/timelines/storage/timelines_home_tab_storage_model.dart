import 'package:fedi/app/timeline/timeline_model.dart';
import 'package:fedi/collection/collection_hash_utils.dart';
import 'package:fedi/json/json_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

// ignore_for_file: no-magic-number
part 'timelines_home_tab_storage_model.g.dart';

enum TimelinesHomeTabStorageUiState { edit, view }

class TimelinesHomeTabStorageListItem {
  final Timeline timeline;
  final Key key;

  TimelinesHomeTabStorageListItem(this.timeline)
      : key = ValueKey('timeline.${timeline.id}');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimelinesHomeTabStorageListItem &&
          runtimeType == other.runtimeType &&
          timeline == other.timeline &&
          key == other.key;

  @override
  int get hashCode => timeline.hashCode ^ key.hashCode;

  @override
  String toString() {
    return 'TimelinesHomeTabStorageListItem{timeline: $timeline, key: $key}';
  }
}

// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 81)
@JsonSerializable()
class TimelinesHomeTabStorage implements IJsonObject {
  @HiveField(0)
  @JsonKey(name: 'timeline_ids')
  final List<String> timelineIds;

  const TimelinesHomeTabStorage({
    required this.timelineIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimelinesHomeTabStorage &&
          runtimeType == other.runtimeType &&
          listEquals(timelineIds, other.timelineIds);

  @override
  int get hashCode => listHash(timelineIds);

  TimelinesHomeTabStorage copyWith({
    List<String>? timelineIds,
  }) =>
      TimelinesHomeTabStorage(
        timelineIds: timelineIds ?? this.timelineIds,
      );

  @override
  String toString() {
    return 'TimelinesHomeTabStorage{timelineIds: $timelineIds}';
  }

  static TimelinesHomeTabStorage fromJson(Map<String, dynamic> json) =>
      _$TimelinesHomeTabStorageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TimelinesHomeTabStorageToJson(this);
}
