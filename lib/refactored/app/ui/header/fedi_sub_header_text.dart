import 'package:fedi/refactored/app/ui/fedi_colors.dart';
import 'package:flutter/cupertino.dart';

class FediSubHeaderText extends StatelessWidget {
  final String text;

  FediSubHeaderText(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
        color: FediColors.darkGrey,
        fontSize: 16.0,

        fontWeight: FontWeight.w500
    ),
  );
}
