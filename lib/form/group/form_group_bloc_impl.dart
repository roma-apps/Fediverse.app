import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/form/form_item_bloc.dart';
import 'package:fedi/form/form_item_bloc_impl.dart';
import 'package:fedi/form/form_item_validation.dart';
import 'package:fedi/form/group/form_group_bloc.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

typedef NewFieldCreator<T> = T Function();

var _logger = Logger("form_group_bloc_impl.dart");

abstract class FormGroupBloc<T extends IFormItemBloc> extends FormItemBloc
    implements IFormGroupBloc<T> {
  FormGroupBloc() {
    addDisposable(subject: errorsSubject);
    addDisposable(disposable: itemsErrorSubscription);

    Future.delayed(Duration(microseconds: 1), () {
      // delay to execute all code in child constructors
      try {
        addDisposable(
          streamSubscription: itemsStream.listen(
            (newItems) {
              itemsErrorSubscription?.dispose();
              if (newItems?.isNotEmpty == true) {
                _resubscribeForErrors(newItems);
              }
            },
          ),
        );
      } catch (e, stackTrace) {
        _logger.warning(() => "failed to subscribe for items", e, stackTrace);
      }
    });
  }

  @override
  bool get isSomethingChanged => items
          .map((field) => field.isSomethingChanged)
          .fold(false, (previousValue, element) {
        return previousValue || element;
      });

  @override
  Stream<bool> get isSomethingChangedStream =>
      Rx.combineLatestList(items.map((field) => field.isSomethingChangedStream))
          .map((isChangedList) =>
              isChangedList.fold(false, (previousValue, element) {
                return previousValue || element;
              }));

  BehaviorSubject<List<FormItemValidationError>> errorsSubject =
      BehaviorSubject.seeded([]);

  @override
  List<FormItemValidationError> get errors => errorsSubject.value;

  @override
  Stream<List<FormItemValidationError>> get errorsStream =>
      errorsSubject.stream;

  @override
  bool get isHaveAtLeastOneError => errors?.isNotEmpty == true;

  DisposableOwner itemsErrorSubscription;

  @override
  Stream<bool> get isHaveAtLeastOneErrorStream =>
      errorsStream.map((fieldsErrors) => fieldsErrors?.isNotEmpty == true);

  void _resubscribeForErrors(List<T> newItems) {
    itemsErrorSubscription = DisposableOwner();
    newItems.forEach(
      (IFormItemBloc item) {
        itemsErrorSubscription.addDisposable(
          streamSubscription: item.errorsStream.listen(
            (_) {
              recalculateErrors();
            },
          ),
        );
      },
    );
  }

  void recalculateErrors() {
    var errors = items.fold(<FormItemValidationError>[], (errors, item) {
      if (item.errors?.isNotEmpty == true) {
        errors.addAll(item.errors);
      }

      return errors;
    });

    if (!errorsSubject.isClosed) {
      errorsSubject.add(errors);
    }
  }
}
