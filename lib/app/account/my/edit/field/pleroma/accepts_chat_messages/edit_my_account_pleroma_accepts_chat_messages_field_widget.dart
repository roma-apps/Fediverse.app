import 'package:fedi/app/account/my/edit/edit_my_account_bloc.dart';
import 'package:fedi/app/form/field/value/bool/bool_value_form_field_row_widget.dart';
import 'package:fedi/form/field/value/bool/bool_value_form_field_bloc.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EditMyAccountPleromaAcceptsChatMessagesFieldWidget
    extends StatelessWidget {
  const EditMyAccountPleromaAcceptsChatMessagesFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ProxyProvider<IEditMyAccountBloc, IBoolValueFormFieldBloc>(
        update: (context, value, previous) => value.acceptsChatMessagesField,
        child: BoolValueFormFieldRowWidget(
          label: S
              .of(context)
              .app_account_my_edit_field_pleroma_acceptsChatMessages_label,
          description: S
              .of(context)
              .app_account_my_edit_field_pleroma_acceptsChatMessages_description,
        ),
      );
}
