import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/list/cached/account_cached_list_bloc.dart';
import 'package:fedi/app/account/list/cached/account_cached_list_bloc_proxy_provider.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/account/repository/account_repository_model.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

var _logger = Logger('account_following_account_cached_list_bloc_impl.dart');

class AccountFollowingAccountCachedListBloc extends DisposableOwner
    implements IAccountCachedListBloc {
  final IPleromaApiAccountService pleromaAccountService;
  final IAccountRepository accountRepository;
  final IAccount account;

  AccountRepositoryFilters get _accountRepositoryFilters =>
      AccountRepositoryFilters(
        onlyInAccountFollowing: account,
      );

  AccountFollowingAccountCachedListBloc({
    required this.pleromaAccountService,
    required this.accountRepository,
    required this.account,
  });

  @override
  IPleromaApi get pleromaApi => pleromaAccountService;

  @override
  Future refreshItemsFromRemoteForPage({
    required int? limit,
    required IAccount? newerThan,
    required IAccount? olderThan,
  }) async {
    _logger.fine(() => 'start refreshItemsFromRemoteForPage \n'
        '\t newerThanAccount = $newerThan'
        '\t olderThanAccount = $olderThan');

    List<IPleromaApiAccount> remoteAccounts;

    remoteAccounts = await pleromaAccountService.getAccountFollowings(
      accountRemoteId: account.remoteId,
      pagination: PleromaApiPaginationRequest(
        maxId: olderThan?.remoteId,
        sinceId: newerThan?.remoteId,
        limit: limit,
      ),
      withRelationship: false,
    );

    await accountRepository.batch((batch) {
      accountRepository.upsertAllInRemoteType(
        remoteAccounts,
        batchTransaction: batch,
      );

      accountRepository.addAccountFollowings(
        accountRemoteId: account.remoteId,
        followings: remoteAccounts.toPleromaApiAccounts(),
        batchTransaction: batch,
      );
    });
  }

  @override
  Future<List<IAccount>> loadLocalItems({
    required int? limit,
    required IAccount? newerThan,
    required IAccount? olderThan,
  }) async {
    _logger.finest(() => 'start loadLocalItems \n'
        '\t newerThanAccount=$newerThan'
        '\t olderThanAccount=$olderThan');

    var accounts = await accountRepository.findAllInAppType(
      pagination: RepositoryPagination<IAccount>(
        olderThanItem: olderThan,
        newerThanItem: newerThan,
        limit: limit,
      ),
      orderingTerms: [AccountRepositoryOrderingTermData.remoteIdDesc],
      filters: _accountRepositoryFilters,
    );

    _logger.finer(() => 'finish loadLocalItems accounts ${accounts.length}');

    return accounts;
  }

  static AccountFollowingAccountCachedListBloc createFromContext(
    BuildContext context, {
    required IAccount account,
  }) =>
      AccountFollowingAccountCachedListBloc(
        accountRepository: IAccountRepository.of(context, listen: false),
        pleromaAccountService: IPleromaApiAccountService.of(
          context,
          listen: false,
        ),
        account: account,
      );

  static Widget provideToContext(
    BuildContext context, {
    required IAccount account,
    required Widget child,
  }) {
    return DisposableProvider<IAccountCachedListBloc>(
      create: (context) =>
          AccountFollowingAccountCachedListBloc.createFromContext(
        context,
        account: account,
      ),
      child: AccountCachedListBlocProxyProvider(
        child: child,
      ),
    );
  }

  @override
  InstanceLocation get instanceLocation => InstanceLocation.local;

  @override
  Uri? get remoteInstanceUriOrNull => null;
}
