import 'package:fedi/app/settings/global_or_instance/local_preferences/global_or_instance_settings_bloc_local_preference_impl.dart';
import 'package:fedi/app/web_sockets/settings/local_preferences/web_sockets_settings_local_preference_bloc.dart';
import 'package:fedi/app/web_sockets/settings/web_sockets_settings_bloc.dart';
import 'package:fedi/app/web_sockets/settings/web_sockets_settings_model.dart';
import 'package:fedi/web_sockets/handling_type/web_sockets_handling_type_model.dart';

class WebSocketsSettingsBloc
    extends GlobalOrInstanceSettingsLocalPreferenceBloc<WebSocketsSettings>
    implements IWebSocketsSettingsBloc {
  WebSocketsSettingsBloc({
    required IWebSocketsSettingsLocalPreferenceBloc<WebSocketsSettings>
        globalLocalPreferencesBloc,
    required IWebSocketsSettingsLocalPreferenceBloc<WebSocketsSettings?>
        instanceLocalPreferencesBloc,
  }) : super(
          globalLocalPreferencesBloc: globalLocalPreferencesBloc,
          instanceLocalPreferencesBloc: instanceLocalPreferencesBloc,
        );

  @override
  WebSocketsHandlingType get handlingType => settingsData.type;

  @override
  Stream<WebSocketsHandlingType> get handlingTypeStream =>
      settingsDataStream.map((settings) => settings.type);

  @override
  Future changeHandlingType(WebSocketsHandlingType value) =>
      updateInstanceSettings(
        settingsData.copyWith(
          handlingType: value,
        ),
      );
}
