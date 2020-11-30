import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc_impl.dart';
import 'package:fedi/app/status/pagination/list/status_cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/timeline/status/timeline_status_cached_list_bloc_impl.dart';
import 'package:fedi/app/timeline/tab/timeline_tab_bloc.dart';
import 'package:fedi/app/timeline/timeline_local_preferences_bloc.dart';
import 'package:fedi/app/timeline/timeline_local_preferences_bloc_impl.dart';
import 'package:fedi/app/timeline/timeline_model.dart';
import 'package:fedi/app/web_sockets/web_sockets_handler_manager_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc.dart';
import 'package:fedi/pleroma/account/pleroma_account_service.dart';
import 'package:fedi/pleroma/timeline/pleroma_timeline_service.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

var _logger = Logger("timeline_tab_bloc_impl.dart");

class TimelineTabBloc extends AsyncInitLoadingBloc implements ITimelineTabBloc {
  @override
  Timeline get timeline => timelineLocalPreferencesBloc.value;
  TimelineStatusCachedListBloc statusCachedListService;
  IStatusCachedPaginationBloc statusCachedPaginationBloc;
  @override
  ITimelineLocalPreferencesBloc timelineLocalPreferencesBloc;

  @override
  ICachedPaginationListWithNewItemsBloc<CachedPaginationPage<IStatus>, IStatus>
      paginationListWithNewItemsBloc;

  final IPleromaAccountService pleromaAccountService;
  final IPleromaTimelineService pleromaTimelineService;
  final IStatusRepository statusRepository;
  final ICurrentAuthInstanceBloc currentAuthInstanceBloc;
  final IWebSocketsHandlerManagerBloc webSocketsHandlerManagerBloc;
  final ILocalPreferencesService preferencesService;
  final IMyAccountBloc myAccountBloc;

  @override
  final String timelineId;

  final WebSocketsListenType webSocketsListenType;

  TimelineTabBloc({
    @required this.timelineId,
    @required this.preferencesService,
    @required this.pleromaTimelineService,
    @required this.pleromaAccountService,
    @required this.statusRepository,
    @required this.currentAuthInstanceBloc,
    @required this.webSocketsHandlerManagerBloc,
    @required this.myAccountBloc,
    @required this.webSocketsListenType,
  }) {
    _logger.finest(() => "TimelineTabBloc timelineId $timelineId");

    timelineLocalPreferencesBloc = TimelineLocalPreferencesBloc.byId(
      preferencesService,
      userAtHost: currentAuthInstanceBloc.currentInstance.userAtHost,
      timelineId: timelineId,
      defaultValue: null,
    );

    addDisposable(disposable: timelineLocalPreferencesBloc);
  }

  IStatusCachedListBloc createListService(
  {@required WebSocketsListenType webSocketsListenType}) =>
      TimelineStatusCachedListBloc(
        pleromaAccountService: pleromaAccountService,
        pleromaTimelineService: pleromaTimelineService,
        statusRepository: statusRepository,
        currentInstanceBloc: currentAuthInstanceBloc,
        timelineLocalPreferencesBloc: timelineLocalPreferencesBloc,
        webSocketsHandlerManagerBloc: webSocketsHandlerManagerBloc,
        webSocketsListenType: webSocketsListenType,
      );

  void resubscribeWebSocketsUpdates(WebSocketsListenType webSocketsListenType) {
    statusCachedListService.resubscribeWebSocketsUpdates(webSocketsListenType);
  }

  @override
  Future internalAsyncInit() async {
    await timelineLocalPreferencesBloc.performAsyncInit();

    statusCachedListService = createListService(webSocketsListenType:webSocketsListenType);
    addDisposable(disposable: statusCachedListService);

    statusCachedPaginationBloc = StatusCachedPaginationBloc(
        itemsCountPerPage: 20,
        maximumCachedPagesCount: null,
        statusListService: statusCachedListService);
    addDisposable(disposable: statusCachedPaginationBloc);

    paginationListWithNewItemsBloc = StatusCachedPaginationListWithNewItemsBloc<
        CachedPaginationPage<IStatus>>(
      paginationBloc: statusCachedPaginationBloc,
      mergeNewItemsImmediately: false,
      mergeOwnStatusesImmediately: true,
      statusCachedListBloc: statusCachedListService,
      myAccountBloc: myAccountBloc,
    );
    addDisposable(disposable: paginationListWithNewItemsBloc);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimelineTabBloc &&
          runtimeType == other.runtimeType &&
          timelineId == other.timelineId;

  @override
  int get hashCode => timelineId.hashCode;

  @override
  String toString() {
    return 'TimelineTabBloc{timelineId: $timelineId}';
  }
}
