import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/filter/repository/filter_repository.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_bloc.dart';
import 'package:fedi/app/status/pagination/cached/list/status_cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc_impl.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/timeline/local_preferences/timeline_local_preference_bloc.dart';
import 'package:fedi/app/timeline/local_preferences/timeline_local_preference_bloc_impl.dart';
import 'package:fedi/app/timeline/status/timeline_status_cached_list_bloc_impl.dart';
import 'package:fedi/app/timeline/tab/timeline_tab_bloc.dart';
import 'package:fedi/app/timeline/timeline_model.dart';
import 'package:fedi/app/web_sockets/web_sockets_handler_manager_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:fedi/pleroma/api/timeline/auth/pleroma_api_auth_timeline_service.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

var _logger = Logger('timeline_tab_bloc_impl.dart');

class TimelineTabBloc extends AsyncInitLoadingBloc implements ITimelineTabBloc {
  @override
  Timeline get timeline => timelineLocalPreferencesBloc.value!;
  @override
  // ignore: avoid-late-keyword
  late TimelineStatusCachedListBloc statusCachedListBloc;

  // ignore: avoid-late-keyword
  late IStatusCachedPaginationBloc statusCachedPaginationBloc;
  @override
  // ignore: avoid-late-keyword
  late ITimelineLocalPreferenceBloc timelineLocalPreferencesBloc;

  @override
  // ignore: avoid-late-keyword
  late ICachedPaginationListWithNewItemsBloc<CachedPaginationPage<IStatus>,
      IStatus> paginationListWithNewItemsBloc;

  final IPleromaApiAccountService pleromaApiAccountService;
  final IPleromaApiAuthTimelineService pleromaApiAuthTimelineService;
  final IStatusRepository statusRepository;
  final ICurrentAuthInstanceBloc currentAuthInstanceBloc;
  final IWebSocketsHandlerManagerBloc webSocketsHandlerManagerBloc;
  final ILocalPreferencesService preferencesService;
  final IMyAccountBloc myAccountBloc;
  final IFilterRepository filterRepository;

  @override
  final String timelineId;

  final WebSocketsListenType webSocketsListenType;
  final IPaginationSettingsBloc paginationSettingsBloc;

  TimelineTabBloc({
    required this.timelineId,
    required this.preferencesService,
    required this.pleromaApiAuthTimelineService,
    required this.pleromaApiAccountService,
    required this.statusRepository,
    required this.currentAuthInstanceBloc,
    required this.webSocketsHandlerManagerBloc,
    required this.myAccountBloc,
    required this.webSocketsListenType,
    required this.filterRepository,
    required this.paginationSettingsBloc,
  }) {
    _logger.finest(() => 'TimelineTabBloc timelineId $timelineId');

    timelineLocalPreferencesBloc = TimelineLocalPreferenceBloc.byId(
      preferencesService,
      userAtHost: currentAuthInstanceBloc.currentInstance!.userAtHost,
      timelineId: timelineId,
      defaultPreferenceValue: null,
    );

    addDisposable(timelineLocalPreferencesBloc);
  }

  TimelineStatusCachedListBloc createListService({
    required WebSocketsListenType webSocketsListenType,
  }) =>
      TimelineStatusCachedListBloc(
        pleromaApiAccountService: pleromaApiAccountService,
        pleromaApiAuthTimelineService: pleromaApiAuthTimelineService,
        statusRepository: statusRepository,
        currentInstanceBloc: currentAuthInstanceBloc,
        timelineLocalPreferenceBloc: timelineLocalPreferencesBloc,
        webSocketsHandlerManagerBloc: webSocketsHandlerManagerBloc,
        webSocketsListenType: webSocketsListenType,
        filterRepository: filterRepository,
        myAccountBloc: myAccountBloc,
      );

  @override
  void resubscribeWebSocketsUpdates(WebSocketsListenType webSocketsListenType) {
    statusCachedListBloc.resubscribeWebSocketsUpdates(webSocketsListenType);
  }

  @override
  Future internalAsyncInit() async {
    await timelineLocalPreferencesBloc.performAsyncInit();

    statusCachedListBloc =
        createListService(webSocketsListenType: webSocketsListenType);
    addDisposable(statusCachedListBloc);

    await statusCachedListBloc.performAsyncInit();

    statusCachedPaginationBloc = StatusCachedPaginationBloc(
      maximumCachedPagesCount: null,
      statusListService: statusCachedListBloc,
      paginationSettingsBloc: paginationSettingsBloc,
    );
    addDisposable(statusCachedPaginationBloc);

    paginationListWithNewItemsBloc = StatusCachedPaginationListWithNewItemsBloc<
        CachedPaginationPage<IStatus>>(
      paginationBloc: statusCachedPaginationBloc,
      mergeNewItemsImmediately: false,
      mergeOwnStatusesImmediately: true,
      statusCachedListBloc: statusCachedListBloc,
      myAccountBloc: myAccountBloc,
    );
    addDisposable(paginationListWithNewItemsBloc);
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

  static TimelineTabBloc createFromContext(
    BuildContext context, {
    required String timelineId,
    required WebSocketsListenType webSocketsListenType,
  }) =>
      TimelineTabBloc(
        timelineId: timelineId,
        webSocketsListenType: webSocketsListenType,
        filterRepository: IFilterRepository.of(
          context,
          listen: false,
        ),
        pleromaApiAuthTimelineService:
            IPleromaApiAuthTimelineService.of(context, listen: false),
        pleromaApiAccountService:
            IPleromaApiAccountService.of(context, listen: false),
        statusRepository: IStatusRepository.of(context, listen: false),
        myAccountBloc: IMyAccountBloc.of(context, listen: false),
        currentAuthInstanceBloc:
            ICurrentAuthInstanceBloc.of(context, listen: false),
        preferencesService: ILocalPreferencesService.of(context, listen: false),
        webSocketsHandlerManagerBloc:
            IWebSocketsHandlerManagerBloc.of(context, listen: false),
        paginationSettingsBloc: IPaginationSettingsBloc.of(
          context,
          listen: false,
        ),
      );
}
