import 'package:fedi/app/toast/handling_type/form/toast_handling_type_single_from_list_value_form_field_bloc.dart';
import 'package:fedi/app/toast/handling_type/toast_handling_type_model.dart';
import 'package:fedi/form/field/value/select_from_list/single/single_select_from_list_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/select_from_list/single/single_select_from_list_value_form_field_bloc_proxy_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ToastHandlingTypeSingleSelectFromListValueFormFieldBlocProxyProvider
    extends StatelessWidget {
  final Widget child;

  ToastHandlingTypeSingleSelectFromListValueFormFieldBlocProxyProvider({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => ProxyProvider<
          IToastHandlingTypeSingleFromListValueFormFieldBloc,
          ISingleSelectFromListValueFormFieldBloc<ToastHandlingType>>(
        update: (context, value, previous) => value,
        child: SingleSelectFromListValueFormFieldBlocProxyProvider<
            ToastHandlingType>(
          child: child,
        ),
      );
}
