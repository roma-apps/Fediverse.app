import 'package:fedi/app/timeline/timeline_model.dart';
import 'package:fedi/app/timeline/type/timeline_type_model.dart';

import '../../enum/enum_test_helper.dart';
import 'settings/timeline_settings_model_test_helper.dart';

// ignore_for_file: no-magic-number
class TimelineModelTestHelper {
  static Timeline createTestTimeline({
    required String seed,
  }) =>
      Timeline(
        id: seed + 'id',
        typeString: EnumTestHelper.createTestEnum(
          seed: seed,
          values: TimelineType.values,
        ).toJsonValue(),
        settings: TimelineSettingsModelTestHelper.createTestTimelineSettings(
          seed: seed,
        ),
        label: seed + 'label',
        isPossibleToDelete: seed.hashCode % 2 == 0,
      );
}
