import 'package:fedi/app/media/settings/local_preferences/media_settings_local_preferences_bloc.dart';
import 'package:fedi/app/media/settings/media_settings_model.dart';
import 'package:fedi/local_preferences/local_preference_bloc_impl.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';

abstract class MediaSettingsLocalPreferencesBloc
    extends ObjectLocalPreferenceBloc<MediaSettings?>
    implements IMediaSettingsLocalPreferencesBloc {
  MediaSettingsLocalPreferencesBloc(
    ILocalPreferencesService preferencesService,
    String key,
  ) : super(
          preferencesService,
          key,
          1,
          (json) => MediaSettings.fromJson(json),
        );
}
