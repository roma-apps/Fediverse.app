import 'package:fedi/app/account/my/statuses/favourited/my_account_favourited_statuses_cached_list_bloc.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/repository/status_repository_model.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:fedi/pleroma/account/my/pleroma_my_account_service.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/pagination/pleroma_pagination_model.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

var _logger =
    Logger("my_account_favourited_statuses_cached_list_bloc_impl.dart");

var _statusRepositoryFilters = StatusRepositoryFilters(
  onlyFavourited: true,
);

class MyAccountFavouritedStatusesCachedListBloc extends AsyncInitLoadingBloc
    implements IMyAccountFavouritedStatusesCachedListBloc {
  final IStatusRepository statusRepository;
  final IPleromaMyAccountService pleromaMyAccountService;

  MyAccountFavouritedStatusesCachedListBloc({
    @required this.pleromaMyAccountService,
    @required this.statusRepository,
  });

  @override
  IPleromaApi get pleromaApi => pleromaMyAccountService;

  @override
  Stream<bool> get settingsChangedStream => Stream.empty();

  @override
  Future<List<IStatus>> loadLocalItems({
    int limit,
    IStatus newerThan,
    IStatus olderThan,
  }) {
    return statusRepository.getStatuses(
      filters: _statusRepositoryFilters,
      pagination: RepositoryPagination<IStatus>(
        olderThanItem: olderThan,
        newerThanItem: newerThan,
        limit: limit,
      ),
    );
  }

  @override
  Stream<List<IStatus>> watchLocalItemsNewerThanItem(
    IStatus item,
  ) {
    return statusRepository.watchStatuses(
      filters: _statusRepositoryFilters,
      pagination: RepositoryPagination<IStatus>(
        newerThanItem: item,
      ),
    );
  }

  @override
  Future<bool> refreshItemsFromRemoteForPage({
    int limit,
    IStatus newerThan,
    IStatus olderThan,
  }) async {
    var remoteStatuses = await pleromaMyAccountService.getFavourites(
      pagination: PleromaPaginationRequest(
        sinceId: newerThan?.remoteId,
        maxId: olderThan?.remoteId,
        limit: limit,
      ),
    );

    if (remoteStatuses != null) {
      await statusRepository.upsertRemoteStatuses(
        remoteStatuses,
        listRemoteId: null,
        conversationRemoteId: null,
      );

      return true;
    } else {
      _logger.severe(() => "error during refreshItemsFromRemoteForPage: "
          "accounts is null");
      return false;
    }
  }

  @override
  Future internalAsyncInit() async {
    // nothing
  }

  @override
  InstanceLocation get instanceLocation => InstanceLocation.local;

  @override
  Uri get remoteInstanceUriOrNull => null;
}
