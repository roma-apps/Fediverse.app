import 'package:easy_dispose_rxdart/easy_dispose_rxdart.dart';
import 'package:fedi/app/auth/instance/register/form/stepper/item/register_auth_instance_form_stepper_item_bloc.dart';
import 'package:fedi/form/form_bloc_impl.dart';
import 'package:fedi/ui/stepper/fedi_stepper_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class RegisterAuthInstanceFormStepperItemBloc extends FormBloc
    implements IRegisterAuthInstanceFormStepperItemBloc {
  BehaviorSubject<bool> onStepCompleteCalledSubject = BehaviorSubject.seeded(
    false,
  );

  bool get onStepCompleteCalled => onStepCompleteCalledSubject.value;

  Stream<bool> get onStepCompleteCalledStream =>
      onStepCompleteCalledSubject.stream;

  RegisterAuthInstanceFormStepperItemBloc({
    required bool isAllItemsInitialized,
  }) : super(isAllItemsInitialized: isAllItemsInitialized) {
    onStepCompleteCalledSubject.disposeWith(this);
  }

  @override
  FediStepperItemState get itemState => _calculateFediStepperItemState(
        isHaveAtLeastOneError: isHaveAtLeastOneError,
        isSomethingChanged: isSomethingChanged,
        onStepCompleteCalled: onStepCompleteCalled,
      );

  @override
  Stream<FediStepperItemState> get itemStateStream => Rx.combineLatest3(
        isHaveAtLeastOneErrorStream,
        isSomethingChangedStream,
        onStepCompleteCalledStream,
        (
          bool isHaveAtLeastOneError,
          bool isSomethingChanged,
          bool onStepCompleteCalled,
        ) =>
            _calculateFediStepperItemState(
          isHaveAtLeastOneError: isHaveAtLeastOneError,
          isSomethingChanged: isSomethingChanged,
          onStepCompleteCalled: onStepCompleteCalled,
        ),
      );

  static FediStepperItemState _calculateFediStepperItemState({
    required bool isHaveAtLeastOneError,
    required bool isSomethingChanged,
    required bool onStepCompleteCalled,
  }) {
    FediStepperItemState state;

    if (onStepCompleteCalled) {
      if (isHaveAtLeastOneError) {
        state = FediStepperItemState.errors;
      } else {
        state = FediStepperItemState.editingFinished;
      }
    } else {
      state = FediStepperItemState.editingNotStarted;
    }

    return state;
  }

  @override
  FediStepperItemState onStepComplete() {
    // todo: refactor
    onStepCompleteCalledSubject.add(true);

    return itemState;
  }
}
