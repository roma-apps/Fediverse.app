import 'package:fedi/app/auth/instance/auth_instance_model.dart';
import 'package:easy_dispose/easy_dispose.dart';

import 'package:fedi/app/auth/instance/chooser/instance_list/auth_instance_chooser_instance_list_item_bloc.dart';

class AuthInstanceChooserInstanceListItemBloc extends DisposableOwner
    implements IAuthInstanceChooserInstanceListItemBloc {
  @override
  final bool isSelected;
  @override
  final AuthInstance instance;

  AuthInstanceChooserInstanceListItemBloc({
    required this.isSelected,
    required this.instance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthInstanceChooserInstanceListItemBloc &&
          runtimeType == other.runtimeType &&
          isSelected == other.isSelected &&
          instance == other.instance;

  @override
  int get hashCode => isSelected.hashCode ^ instance.hashCode;
}
