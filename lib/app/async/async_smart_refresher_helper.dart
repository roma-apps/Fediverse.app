import 'package:fedi/app/ui/list/fedi_list_smart_refresher_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef Future<FediListSmartRefresherLoadingState> AsyncAction();

var _logger = Logger("async_smart_refresher_helper.dart");

class AsyncSmartRefresherHelper {
  static Future<FediListSmartRefresherLoadingState> doAsyncRefresh(
      {required RefreshController controller,
      required AsyncAction action}) async {
    _logger.finest(() => "doAsyncRefresh");
    FediListSmartRefresherLoadingState state;
    try {
      state = await action();
    } catch (error, stackTrace) {
      _logger.severe(() => "doAsyncRefresh fail", error, stackTrace);
      state = FediListSmartRefresherLoadingState.failed;
    }
    _logger.finest(() => "doAsyncRefresh state = $state");

    switch (state) {
      case FediListSmartRefresherLoadingState.failed:
        controller.refreshFailed();
        break;
      case FediListSmartRefresherLoadingState.loaded:
      case FediListSmartRefresherLoadingState.noData:
        controller.refreshCompleted();
        // hack, because it is not possible to load more after refresh
        // if old "no data" state was saved
        controller.loadComplete();
        break;

      case FediListSmartRefresherLoadingState.loading:
      case FediListSmartRefresherLoadingState.initialized:
      default:
        throw "invalid state $state";
        break;
    }

    return state;
  }

  static Future<FediListSmartRefresherLoadingState> doAsyncLoading(
      {required RefreshController controller,
      required AsyncAction action}) async {
    _logger.finest(() => "doAsyncLoading");
    FediListSmartRefresherLoadingState state;
    try {
      state = await action();
    } catch (error, stackTrace) {
      _logger.severe(() => "doAsyncLoading fail", error, stackTrace);
      controller.loadFailed();
      state = FediListSmartRefresherLoadingState.failed;
    }

    _logger.finest(() => "doAsyncLoading state = $state");

    switch (state) {
      case FediListSmartRefresherLoadingState.failed:
        controller.loadFailed();
        break;
      case FediListSmartRefresherLoadingState.loaded:
        controller.loadComplete();
        break;
      case FediListSmartRefresherLoadingState.noData:
        controller.loadNoData();
        break;

      case FediListSmartRefresherLoadingState.loading:
      case FediListSmartRefresherLoadingState.initialized:
      default:
        throw "invalid state $state";
        break;
    }

    return state;
  }
}
