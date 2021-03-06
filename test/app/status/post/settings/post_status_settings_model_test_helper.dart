import 'package:fedi/app/status/post/settings/post_status_settings_model.dart';
import 'package:fedi/pleroma/api/visibility/pleroma_api_visibility_model.dart';

import '../../../../localization/localization_model_test_helper.dart';

// ignore_for_file: no-magic-number
class PostStatusSettingsModelTestHelper {
  static PostStatusSettings createTestPostStatusSettings({
    required String seed,
  }) =>
      PostStatusSettings(
        markMediaAsNsfwOnAttach: seed.hashCode % 2 == 0,
        defaultVisibilityString: PleromaApiVisibility
            .values[seed.hashCode % PleromaApiVisibility.values.length]
            .toJsonValue(),
        defaultStatusLocale:
            LocalizationModelTestHelper.createTestLocalizationLocale(
          seed: seed,
        ),
      );
}
