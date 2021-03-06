import 'package:fedi/app/settings/global_or_instance/local_preferences/global_or_instance_settings_bloc_local_preference_impl.dart';
import 'package:fedi/app/status/post/settings/local_preferences/post_status_settings_local_preference_bloc.dart';
import 'package:fedi/app/status/post/settings/post_status_settings_bloc.dart';
import 'package:fedi/app/status/post/settings/post_status_settings_model.dart';
import 'package:fedi/localization/localization_model.dart';
import 'package:fedi/pleroma/api/visibility/pleroma_api_visibility_model.dart';

class PostStatusSettingsBloc
    extends GlobalOrInstanceSettingsLocalPreferenceBloc<PostStatusSettings>
    implements IPostStatusSettingsBloc {
  PostStatusSettingsBloc({
    required IPostStatusSettingsLocalPreferenceBloc<PostStatusSettings>
        globalLocalPreferencesBloc,
    required IPostStatusSettingsLocalPreferenceBloc<PostStatusSettings?>
        instanceLocalPreferencesBloc,
  }) : super(
          globalLocalPreferencesBloc: globalLocalPreferencesBloc,
          instanceLocalPreferencesBloc: instanceLocalPreferencesBloc,
        );

  @override
  bool get markMediaAsNsfwOnAttach => settingsData.markMediaAsNsfwOnAttach;

  @override
  Stream<bool> get markMediaAsNsfwOnAttachStream =>
      settingsDataStream.map((settings) => settings.markMediaAsNsfwOnAttach);

  @override
  Future changeMarkMediaAsNsfwOnAttach(bool value) => updateInstanceSettings(
        settingsData.copyWith(
          markMediaAsNsfwOnAttach: value,
        ),
      );

  @override
  PleromaApiVisibility get defaultVisibilityAsPleromaApi =>
      settingsData.defaultVisibilityAsPleromaApi;

  @override
  Stream<PleromaApiVisibility> get defaultVisibilityAsPleromaApiStream =>
      settingsDataStream
          .map((settings) => settings.defaultVisibilityAsPleromaApi);

  @override
  Future changeDefaultVisibilityAsPleromaApi(PleromaApiVisibility value) =>
      updateInstanceSettings(
        settingsData.copyWith(
          defaultVisibilityString: value.toJsonValue(),
        ),
      );

  @override
  LocalizationLocale? get defaultStatusLocale =>
      settingsData.defaultStatusLocale;

  @override
  Stream<LocalizationLocale?> get defaultStatusLocaleStream =>
      settingsDataStream.map((settings) => settings.defaultStatusLocale);

  @override
  Future changeDefaultStatusLocale(LocalizationLocale? value) =>
      updateInstanceSettings(
        PostStatusSettings(
          markMediaAsNsfwOnAttach: markMediaAsNsfwOnAttach,
          defaultStatusLocale: value,
          defaultVisibilityString: defaultVisibilityAsPleromaApi.toJsonValue(),
        ),
        // copy with dont support null
        // settingsData?.copyWith(
        //   defaultStatusLocale: value,
        // ),
      );
}
