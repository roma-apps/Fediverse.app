import 'package:fedi/app/status/sensitive/status_sensitive_bloc.dart';
import 'package:fedi/app/ui/overlay/fedi_blurred_overlay_warning_widget.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusSensitiveSpoilerWarningOverlayWidget extends StatelessWidget {
  final Widget child;

  const StatusSensitiveSpoilerWarningOverlayWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var statusSensitiveBloc = IStatusSensitiveBloc.of(context);

    var isAlwaysShowSpoiler = statusSensitiveBloc.isAlwaysShowSpoiler;
    if (isAlwaysShowSpoiler) {
      return child;
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
          // todo: refactor
          // ignore: no-magic-number
          minHeight: 54,
          // ignore: no-magic-number
          minWidth: 200,
        ),
        child: Stack(
          children: [
            child,
            Positioned.fill(
              child: const _StatusSensitiveSpoilerWarningOverlayBodyWidget(),
            ),
          ],
        ),
      );
    }
  }
}

class _StatusSensitiveSpoilerWarningOverlayBodyWidget extends StatelessWidget {
  const _StatusSensitiveSpoilerWarningOverlayBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FediBlurredOverlayWarningWidget(
      buttonText: S.of(context).app_status_spoiler_action_view,
      buttonAction: () {
        var statusSensitiveBloc =
            IStatusSensitiveBloc.of(context, listen: false);

        statusSensitiveBloc.enableDisplay();
      },
    );
  }
}
