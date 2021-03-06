import 'package:fedi/app/ui/settings/local_preference/global/global_ui_settings_local_preference_bloc_impl.dart';
import 'package:fedi/app/ui/settings/local_preference/ui_settings_local_preference_bloc_impl.dart';
import 'package:fedi/app/ui/settings/ui_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../local_preferences/local_preferences_test_helper.dart';
import '../../ui_settings_model_test_helper.dart';

// ignore_for_file: no-magic-number

void main() {
  test('save & load', () async {
    await LocalPreferencesTestHelper.testSaveAndLoad<UiSettings,
        UiSettingsLocalPreferenceBloc>(
      defaultValue: GlobalUiSettingsLocalPreferenceBloc.defaultValue,
      blocCreator: (localPreferencesService) =>
          GlobalUiSettingsLocalPreferenceBloc(localPreferencesService),
      testObjectCreator: ({required String seed}) =>
          UiSettingsModelTestHelper.createTestUiSettings(
        seed: seed,
      ),
    );
  });
}
