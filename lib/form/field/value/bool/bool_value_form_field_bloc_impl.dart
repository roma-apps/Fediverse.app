import 'package:fedi/form/field/value/bool/bool_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/value_form_field_bloc_impl.dart';
import 'package:flutter/widgets.dart';

class BoolValueFormFieldBloc extends ValueFormFieldBloc<bool>
    implements IBoolValueFormFieldBloc {
  BoolValueFormFieldBloc({
    @required bool originValue,
    bool isEnabled = true,
    bool isNullValuePossible = false,
  }) : super(
          originValue: originValue,
          validators: [],
          isEnabled: isEnabled,
          isNullValuePossible: isNullValuePossible,
        );

  @override
  void changeCurrentValue(bool newValue) {
    if (newValue == currentValue) {
      return;
    }
    super.changeCurrentValue(newValue);
  }
}