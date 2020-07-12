import 'package:fedi/app/status/visibility/status_visibility_ui.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:fedi/pleroma/visibility/pleroma_visibility_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusVisibilityIconWidget extends StatelessWidget {
  final PleromaVisibility visibility;
  final bool isPossibleToChangeVisibility;
  final bool isSelectedVisibility;

  StatusVisibilityIconWidget({
    @required this.visibility,
    @required this.isPossibleToChangeVisibility,
    @required this.isSelectedVisibility,
  });

  @override
  Widget build(BuildContext context) => buildVisibilityIcon(
        context: context,
        visibility: visibility,
        isPossibleToChangeVisibility: isPossibleToChangeVisibility,
        isSelectedVisibility: isSelectedVisibility,
      );

  static Icon buildVisibilityIcon(
          {@required BuildContext context,
          @required PleromaVisibility visibility,
          @required isPossibleToChangeVisibility,
          @required isSelectedVisibility}) =>
      Icon(mapVisibilityToIconData(visibility),
          color: calculateVisibilityColor(
              isSelectedVisibility, isPossibleToChangeVisibility));

  static IconData mapVisibilityToIconData(PleromaVisibility visibility) {
    switch (visibility) {
      case PleromaVisibility.PUBLIC:
        return FediIcons.world;
        break;
      case PleromaVisibility.UNLISTED:
        return Icons.lock_open;
        break;
      case PleromaVisibility.DIRECT:
        return Icons.message;
        break;
      case PleromaVisibility.LIST:
        return Icons.list;
        break;
      case PleromaVisibility.PRIVATE:
        return Icons.lock;
        break;
    }
    throw "Not supported visibility $visibility";
  }
}