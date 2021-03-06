import 'package:fedi/app/filter/filter_model.dart';
import 'package:fedi/app/filter/list/cached/filter_cached_list_bloc.dart';
import 'package:fedi/app/filter/repository/filter_repository.dart';
import 'package:fedi/app/filter/repository/filter_repository_model.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/filter/pleroma_api_filter_service.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:flutter/widgets.dart';

class FilterCachedListBloc extends IFilterCachedListBloc {
  final IPleromaApiFilterService pleromaFilterService;
  final IFilterRepository filterRepository;

  @override
  IPleromaApi get pleromaApi => pleromaFilterService;

  FilterCachedListBloc({
    required this.pleromaFilterService,
    required this.filterRepository,
  });

  @override
  Future<List<IFilter>> loadLocalItems({
    required int? limit,
    required IFilter? newerThan,
    required IFilter? olderThan,
  }) {
    return filterRepository.findAllInAppType(
      pagination: RepositoryPagination(
        olderThanItem: olderThan,
        newerThanItem: newerThan,
        limit: limit,
      ),
      filters: FilterRepositoryFilters(
        notExpired: false,
      ),
      orderingTerms: [
        FilterOrderingTermData.remoteIdDesc,
      ],
    );
  }

  @override
  Future refreshItemsFromRemoteForPage({
    required int? limit,
    required IFilter? newerThan,
    required IFilter? olderThan,
  }) async {
    // todo: dont exclude pleroma types on mastodon instances
    var remoteFilters = await pleromaFilterService.getFilters(
      pagination: PleromaApiPaginationRequest(
        maxId: olderThan?.remoteId,
        sinceId: newerThan?.remoteId,
        limit: limit,
      ),
    );

    await filterRepository.upsertAllInRemoteType(
      remoteFilters,
      batchTransaction: null,
    );
  }

  static FilterCachedListBloc createFromContext(BuildContext context) =>
      FilterCachedListBloc(
        pleromaFilterService: IPleromaApiFilterService.of(
          context,
          listen: false,
        ),
        filterRepository: IFilterRepository.of(
          context,
          listen: false,
        ),
      );

  static Widget provideToContext(
    BuildContext context, {
    required Widget child,
  }) {
    return DisposableProvider<IFilterCachedListBloc>(
      create: (context) => FilterCachedListBloc.createFromContext(
        context,
      ),
      child: child,
    );
  }
}
