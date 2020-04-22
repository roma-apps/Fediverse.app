import 'package:fedi/refactored/app/pagination/cached/cached_pleroma_pagination_bloc.dart';
import 'package:fedi/refactored/pagination/cached/cached_pagination_bloc_impl.dart';
import 'package:fedi/refactored/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/refactored/pleroma/api/pleroma_api_service.dart';
import 'package:flutter/widgets.dart';

abstract class CachedPleromaPaginationBloc<TItem>
    extends CachedPaginationBloc<CachedPaginationPage<TItem>, TItem>
    implements ICachedPleromaPaginationBloc<TItem> {
  CachedPleromaPaginationBloc(
      {@required int itemsCountPerPage, @required int maximumCachedPagesCount})
      : super(
            maximumCachedPagesCount: maximumCachedPagesCount,
            itemsCountPerPage: itemsCountPerPage);

  IPleromaApi get pleromaApi;

  @override
  bool get isPossibleToLoadFromNetwork => pleromaApi.isApiReadyToUse;

  @override
  CachedPaginationPage<TItem> createPage(
      {@required int pageIndex,
      @required List<TItem> loadedItems,
      @required bool isActuallyRefreshed}) {
    return CachedPaginationPage(
        requestedLimitPerPage: itemsCountPerPage,
        pageIndex: pageIndex,
        values: loadedItems,
        isActuallyRefreshedFromRemote: isActuallyRefreshed);
  }
}
