import 'package:fedi/form/field/value/list/list_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/value_form_field_validation.dart';

class ListValueFormFieldBloc<T> extends ValueFormFieldBloc<List<T>?>
    implements IListValueFormFieldBloc<T> {
  ListValueFormFieldBloc({
    required List<T> originValue,
    required List<FormValueFieldValidation<List<T>>> validators,
    required bool isEnabled,
    required bool isNullValuePossible,
  }) : super(
          originValue: originValue,
          validators: validators,
          isEnabled: isEnabled,
          isNullValuePossible: isNullValuePossible,
        );
}
