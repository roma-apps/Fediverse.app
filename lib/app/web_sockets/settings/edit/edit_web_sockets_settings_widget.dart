import 'package:fedi/app/web_sockets/handling_type/form/web_sockets_handling_type_single_from_list_value_form_field_bloc.dart';
import 'package:fedi/app/web_sockets/handling_type/form/web_sockets_handling_type_single_from_list_value_form_field_row_widget.dart';
import 'package:fedi/app/web_sockets/settings/edit/edit_web_sockets_settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class EditWebSocketsSettingsWidget extends StatelessWidget {
  final bool shrinkWrap;

  const EditWebSocketsSettingsWidget({
    required this.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        children: [
          ProxyProvider<IEditWebSocketsSettingsBloc,
              IWebSocketsHandlingTypeSingleFromListValueFormFieldBloc>(
            update: (context, value, previous) => value.typeFieldBloc,
            child:
                const WebSocketsHandlingTypeSingleFromListValueFormFieldRowWidget(),
          ),
        ],
      );
}
