import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/app/status/status_bloc.dart';
import 'package:fedi/app/status/thread/status_thread_page.dart';
import 'package:fedi/app/ui/fedi_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusShowThisThreadActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statusBloc = IStatusBloc.of(context, listen: false);
    return InkWell(
        onTap: () {
          goToStatusThreadPage(context, statusBloc.status);
        },
        child: Container(
            height: 48,
            child: Center(
                child: Text(
              tr("app.status.action.show_this_thread"),
              style: TextStyle(fontSize: 16, color: FediColors.primaryColor),
            ))));
  }
}
