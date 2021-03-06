import 'package:fedi/app/auth/instance/register/form/stepper/item/register_auth_instance_form_stepper_item_model.dart';
import 'package:fedi/form/form_item_bloc.dart';
import 'package:fedi/ui/stepper/fedi_stepper_model.dart';

abstract class IRegisterAuthInstanceFormStepperItemBloc
    implements IFediStepperItem, IFormItemBloc {
  RegisterAuthInstanceFormStepperItemType get type;
}
