import 'package:collection/collection.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/account_model_adapter.dart';
import 'package:fedi/app/account/details/account_details_bloc.dart';
import 'package:fedi/app/account/details/account_details_bloc_impl.dart';
import 'package:fedi/app/account/details/account_details_page.dart';
import 'package:fedi/app/account/remote_account_bloc_impl.dart';
import 'package:fedi/app/async/pleroma/pleroma_async_operation_helper.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/instance/remote/remote_instance_bloc.dart';
import 'package:fedi/app/instance/remote/remote_instance_bloc_impl.dart';
import 'package:fedi/app/instance/remote/remote_instance_error_data.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/status/status_model_adapter.dart';
import 'package:fedi/connection/connection_service.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service_impl.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/pleroma/api/status/pleroma_api_status_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

final _logger = Logger('remote_account_details_page.dart');

void goToRemoteAccountDetailsPageBasedOnRemoteInstanceAccount(
  BuildContext context, {
  required IAccount remoteInstanceAccount,
}) {
  var isAcctRemoteDomainExist = remoteInstanceAccount.isAcctRemoteDomainExist;

  _logger.finest(
    () => 'goToRemoteAccountDetailsPageBasedOnRemoteInstanceAccount'
        'isAcctRemoteDomainExist $isAcctRemoteDomainExist'
        'remoteInstanceAccount $remoteInstanceAccount',
  );

  var currentAuthInstanceBloc = ICurrentAuthInstanceBloc.of(
    context,
    listen: false,
  );
  var currentInstance = currentAuthInstanceBloc.currentInstance;

  if (isAcctRemoteDomainExist && currentInstance != null) {
    // jumping from instance to instance
    goToRemoteAccountDetailsPageBasedOnLocalInstanceRemoteAccount(
      context,
      localInstanceRemoteAccount: remoteInstanceAccount,
    );
  } else {
    Navigator.push(
      context,
      createRemoteAccountDetailsPageRoute(
        account: remoteInstanceAccount,
      ),
    );
  }
}

Future goToRemoteAccountDetailsPageBasedOnLocalInstanceRemoteAccount(
  BuildContext context, {
  required IAccount? localInstanceRemoteAccount,
}) async {
  _logger.finest(
    () => 'goToRemoteAccountDetailsPageBasedOnLocalInstanceRemoteAccount'
        'localInstanceRemoteAccount $localInstanceRemoteAccount',
  );

  var remoteInstanceAccountDialogResult =
      await PleromaAsyncOperationHelper.performPleromaAsyncOperation<IAccount?>(
    context: context,
    errorDataBuilders: [
      remoteInstanceLoadDataErrorAlertDialogBuilder,
    ],
    asyncCode: () async {
      IAccount? result;
      RemoteInstanceBloc? remoteInstanceBloc;
      PleromaApiStatusService? pleromaStatusService;
      PleromaApiAccountService? pleromaAccountService;
      try {
        var instanceUri = localInstanceRemoteAccount!.urlRemoteHostUri;

        remoteInstanceBloc = RemoteInstanceBloc(
          instanceUri: instanceUri,
          connectionService: IConnectionService.of(
            context,
            listen: false,
          ),
          pleromaApiInstance: null,
        );

        pleromaStatusService = PleromaApiStatusService(
          restService: remoteInstanceBloc.pleromaRestService,
        );
        pleromaAccountService = PleromaApiAccountService(
          restService: remoteInstanceBloc.pleromaRestService,
        );

        try {
          // load in Mastodon way. Extract account from status
          result = await loadRemoteInstanceAccountViaAccountInStatus(
            context,
            localInstanceRemoteAccount,
            pleromaStatusService,
          );
        } catch (e) {
          // load in Pleroma way. Use username as id
          var pleromaAccount = await pleromaAccountService.getAccount(
            accountRemoteId: localInstanceRemoteAccount.username,
            withRelationship: false,
          );
          result = pleromaAccount.toDbAccountWrapper();
        }
      } finally {
        // ignore: unawaited_futures
        pleromaStatusService?.dispose();
        // ignore: unawaited_futures
        pleromaAccountService?.dispose();
        // ignore: unawaited_futures
        remoteInstanceBloc?.dispose();
      }

      return result;
    },
  );

  var remoteInstanceAccount = remoteInstanceAccountDialogResult.result;
  if (remoteInstanceAccount != null) {
    goToRemoteAccountDetailsPageBasedOnRemoteInstanceAccount(
      context,
      remoteInstanceAccount: remoteInstanceAccount,
    );
  }
}

Future<IAccount?> loadRemoteInstanceAccountViaAccountInStatus(
  BuildContext context,
  IAccount localInstanceRemoteAccount,
  PleromaApiStatusService pleromaStatusService,
) async {
  var remoteAccountAnyStatusOnLocalInstance =
      await loadRemoteAccountAnyStatusOnLocalInstance(
    context,
    localInstanceRemoteAccount,
  );

  IAccount? result;
  if (remoteAccountAnyStatusOnLocalInstance != null) {
    var remoteInstanceStatusRemoteId =
        remoteAccountAnyStatusOnLocalInstance.urlRemoteId;

    var remoteInstanceRemoteStatus = await pleromaStatusService.getStatus(
      statusRemoteId: remoteInstanceStatusRemoteId,
    );
    result = remoteInstanceRemoteStatus.account.toDbAccountWrapper();
  }

  return result;
}

Future<IStatus?> loadRemoteAccountAnyStatusOnLocalInstance(
  BuildContext context,
  IAccount localInstanceRemoteAccount,
) async {
  var localInstancePleromaAccountService =
      IPleromaApiAccountService.of(context, listen: false);

  var remoteStatuses =
      await localInstancePleromaAccountService.getAccountStatuses(
    accountRemoteId: localInstanceRemoteAccount.remoteId,
    pagination: PleromaApiPaginationRequest(limit: 1),
  );

  var firstPleromaStatus = remoteStatuses.singleOrNull;

  return firstPleromaStatus?.toDbStatusPopulatedWrapper();
}

MaterialPageRoute createRemoteAccountDetailsPageRoute({
  required IAccount account,
}) {
  return MaterialPageRoute(
    builder: (context) {
      return DisposableProvider<IRemoteInstanceBloc>(
        create: (context) {
          var instanceUri = account.urlRemoteHostUri;

          return RemoteInstanceBloc(
            instanceUri: instanceUri,
            connectionService: IConnectionService.of(
              context,
              listen: false,
            ),
            pleromaApiInstance: null,
          );
        },
        child: DisposableProvider<IAccountDetailsBloc>(
          create: (context) => AccountDetailsBloc(
            currentAuthInstanceBloc: ICurrentAuthInstanceBloc.of(
              context,
              listen: false,
            ),
          ),
          child: DisposableProvider<IAccountBloc>(
            create: (context) => RemoteAccountBloc.createFromContext(
              context,
              account: account,
              isNeedRefreshFromNetworkOnInit: false,
            ),
            child: const AccountDetailsPage(),
          ),
        ),
      );
    },
  );
}
