import 'package:fedi/ui/form/group/form_group_bloc.dart';

abstract class IFormBloc extends IFormGroupBloc {
  bool get isReadyToSubmit;

  Stream<bool> get isReadyToSubmitStream;
}
