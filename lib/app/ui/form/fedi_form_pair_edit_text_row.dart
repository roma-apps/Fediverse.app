import 'package:fedi/app/ui/edit_text/fedi_transparent_edit_text_field.dart';
import 'package:fedi/app/ui/form/fedi_form_edit_text_label.dart';
import 'package:fedi/app/ui/form/fedi_form_row.dart';
import 'package:fedi/ui/form/field/value/string/form_string_field_bloc_impl.dart';
import 'package:fedi/ui/form/form_item_validation.dart';
import 'package:flutter/cupertino.dart';

class FediFormPairEditTextRow extends StatelessWidget {
  final String label;
  final String nameHint;
  final FormStringFieldBloc nameStringFieldBloc;
  final FormStringFieldBloc valueStringFieldBloc;
  final String valueHint;
  final Widget ending;

  FediFormPairEditTextRow({
    @required this.label,
    @required this.nameHint,
    @required this.valueHint,
    @required this.nameStringFieldBloc,
    @required this.valueStringFieldBloc,
    @required this.ending,
  });

  @override
  Widget build(BuildContext context) => FediFormRow(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FediFormEditTextLabel(label),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StreamBuilder<List<FormItemValidationError>>(
                      stream: nameStringFieldBloc.errorsStream,
                      initialData: nameStringFieldBloc.errors,
                      builder: (context, snapshot) {
                        var errors = snapshot.data;

                        var error =
                            errors?.isNotEmpty == true ? errors.first : null;
                        return FediTransparentEditTextField(
                          expanded: false,
                          autofocus: false,
                          hintText: nameHint,
                          maxLines: 1,
                          onSubmitted: null,
                          textInputAction: TextInputAction.done,
                          textEditingController:
                              nameStringFieldBloc.textEditingController,
                          displayUnderlineBorder: true,
                          errorText: error?.createErrorDescription(context),
                        );
                      }),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<List<FormItemValidationError>>(
                      stream: valueStringFieldBloc.errorsStream,
                      initialData: valueStringFieldBloc.errors,
                      builder: (context, snapshot) {
                        var errors = snapshot.data;

                        var error =
                            errors?.isNotEmpty == true ? errors.first : null;

                        return FediTransparentEditTextField(
                          expanded: false,
                          autofocus: false,
                          hintText: valueHint,
                          maxLines: 1,
                          onSubmitted: null,
                          textInputAction: TextInputAction.done,
                          textEditingController:
                              valueStringFieldBloc.textEditingController,
                          displayUnderlineBorder: true,
                          errorText: error?.createErrorDescription(context),
                        );
                      }),
                ),
                ending
              ],
            ),
          ],
        ),
      );
}
