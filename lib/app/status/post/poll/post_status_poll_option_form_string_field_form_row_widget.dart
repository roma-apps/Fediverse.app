import 'package:fedi/app/ui/edit_text/fedi_base_edit_text_field.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/form/field/value/string/string_value_form_field_bloc.dart';
import 'package:flutter/cupertino.dart';

class PostStatusPollOptionFormStringFieldFormRowWidget extends StatelessWidget {
  final String hint;
  final IStringValueFormFieldBloc formStringFieldBloc;

  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;

  PostStatusPollOptionFormStringFieldFormRowWidget({
    @required this.hint,
    @required this.formStringFieldBloc,
    @required this.onSubmitted,
    @required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: IFediUiColorTheme.of(context).lightGrey)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: FediSizes.mediumPadding),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: FediBaseEditTextField(
                enabled: true,
                highlightMentions: false,
                autocorrect: true,
                focusNode: formStringFieldBloc.focusNode,
                textInputAction: textInputAction,
                onSubmitted: (_) {
                  onSubmitted(_);
                },
                textStyle: IFediUiTextTheme.of(context).bigTallMediumGrey,
                obscureText: false,
                autofocus: false,
                textEditingController:
                    formStringFieldBloc.textEditingController,
                minLines: null,
                maxLines: 1,
                expanded: false,
                keyboardType: TextInputType.text,
                hintText: hint,
                errorText: null,
                border: null,
                errorBorder: null,
                focusedBorder: null,
                contentPadding: null,
                displayBorder: false,
                hintStyle: IFediUiTextTheme.of(context).bigTallGrey,
                maxLength: formStringFieldBloc.maxLength,
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              right: 8.0,
              child:
                  _PostStatusPollOptionFormStringFieldFormRowErrorBuilderWidget(
                      formStringFieldBloc: formStringFieldBloc),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostStatusPollOptionFormStringFieldFormRowErrorBuilderWidget
    extends StatelessWidget {
  const _PostStatusPollOptionFormStringFieldFormRowErrorBuilderWidget({
    Key key,
    @required this.formStringFieldBloc,
  }) : super(key: key);

  final IStringValueFormFieldBloc formStringFieldBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: formStringFieldBloc.isHaveAtLeastOneErrorStream,
        initialData: formStringFieldBloc.isHaveAtLeastOneError,
        builder: (context, snapshot) {
          var isHaveAtLeastOneError = snapshot.data;
          if (isHaveAtLeastOneError) {
            return _PostStatusPollOptionFormStringFieldFormRowErrorWidget();
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class _PostStatusPollOptionFormStringFieldFormRowErrorWidget
    extends StatelessWidget {
  const _PostStatusPollOptionFormStringFieldFormRowErrorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      FediIcons.warning,
      color: IFediUiColorTheme.of(context).error,
    );
  }
}
