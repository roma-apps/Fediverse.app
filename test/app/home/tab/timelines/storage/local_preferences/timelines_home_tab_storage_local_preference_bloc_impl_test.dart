import 'package:fedi/app/home/tab/timelines/storage/local_preferences/timelines_home_tab_storage_local_preference_bloc_impl.dart';
import 'package:fedi/app/home/tab/timelines/storage/timelines_home_tab_storage_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../local_preferences/local_preferences_test_helper.dart';
import '../timelines_home_tab_storage_model_test_helper.dart';

// ignore_for_file: no-magic-number
void main() {
  test('save & load', () async {
    await LocalPreferencesTestHelper.testSaveAndLoad<TimelinesHomeTabStorage,
        TimelinesHomeTabStorageLocalPreferenceBloc>(
      defaultValue: TimelinesHomeTabStorageLocalPreferenceBloc.defaultValue,
      blocCreator: (localPreferencesService) =>
          TimelinesHomeTabStorageLocalPreferenceBloc(
        localPreferencesService,
        userAtHost: 'user@host',
      ),
      testObjectCreator: ({required String seed}) =>
          TimelinesHomeTabStorageModelTestHelper
              .createTestTimelinesHomeTabStorage(
        seed: seed,
      ),
    );
  });
}
