import 'package:fedi/generated/l10n.dart';
import 'package:fedi/ui/form/field/value/form_value_field_validation.dart';
import 'package:fedi/ui/form/field/value/string/form_string_field_validation.dart';
import 'package:flutter/widgets.dart';

class FormLengthStringFieldValidationError
    extends FormStringFieldValidationError {
  final int minLength;
  final int maxLength;

  FormLengthStringFieldValidationError(
      {@required this.minLength, @required this.maxLength}) {
    assert(minLength != null || maxLength != null);
  }

  @override
  String createErrorDescription(BuildContext context) {
    if (minLength != null && maxLength != null) {
      return S
          .of(context)
          .form_field_text_error_length_minAndMax_desc(minLength, maxLength);
    } else if (minLength != null) {
      return S.of(context).form_field_text_error_length_minOnly_desc(minLength);
    } else if (maxLength != null) {}
    return S.of(context).form_field_text_error_length_maxOnly_desc(maxLength);
  }

  static FormValueFieldValidation createValidator(
          {@required int minLength, @required int maxLength}) =>
      (currentValue) {
        assert(minLength != null || maxLength != null);
        var length = currentValue?.length ?? 0;
        bool moreThanMin;
        if (minLength != null) {
          moreThanMin = length >= (minLength);
        } else {
          moreThanMin = true;
        }
        bool lessThanMax;
        if (maxLength != null) {
          lessThanMax = length < maxLength;
        } else {
          lessThanMax = true;
        }

        if (moreThanMin && lessThanMax) {
          return null;
        } else {
          return FormLengthStringFieldValidationError(
              minLength: minLength, maxLength: maxLength);
        }
      };
}
