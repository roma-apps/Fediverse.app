import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/action/message/account_action_message.dart';
import 'package:fedi/app/account/action/mute/account_action_mute_dialog.dart';
import 'package:fedi/app/account/details/remote_account_details_page.dart';
import 'package:fedi/app/account/remote_account_bloc_impl.dart';
import 'package:fedi/app/account/report/account_report_page.dart';
import 'package:fedi/app/async/pleroma/pleroma_async_operation_helper.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/instance/details/local/local_instance_details_page.dart';
import 'package:fedi/app/instance/details/remote/remote_instance_details_page.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/status/status_bloc.dart';
import 'package:fedi/app/ui/dialog/chooser/fedi_chooser_dialog.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:fedi/app/ui/modal_bottom_sheet/fedi_modal_bottom_sheet.dart';
import 'package:fedi/app/url/url_helper.dart';
import 'package:fedi/dialog/dialog_model.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void showAccountActionMoreDialog({
  required BuildContext context,
  required IAccountBloc accountBloc,
}) {
  showFediModalBottomSheetDialog(
    context: context,
    child: Provider<IAccountBloc>.value(
      value: accountBloc,
      child: Provider<IAccount>.value(
        value: accountBloc.account,
        child: const AccountActionMoreDialog(
          cancelable: true,
          showReportAction: false,
        ),
      ),
    ),
  );
}

class AccountActionMoreDialog extends StatelessWidget {
  final bool cancelable;
  final bool showReportAction;

  const AccountActionMoreDialog({
    required this.cancelable,
    required this.showReportAction,
  });

  @override
  // ignore: code-metrics
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);
    var isAcctRemoteDomainExist = accountBloc.isAcctRemoteDomainExist;
    var currentAuthInstanceBloc = ICurrentAuthInstanceBloc.of(context);
    var isEndorsementSupported = currentAuthInstanceBloc.isEndorsementSupported;
    var isSubscribeToAccountFeatureSupported =
        currentAuthInstanceBloc.isSubscribeToAccountFeatureSupported;

    var isLocal = accountBloc.instanceLocation == InstanceLocation.local;

    return StreamBuilder<IPleromaApiAccountRelationship?>(
      stream: accountBloc.relationshipStream,
      builder: (context, snapshot) {
        var accountRelationship = snapshot.data;
        var isRelationshipLoaded = accountRelationship != null;

        return FediChooserDialogBody(
          title: S.of(context).app_account_action_popup_title,
          content: '${accountBloc.acct}',
          actions: [
            if (isLocal && accountBloc.isAcctRemoteDomainExist)
              AccountActionMoreDialog.buildAccountOpenOnRemoteInstance(context),
            AccountActionMoreDialog.buildAccountOpenInBrowserAction(context),
            if (isLocal && isRelationshipLoaded)
              AccountActionMoreDialog.buildAccountMuteAction(context),
            if (isLocal && isRelationshipLoaded)
              AccountActionMoreDialog.buildAccountBlockAction(context),
            if (isLocal && isRelationshipLoaded && isEndorsementSupported)
              AccountActionMoreDialog.buildAccountPinAction(context),
            if (isLocal && isAcctRemoteDomainExist && isRelationshipLoaded)
              AccountActionMoreDialog.buildAccountBlockDomainAction(context),
            if (isLocal && showReportAction)
              AccountActionMoreDialog.buildAccountReportAction(context),
            if (isLocal &&
                isSubscribeToAccountFeatureSupported &&
                isRelationshipLoaded)
              AccountActionMoreDialog.buildAccountSubscribeAction(context),
            buildAccountInstanceInfoAction(context),
          ],
          cancelable: cancelable,
        );
      },
    );
  }

  static DialogAction buildAccountReportAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);
    var statusBloc = IStatusBloc.of(context, listen: false);

    return DialogAction(
      icon: FediIcons.report,
      label: S.of(context).app_account_action_report_label,
      onAction: (context) async {
        goToAccountReportPage(
          context,
          account: accountBloc.account,
          statuses: [
            statusBloc.status,
          ],
        );
      },
    );
  }

  static DialogAction buildAccountBlockAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    return DialogAction(
      icon: accountBloc.relationship?.blocking == true
          ? FediIcons.unblock
          : FediIcons.block,
      label: accountBloc.relationship?.blocking == true
          ? S.of(context).app_account_action_unblock
          : S.of(context).app_account_action_block,
      onAction: (context) async {
        await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
          context: context,
          asyncCode: () async => accountBloc.toggleBlock(),
        );

        Navigator.of(context).pop();
      },
    );
  }

  static DialogAction buildAccountPinAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    return DialogAction(
      icon: accountBloc.relationship?.endorsed == true
          ? FediIcons.pin
          : FediIcons.unpin,
      label: accountBloc.relationship?.endorsed == true
          ? S.of(context).app_account_action_unpin
          : S.of(context).app_account_action_pin,
      onAction: (context) async {
        await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
          context: context,
          asyncCode: () async => accountBloc.togglePin(),
        );

        Navigator.of(context).pop();
      },
    );
  }

  static DialogAction buildAccountBlockDomainAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    return DialogAction(
      icon: accountBloc.relationship!.domainBlocking == true
          ? FediIcons.domain_block
          : FediIcons.domain_unblock,
      label: accountBloc.relationship!.domainBlocking == true
          ? S.of(context).app_account_action_unblockDomain(
                accountBloc.acctRemoteDomainOrNull!,
              )
          : S.of(context).app_account_action_blockDomain(
                accountBloc.acctRemoteDomainOrNull!,
              ),
      onAction: (context) async {
        await accountBloc.toggleBlockDomain();
        Navigator.of(context).pop();
      },
    );
  }

  static DialogAction buildAccountInstanceInfoAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    var remoteDomainOrNull = accountBloc.acctRemoteDomainOrNull;

    var isLocal = accountBloc.instanceLocation == InstanceLocation.local;
    var isRemote = accountBloc.instanceLocation == InstanceLocation.remote;

    // todo: remove hack
    if (isRemote) {
      var remoteAccountBloc = accountBloc as RemoteAccountBloc;
      remoteDomainOrNull ??= remoteAccountBloc.instanceUri!.host;
    }

    String label;
    if (isLocal) {
      var currentInstanceUrlHost =
          ICurrentAuthInstanceBloc.of(context, listen: false)
              .currentInstance!
              .urlHost;
      label = S
          .of(context)
          .app_account_action_instanceDetails(currentInstanceUrlHost);
    } else {
      label = S.of(context).app_account_action_instanceDetails(
            remoteDomainOrNull!,
          );
    }

    return DialogAction(
      icon: FediIcons.instance,
      label: label,
      onAction: (context) async {
        if (isLocal) {
          goToLocalInstanceDetailsPage(context);
        } else {
          // todo: https shouldnt be hardcoded
          var remoteInstanceUri = Uri.parse(
            'https://$remoteDomainOrNull',
          );
          goToRemoteInstanceDetailsPage(
            context,
            remoteInstanceUri: remoteInstanceUri,
          );
        }
      },
    );
  }

  static DialogAction buildAccountMuteAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);
    var muting = accountBloc.relationship?.muting == true;

    return DialogAction(
      icon: muting ? FediIcons.unmute : FediIcons.mute,
      label: muting
          ? S.of(context).app_account_action_unmute
          : S.of(context).app_account_action_mute,
      onAction: (context) async {
        if (muting) {
          await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
            context: context,
            asyncCode: () => accountBloc.unMute(),
          );
          Navigator.of(context).pop();
        } else {
          await showAccountActionMuteDialog(
            context: context,
            accountBloc: accountBloc,
          );
          Navigator.of(context).pop();
        }
      },
    );
  }

  static DialogAction buildAccountSubscribeAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);
    var muting = accountBloc.relationship?.subscribing == true;

    return DialogAction(
      icon: muting ? FediIcons.unsubscribe : FediIcons.subscribe,
      label: muting
          ? S.of(context).app_account_action_unsubscribe
          : S.of(context).app_account_action_subscribe,
      onAction: (context) async {
        await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
          context: context,
          asyncCode: () => accountBloc.toggleSubscribe(),
        );

        Navigator.of(context).pop();
      },
    );
  }

  static DialogAction buildAccountFollowAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    return DialogAction(
      icon: accountBloc.relationship?.following == true
          ? FediIcons.unfollow
          : FediIcons.follow,
      label: accountBloc.relationship?.following == true
          ? S.of(context).app_account_action_unfollow
          : S.of(context).app_account_action_follow,
      onAction: (context) async {
        await PleromaAsyncOperationHelper.performPleromaAsyncOperation(
          context: context,
          asyncCode: () => accountBloc.toggleFollow(),
        );

        Navigator.of(context).pop();
      },
    );
  }

  static DialogAction buildAccountMessageAction(BuildContext context) {
    return DialogAction(
      icon: FediIcons.message,
      label: S.of(context).app_account_action_message,
      onAction: (context) {
        goToMessagesPageAccountAction(context);
      },
    );
  }

  static DialogAction buildAccountOpenInBrowserAction(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    return DialogAction(
      icon: FediIcons.browser,
      label: S.of(context).app_account_action_openInBrowser,
      onAction: (context) async {
        var url = accountBloc.account.url;
        await UrlHelper.handleUrlClickWithInstanceLocation(
          context: context,
          url: url,
          instanceLocationBloc: accountBloc,
        );
        Navigator.of(context).pop();
      },
    );
  }

  static DialogAction buildAccountOpenOnRemoteInstance(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: false);

    return DialogAction(
      icon: FediIcons.instance,
      label: S.of(context).app_account_action_openOnRemoteInstance(
            accountBloc.acctRemoteDomainOrNull!,
          ),
      onAction: (context) async {
        await goToRemoteAccountDetailsPageBasedOnLocalInstanceRemoteAccount(
          context,
          localInstanceRemoteAccount: accountBloc.account,
        );
      },
    );
  }
}
