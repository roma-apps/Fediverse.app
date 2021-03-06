import 'package:fedi/app/timeline/settings/only_in_custom_list/timeline_settings_only_in_custom_list_form_field_bloc.dart';
import 'package:fedi/form/field/value/value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/value_form_field_validation.dart';
import 'package:fedi/pleroma/api/list/pleroma_api_list_model.dart';

class TimelineSettingsOnlyInCustomListFormFieldBloc
    extends ValueFormFieldBloc<IPleromaApiList?>
    implements ITimelineSettingsOnlyInCustomListFormFieldBloc {
  TimelineSettingsOnlyInCustomListFormFieldBloc({
    bool isNullValuePossible = true,
    required IPleromaApiList? originValue,
    bool isEnabled = true,
    List<FormValueFieldValidation<IPleromaApiList>> validators = const [],
  }) : super(
          originValue: originValue,
          isEnabled: isEnabled,
          validators: validators,
          isNullValuePossible: isNullValuePossible,
        );
}
