import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/acct/account_acct_widget.dart';
import 'package:fedi/app/account/avatar/account_avatar_widget.dart';
import 'package:fedi/app/account/details/local_account_details_page.dart';
import 'package:fedi/app/account/details/remote_account_details_page.dart';
import 'package:fedi/app/account/display_name/account_display_name_widget.dart';
import 'package:fedi/app/account/local_account_bloc_impl.dart';
import 'package:fedi/app/account/remote_account_bloc_impl.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/status/status_bloc.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/spacer/fedi_small_horizontal_spacer.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusAccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statusBloc = IStatusBloc.of(context, listen: true);

    return StreamBuilder<IAccount>(
      stream: statusBloc.reblogOrOriginalAccountStream,
      initialData: statusBloc.reblogOrOriginalAccount,
      builder: (context, snapshot) {
        var reblogOrOriginalAccount = snapshot.data!;

        return buildBody(
          context: context,
          reblogOrOriginalAccount: reblogOrOriginalAccount,
          statusBloc: statusBloc,
        );
      },
    );
  }

  Widget buildBody({
    required BuildContext context,
    required IAccount reblogOrOriginalAccount,
    required IStatusBloc statusBloc,
  }) {
    var isLocal = statusBloc.instanceLocation == InstanceLocation.local;

    return Provider<IAccount>.value(
      value: reblogOrOriginalAccount,
      child: DisposableProxyProvider<IAccount, IAccountBloc>(
        update: (context, account, oldValue) {
          var isNeedWatchLocalRepositoryForUpdates = false;
          var isNeedRefreshFromNetworkOnInit = false;
          var isNeedWatchWebSocketsEvents = false;
          var isNeedPreFetchRelationship = false;

          if (isLocal) {
            return LocalAccountBloc.createFromContext(
              context,
              account: account,
              isNeedWatchLocalRepositoryForUpdates:
                  isNeedWatchLocalRepositoryForUpdates,
              isNeedRefreshFromNetworkOnInit: isNeedRefreshFromNetworkOnInit,
              isNeedWatchWebSocketsEvents: isNeedWatchWebSocketsEvents,
              isNeedPreFetchRelationship: isNeedPreFetchRelationship,
            );
          } else {
            return RemoteAccountBloc.createFromContext(
              context,
              account: account,
              isNeedRefreshFromNetworkOnInit: isNeedRefreshFromNetworkOnInit,
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            if (isLocal) {
              goToLocalAccountDetailsPage(
                context,
                account: reblogOrOriginalAccount,
              );
            } else {
              goToRemoteAccountDetailsPageBasedOnRemoteInstanceAccount(
                context,
                remoteInstanceAccount: reblogOrOriginalAccount,
              );
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const AccountAvatarWidget(
                imageSize: FediSizes.accountAvatarBigSize,
                progressSize: FediSizes.accountAvatarProgressBigSize,
              ),
              const FediSmallHorizontalSpacer(),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AccountDisplayNameWidget(),
                    const AccountAcctWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  const StatusAccountWidget();
}
