import 'package:fedi/app/emoji/picker/category/custom_image_url/emoji_picker_custom_image_url_category_model.dart';
import 'package:fedi/app/emoji/picker/category/custom_image_url/local_preferences/emoji_picker_custom_image_url_category_local_preference_bloc_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../local_preferences/local_preferences_test_helper.dart';
import '../emoji_picker_custom_image_url_category_test_helper.dart';

// ignore_for_file: no-magic-number

void main() {
  test('save & load', () async {
    await LocalPreferencesTestHelper.testSaveAndLoad<
        EmojiPickerCustomImageUrlCategoryItems,
        EmojiPickerCustomImageUrlCategoryBlocLocalPreferenceBloc>(
      defaultValue:
          EmojiPickerCustomImageUrlCategoryBlocLocalPreferenceBloc.defaultValue,
      blocCreator: (localPreferencesService) =>
          EmojiPickerCustomImageUrlCategoryBlocLocalPreferenceBloc(
        localPreferencesService,
        userAtHost: 'user@host',
      ),
      testObjectCreator: ({required String seed}) =>
          CustomEmojiPickerImageUrlItemModelTestHelper
              .createTestEmojiPickerCustomImageUrlCategoryItems(
        seed: seed,
      ),
    );
  });
}
