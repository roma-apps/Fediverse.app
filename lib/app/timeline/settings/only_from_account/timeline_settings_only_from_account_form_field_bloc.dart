import 'package:fedi/form/field/value/value_form_field_bloc.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class ITimelineSettingsOnlyFromAccountFormFieldBloc
    implements IValueFormFieldBloc<IPleromaApiAccount?> {
  static ITimelineSettingsOnlyFromAccountFormFieldBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<ITimelineSettingsOnlyFromAccountFormFieldBloc>(
        context,
        listen: listen,
      );
}
