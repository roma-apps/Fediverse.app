import 'package:fedi/app/auth/instance/register/form/stepper/item/account/register_auth_instance_form_account_stepper_item_bloc.dart';
import 'package:fedi/app/form/field/value/string/string_value_form_field_row_widget.dart';
import 'package:fedi/app/ui/form/fedi_form_column_desc.dart';
import 'package:fedi/form/field/value/string/string_value_form_field_bloc.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/ui/stepper/fedi_stepper_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RegisterAuthInstanceFormStepperAccountItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const _RegisterAuthInstanceFormUsernameFieldWidget(),
          const _RegisterAuthInstanceFormEmailFieldWidget(),
          const _RegisterAuthInstanceFormPasswordFieldWidget(),
        ],
      );
}

class _RegisterAuthInstanceFormUsernameFieldWidget extends StatelessWidget {
  const _RegisterAuthInstanceFormUsernameFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemBloc = IRegisterAuthInstanceFormStepperAccountItemBloc.of(context);

    return StreamBuilder<bool>(
      stream: itemBloc.isEditingStartedStream,
      initialData: itemBloc.isEditingStarted,
      builder: (context, snapshot) {
        final isEditingStarted = snapshot.data!;

        return ProxyProvider<IRegisterAuthInstanceFormStepperAccountItemBloc,
            IStringValueFormFieldBloc>(
          update: (context, itemBloc, _) => itemBloc.usernameFieldBloc,
          child: StringValueFormFieldRowWidget(
            label:
                S.of(context).app_auth_instance_register_field_username_label,
            hint: S.of(context).app_auth_instance_register_field_username_hint,
            autocorrect: false,
            displayErrors: isEditingStarted,
            onSubmitted: (String value) {
              itemBloc.usernameFieldBloc.focusNode.unfocus();
              itemBloc.emailFieldBloc.focusNode.requestFocus();
            },
            textInputAction: TextInputAction.next,
          ),
        );
      },
    );
  }
}

class _RegisterAuthInstanceFormEmailFieldWidget extends StatelessWidget {
  const _RegisterAuthInstanceFormEmailFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemBloc = IRegisterAuthInstanceFormStepperAccountItemBloc.of(context);

    return StreamBuilder<bool>(
      stream: itemBloc.isEditingStartedStream,
      initialData: itemBloc.isEditingStarted,
      builder: (context, snapshot) {
        final isEditingStarted = snapshot.data!;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProxyProvider<IRegisterAuthInstanceFormStepperAccountItemBloc,
                IStringValueFormFieldBloc>(
              update: (context, itemBloc, _) => itemBloc.emailFieldBloc,
              child: StringValueFormFieldRowWidget(
                label:
                    S.of(context).app_auth_instance_register_field_email_label,
                hint: S.of(context).app_auth_instance_register_field_email_hint,
                autocorrect: false,
                displayErrors: isEditingStarted,
                onSubmitted: (String value) {
                  itemBloc.emailFieldBloc.focusNode.unfocus();
                  itemBloc.passwordFieldBloc.focusNode.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
            ),
            FediFormColumnDesc(
              S.of(context).app_auth_instance_register_field_email_description,
            ),
          ],
        );
      },
    );
  }
}

class _RegisterAuthInstanceFormPasswordFieldWidget extends StatelessWidget {
  const _RegisterAuthInstanceFormPasswordFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemBloc = IRegisterAuthInstanceFormStepperAccountItemBloc.of(context);

    return StreamBuilder<bool>(
      stream: itemBloc.isEditingStartedStream,
      initialData: itemBloc.isEditingStarted,
      builder: (context, snapshot) {
        final isEditingStarted = snapshot.data!;

        return ProxyProvider<IRegisterAuthInstanceFormStepperAccountItemBloc,
            IStringValueFormFieldBloc>(
          update: (context, itemBloc, _) => itemBloc.passwordFieldBloc,
          child: StringValueFormFieldRowWidget(
            label:
                S.of(context).app_auth_instance_register_field_password_label,
            hint: S.of(context).app_auth_instance_register_field_password_hint,
            autocorrect: false,
            onSubmitted: null,
            obscureText: true,
            displayErrors: isEditingStarted,
            showToggleToForObscureText: true,
            textInputAction: TextInputAction.done,
          ),
        );
      },
    );
  }
}
