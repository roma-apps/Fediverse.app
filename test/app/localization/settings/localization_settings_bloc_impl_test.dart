import 'dart:async';

import 'package:fedi/app/localization/settings/local_preferences/global/global_localization_settings_local_preference_bloc_impl.dart';
import 'package:fedi/app/localization/settings/localization_settings_bloc_impl.dart';
import 'package:fedi/app/localization/settings/localization_settings_model.dart';
import 'package:fedi/local_preferences/memory_local_preferences_service_impl.dart';
import 'package:fedi/localization/localization_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../localization/localization_model_test_helper.dart';


// ignore_for_file: no-magic-number, avoid-late-keyword
void main() {
  late MemoryLocalPreferencesService memoryLocalPreferencesService;
  late GlobalLocalizationSettingsLocalPreferenceBloc
      globalLocalizationSettingsLocalPreferencesBloc;
  late LocalizationSettingsBloc localizationSettingsBloc;

  late StreamSubscription subscriptionListenedSettingsData;

  LocalizationSettings? listenedSettingsData;

  setUp(() async {
    memoryLocalPreferencesService = MemoryLocalPreferencesService();
    globalLocalizationSettingsLocalPreferencesBloc =
        GlobalLocalizationSettingsLocalPreferenceBloc(
      memoryLocalPreferencesService,
    );

    await globalLocalizationSettingsLocalPreferencesBloc.performAsyncInit();

    localizationSettingsBloc = LocalizationSettingsBloc(
      localizationSettingsLocalPreferencesBloc:
          globalLocalizationSettingsLocalPreferencesBloc,
    );

    subscriptionListenedSettingsData =
        localizationSettingsBloc.settingsDataStream.listen((data) {
      listenedSettingsData = data;
    });
  });

  tearDown(() async {
    await subscriptionListenedSettingsData.cancel();
    await localizationSettingsBloc.dispose();
    await globalLocalizationSettingsLocalPreferencesBloc.dispose();
    await memoryLocalPreferencesService.dispose();
  });

  test('changeLocalizationLocale', () async {
    LocalizationLocale? listenedLocalizationLocale;

    StreamSubscription subscriptionListenedLocalizationLocale =
        localizationSettingsBloc.localizationLocaleStream.listen(
      (data) {
        listenedLocalizationLocale = data;
      },
    );

    await Future.delayed(Duration(milliseconds: 100));

    var defaultValue =
        GlobalLocalizationSettingsLocalPreferenceBloc.defaultValue;

    expect(
      listenedSettingsData?.localizationLocale,
      defaultValue.localizationLocale,
    );
    expect(
      localizationSettingsBloc.settingsData.localizationLocale,
      defaultValue.localizationLocale,
    );

    expect(
      listenedLocalizationLocale,
      defaultValue.localizationLocale,
    );
    expect(
      localizationSettingsBloc.localizationLocale,
      defaultValue.localizationLocale,
    );

    var testLocalizationLocale =
        LocalizationModelTestHelper.createTestLocalizationLocale(seed: 'seed');

    await localizationSettingsBloc
        .changeLocalizationLocale(testLocalizationLocale);
    await Future.delayed(Duration(milliseconds: 100));

    expect(
      listenedSettingsData?.localizationLocale,
      testLocalizationLocale,
    );
    expect(
      localizationSettingsBloc.settingsData.localizationLocale,
      testLocalizationLocale,
    );

    expect(
      listenedLocalizationLocale,
      testLocalizationLocale,
    );
    expect(
      localizationSettingsBloc.localizationLocale,
      testLocalizationLocale,
    );

    var nullLocalizationLocale;

    await localizationSettingsBloc
        .changeLocalizationLocale(nullLocalizationLocale);
    await Future.delayed(Duration(milliseconds: 100));

    expect(
      listenedSettingsData?.localizationLocale,
      nullLocalizationLocale,
    );
    expect(
      localizationSettingsBloc.settingsData.localizationLocale,
      nullLocalizationLocale,
    );

    expect(
      listenedLocalizationLocale,
      nullLocalizationLocale,
    );
    expect(
      localizationSettingsBloc.localizationLocale,
      nullLocalizationLocale,
    );

    await subscriptionListenedLocalizationLocale.cancel();
  });
}
