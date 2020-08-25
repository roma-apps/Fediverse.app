import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:flutter/cupertino.dart';

class FediSmallVerticalSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: FediSizes.smallPadding,
    );
  }
  const FediSmallVerticalSpacer();
}
