import 'package:fedi/app/status/post/settings/local_preferences/instance/instance_post_status_settings_local_preferences_bloc.dart';
import 'package:fedi/app/status/post/settings/local_preferences/post_status_settings_local_preferences_bloc_impl.dart';
import 'package:fedi/app/status/post/settings/post_status_settings_model.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';

class InstancePostStatusSettingsLocalPreferencesBloc
    extends PostStatusSettingsLocalPreferencesBloc<PostStatusSettings?>
    implements IInstancePostStatusSettingsLocalPreferencesBloc {
  InstancePostStatusSettingsLocalPreferencesBloc(
    ILocalPreferencesService preferencesService, {
    required String userAtHost,
  }) : super(
          preferencesService,
          "postStatus.settings.instance.$userAtHost",
        );

  @override
  PostStatusSettings? get defaultPreferenceValue => null;
}
