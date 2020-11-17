import 'package:fedi/app/settings/global_or_instance/edit/edit_global_or_instance_settings_bloc.dart';
import 'package:fedi/app/web_sockets/settings/web_sockets_settings_model.dart';
import 'package:fedi/ui/form/field/value/form_value_field_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IEditWebSocketsSettingsBloc
    implements IEditGlobalOrInstanceSettingsBloc {
  static IEditWebSocketsSettingsBloc of(BuildContext context,
          {bool listen = true}) =>
      Provider.of<IEditWebSocketsSettingsBloc>(context, listen: listen);

  IFormValueFieldBloc<WebSocketsSettingsType> get typeFieldBloc;
}