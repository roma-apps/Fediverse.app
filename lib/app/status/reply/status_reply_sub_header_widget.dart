import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/status/status_bloc.dart';
import 'package:fedi/app/status/sub_header/status_sub_header_widget.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusReplySubHeaderWidget extends StatelessWidget {
  final AccountCallback accountCallback;

  @override
  Widget build(BuildContext context) {
    var statusBloc = IStatusBloc.of(context, listen: true);
    if (statusBloc.isReply) {
      return StreamBuilder<IAccount>(
          stream: statusBloc.watchInReplyToAccount(),
          initialData: null,
          builder: (context, snapshot) {
            var account = snapshot.data;

            // todo: show progress
            if (account == null) {
              return SizedBox.shrink();
            }

            return StatusSubHeaderWidget(
                descText: tr("app.status.reply.header"),
                account: account,
                icon: FediIcons.message,
                accountCallback: accountCallback);
          });
    } else {
      return const SizedBox.shrink();
    }
  }

  const StatusReplySubHeaderWidget({this.accountCallback});
}
