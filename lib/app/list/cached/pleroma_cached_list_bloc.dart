import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';

abstract class IPleromaCachedListBloc<T> extends DisposableOwner {
  IPleromaApi get pleromaApi;

  Future<List<T>> loadLocalItems({
    required int? limit,
    required T? newerThan,
    required T? olderThan,
  });

  Future refreshItemsFromRemoteForPage({
    required int? limit,
    required T? newerThan,
    required T? olderThan,
  });
}
