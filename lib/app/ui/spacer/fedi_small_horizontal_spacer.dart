import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:flutter/cupertino.dart';

class FediSmallHorizontalSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: FediSizes.smallPadding,
    );
  }

  const FediSmallHorizontalSpacer();
}
