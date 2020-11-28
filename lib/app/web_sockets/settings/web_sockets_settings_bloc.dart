import 'package:fedi/app/settings/global_or_instance/global_or_instance_settings_bloc.dart';
import 'package:fedi/web_sockets/handling_type/web_sockets_handling_type_model.dart';
import 'package:fedi/app/web_sockets/settings/web_sockets_settings_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IWebSocketsSettingsBloc
    implements IGlobalOrInstanceSettingsBloc<WebSocketsSettings> {
  bool get isRealtimeWebSocketsEnabled;

  static IWebSocketsSettingsBloc of(BuildContext context,
          {bool listen = true}) =>
      Provider.of<IWebSocketsSettingsBloc>(context, listen: listen);

  WebSocketsHandlingType get type;

  Stream<WebSocketsHandlingType> get typeStream;

  void changeType(WebSocketsHandlingType value);
}
