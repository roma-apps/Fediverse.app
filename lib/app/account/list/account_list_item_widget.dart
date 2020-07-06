import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/acct/account_acct_widget.dart';
import 'package:fedi/app/account/avatar/account_avatar_widget.dart';
import 'package:fedi/app/ui/spacer/fedi_small_horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

var _logger = Logger("account_list_item_widget.dart");

class AccountListItemWidget extends StatelessWidget {
  final AccountCallback accountSelectedCallback;

  AccountListItemWidget({
    @required this.accountSelectedCallback,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);
    _logger.finest(() => "build ${accountBloc.acct}");

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (accountSelectedCallback != null) {
          accountSelectedCallback(context, accountBloc.account);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AccountAvatarWidget(
              imageSize: 36,
              progressSize: 24,
            ),
            const FediSmallHorizontalSpacer(),
            Flexible(child: AccountAcctWidget())
          ],
        ),
      ),
    );
  }
}
