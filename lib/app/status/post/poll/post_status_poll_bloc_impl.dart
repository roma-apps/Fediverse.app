import 'package:fedi/app/status/post/poll/post_status_poll_bloc.dart';
import 'package:fedi/app/status/post/poll/post_status_poll_model.dart';
import 'package:fedi/pleroma/instance/pleroma_instance_model.dart';
import 'package:fedi/form/field/value/bool/bool_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/bool/bool_value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/duration/duration_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/duration/duration_value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/string/validation/string_value_form_field_non_empty_validation.dart';
import 'package:fedi/form/field/value/string/string_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/string/string_value_form_field_bloc_impl.dart';
import 'package:fedi/form/form_bloc_impl.dart';
import 'package:fedi/form/form_item_bloc.dart';
import 'package:fedi/form/group/one_type/one_type_form_group_bloc.dart';
import 'package:fedi/form/group/one_type/one_type_form_group_bloc_impl.dart';
import 'package:flutter/cupertino.dart';

class PostStatusPollBloc extends FormBloc implements IPostStatusPollBloc {
  static DurationValueFormFieldBloc createDurationLengthBloc(
      PleromaInstancePollLimits pollLimits) {
    Duration pollMinimumExpiration = calculatePollMinimumExpiration(pollLimits);

    Duration pollMaximumExpiration = calculatePollMaximumExpiration(pollLimits);

    var originValue = IPostStatusPollBloc.defaultPollExpiration;
    return DurationValueFormFieldBloc(
      originValue: originValue,
      minDuration: pollMinimumExpiration,
      maxDuration: pollMaximumExpiration,
      isNullValuePossible: false,
    );
  }

  static Duration calculatePollMinimumExpiration(
      PleromaInstancePollLimits pollLimits) {
    return pollLimits?.minExpiration != null
        ? Duration(seconds: pollLimits?.minExpiration)
        : IPostStatusPollBloc.minimumPollExpiration;
  }

  static Duration calculatePollMaximumExpiration(
      PleromaInstancePollLimits pollLimits) {
    return pollLimits?.maxExpiration != null
        ? Duration(seconds: pollLimits?.maxExpiration)
        : null;
  }

  final PleromaInstancePollLimits pollLimits;

  int get pollMaximumOptionsCount =>
      pollLimits?.maxOptions ?? IPostStatusPollBloc.defaultMaxPollOptions;

  int get pollMaximumOptionLength => pollLimits?.maxOptionChars;

  Duration get pollMinimumExpiration =>
      calculatePollMinimumExpiration(pollLimits);

  Duration get pollMaximumExpiration =>
      calculatePollMaximumExpiration(pollLimits);

  PostStatusPollBloc({
    @required this.pollLimits,
  })  : pollOptionsGroupBloc = OneTypeFormGroupBloc<IStringValueFormFieldBloc>(
          originalItems: createDefaultPollOptions(pollLimits?.maxOptionChars),
          minimumFieldsCount: 2,
          maximumFieldsCount: pollLimits?.maxOptions ?? 20,
          newEmptyFieldCreator: () =>
              createPollOptionBloc(pollLimits?.maxOptionChars),
        ),
        durationLengthFieldBloc = createDurationLengthBloc(pollLimits);

  @override
  List<IFormItemBloc> get currentItems => [
        durationLengthFieldBloc,
        multiplyFieldBloc,
        pollOptionsGroupBloc,
      ];

  @override
  IDurationValueFormFieldBloc durationLengthFieldBloc;
  @override
  IBoolValueFormFieldBloc multiplyFieldBloc = BoolValueFormFieldBloc(originValue: false);

  @override
  IOneTypeFormGroupBloc<IStringValueFormFieldBloc> pollOptionsGroupBloc;

  static List<IStringValueFormFieldBloc> createDefaultPollOptions(
      int maximumOptionLength) {
    return <IStringValueFormFieldBloc>[
      createPollOptionBloc(maximumOptionLength),
      createPollOptionBloc(maximumOptionLength),
    ];
  }

  static StringValueFormFieldBloc createPollOptionBloc(int maximumOptionLength) =>
      createPollOptionFieldBloc(null, maximumOptionLength);

  static StringValueFormFieldBloc createPollOptionFieldBloc(
    String originValue,
    int maximumOptionLength,
  ) {
    return StringValueFormFieldBloc(
      originValue: originValue,
      validators: [
        StringValueFormFieldNonEmptyValidationError.createValidator(),
      ],
      maxLength: maximumOptionLength,
    );
  }

  @override
  void fillFormData(IPostStatusPoll poll) {
    multiplyFieldBloc.changeCurrentValue(poll.multiple);

    durationLengthFieldBloc.changeCurrentValue(poll.durationLength);
    if (poll.options?.isNotEmpty == true) {
      pollOptionsGroupBloc.removeAllFields();

      poll.options.forEach(
        (pollOption) {
          pollOptionsGroupBloc.addNewField(
            createPollOptionFieldBloc(
              pollOption,
              pollMaximumOptionLength,
            ),
          );
        },
      );
    }
  }

  @override
  void clear() {
    // super.clear();

    var oldBloc = pollOptionsGroupBloc;

    pollOptionsGroupBloc = OneTypeFormGroupBloc<IStringValueFormFieldBloc>(
      originalItems: createDefaultPollOptions(pollLimits?.maxOptionChars),
      minimumFieldsCount: 2,
      maximumFieldsCount: pollLimits?.maxOptions ?? 20,
      newEmptyFieldCreator: () =>
          createPollOptionBloc(pollLimits?.maxOptionChars),
    );

    onItemsChanged();

    oldBloc.dispose();
  }
}
