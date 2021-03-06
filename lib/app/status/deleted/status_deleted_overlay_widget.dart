import 'package:fedi/app/ui/overlay/fedi_blurred_overlay_warning_widget.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusDeletedOverlayWidget extends StatelessWidget {
  const StatusDeletedOverlayWidget();

  @override
  Widget build(BuildContext context) => FediBlurredOverlayWarningWidget(
    descriptionText: S.of(context).app_status_deleted_desc,
  );
}
