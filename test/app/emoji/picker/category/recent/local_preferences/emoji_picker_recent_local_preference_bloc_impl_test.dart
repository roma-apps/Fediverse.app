import 'package:fedi/app/emoji/picker/category/recent/emoji_picker_recent_category_model.dart';
import 'package:fedi/app/emoji/picker/category/recent/local_preferences/emoji_picker_recent_category_local_preference_bloc_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../local_preferences/local_preferences_test_helper.dart';
import '../emoji_picker_recent_test_helper.dart';

// ignore_for_file: no-magic-number

void main() {
  test('save & load', () async {
    await LocalPreferencesTestHelper.testSaveAndLoad<
        EmojiPickerRecentCategoryItemsList,
        EmojiPickerRecentCategoryLocalPreferenceBloc>(
      defaultValue: EmojiPickerRecentCategoryLocalPreferenceBloc.defaultValue,
      blocCreator: (localPreferencesService) =>
          EmojiPickerRecentCategoryLocalPreferenceBloc(
        localPreferencesService,
        userAtHost: 'user@host',
      ),
      testObjectCreator: ({required String seed}) =>
          EmojiPickerRecentCategoryItemsListModelTestHelper
              .createTestEmojiPickerRecentCategoryItemsList(
        seed: seed,
      ),
    );
  });
}
