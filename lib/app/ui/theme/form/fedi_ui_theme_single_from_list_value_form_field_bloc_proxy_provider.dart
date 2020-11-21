import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/app/ui/theme/form/fedi_ui_theme_single_from_list_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/single_from_list/single_from_list_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/single_from_list/single_from_list_value_form_field_bloc_proxy_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FediUiThemeSingleFromListValueFormFieldBlocProxyProvider
    extends StatelessWidget {
  final Widget child;

  FediUiThemeSingleFromListValueFormFieldBlocProxyProvider({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) => ProxyProvider<
          IFediUiThemeSingleFromListValueFormFieldBloc,
          ISingleFromListValueFormFieldBloc<IFediUiTheme>>(
        update: (context, value, previous) => value,
        child: SingleFromListValueFormFieldBlocProxyProvider<IFediUiTheme>(
          child: child,
        ),
      );
}
