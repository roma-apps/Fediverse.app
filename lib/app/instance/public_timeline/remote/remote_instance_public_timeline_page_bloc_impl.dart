import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/instance/public_timeline/instance_public_timeline_page_bloc.dart';
import 'package:fedi/app/instance/public_timeline/instance_public_timeline_page_bloc_impl.dart';
import 'package:fedi/app/instance/public_timeline/instance_public_timeline_page_bloc_proxy_provider.dart';
import 'package:fedi/app/instance/public_timeline/remote/remote_instance_public_timeline_page_bloc.dart';
import 'package:fedi/app/instance/public_timeline/status_list/network_only/instance_public_timeline_status_list_network_only_list_bloc_impl.dart';
import 'package:fedi/app/instance/remote/remote_instance_bloc.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_bloc.dart';
import 'package:fedi/app/status/list/network_only/status_network_only_list_bloc.dart';
import 'package:fedi/app/status/pagination/network_only/status_network_only_pagination_bloc.dart';
import 'package:fedi/app/status/pagination/network_only/status_network_only_pagination_bloc_impl.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/timeline/local_preferences/timeline_local_preference_bloc.dart';
import 'package:fedi/app/timeline/local_preferences/timeline_local_preference_bloc_impl.dart';
import 'package:fedi/local_preferences/memory_local_preferences_service_impl.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/list/pagination_list_bloc_impl.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:fedi/pleroma/api/instance/pleroma_api_instance_model.dart';
import 'package:fedi/pleroma/api/timeline/pleroma_api_timeline_service.dart';
import 'package:fedi/pleroma/api/timeline/pleroma_api_timeline_service_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RemoteInstancePublicTimelinePageBloc
    extends InstancePublicTimelinePageBloc
    implements IRemoteInstancePublicTimelinePageBloc {
  @override
  final IRemoteInstanceBloc remoteInstanceBloc;
  @override
  final IPleromaApiTimelineService pleromaApiTimelineService;

  final IPaginationSettingsBloc paginationSettingsBloc;

  // ignore: avoid-late-keyword
  late MemoryLocalPreferencesService memoryLocalPreferencesService;

  RemoteInstancePublicTimelinePageBloc({
    required this.remoteInstanceBloc,
    required this.paginationSettingsBloc,
    required IPleromaApiInstance pleromaApiInstance,
  })  : pleromaApiTimelineService = PleromaApiTimelineService(
          restService: remoteInstanceBloc.pleromaRestService,
        ),
        super(
          pleromaApiInstance: pleromaApiInstance,
          instanceUri: remoteInstanceBloc.instanceUri,
        ) {
    addDisposable(pleromaApiTimelineService);
  }

  static RemoteInstancePublicTimelinePageBloc createFromContext(
    BuildContext context, {
    required IPleromaApiInstance pleromaApiInstance,
    required IRemoteInstanceBloc remoteInstanceBloc,
  }) {
    return RemoteInstancePublicTimelinePageBloc(
      remoteInstanceBloc: remoteInstanceBloc,
      pleromaApiInstance: pleromaApiInstance,
      paginationSettingsBloc: IPaginationSettingsBloc.of(
        context,
        listen: false,
      ),
    );
  }

  static Widget provideToContext(
    BuildContext context, {
    required Widget child,
    required IPleromaApiInstance pleromaApiInstance,
  }) =>
      Provider<IPleromaApiInstance>.value(
        value: pleromaApiInstance,
        child: DisposableProxyProvider<IRemoteInstanceBloc,
            IRemoteInstancePublicTimelinePageBloc>(
          update: (context, value, previous) =>
              RemoteInstancePublicTimelinePageBloc.createFromContext(
            context,
            remoteInstanceBloc: value,
            pleromaApiInstance: pleromaApiInstance,
          ),
          child: ProxyProvider<IRemoteInstancePublicTimelinePageBloc,
              IInstancePublicTimelinePageBloc>(
            update: (context, value, previous) => value,
            child: InstancePublicTimelinePageBlocProxyProvider(
              child: child,
            ),
          ),
        ),
      );

  @override
  InstanceLocation get instanceLocation => InstanceLocation.remote;

  @override
  Uri get remoteInstanceUriOrNull => instanceUri;

  @override
  Future internalAsyncInit() async {
    memoryLocalPreferencesService = MemoryLocalPreferencesService();

    addDisposable(memoryLocalPreferencesService);

    timelineLocalPreferenceBloc =
        TimelineLocalPreferenceBloc.instancePublicTimeline(
      memoryLocalPreferencesService,
      // userAtHost: userAtHost,
      pleromaApiInstance: pleromaApiInstance,
    );
    await timelineLocalPreferenceBloc.performAsyncInit();

    // display local statuses by default
    var timeline = timelineLocalPreferenceBloc.value;
    await timelineLocalPreferenceBloc.setValue(
      timeline!.copyWith(
        settings: timeline.settings.copyWith(
          onlyLocal: true,
        ),
      ),
    );

    addDisposable(timelineLocalPreferenceBloc);

    var pleromaApiTimelineService = PleromaApiTimelineService(
      restService: remoteInstanceBloc.pleromaRestService,
    );
    addDisposable(pleromaApiTimelineService);

    statusNetworkOnlyListBloc =
        InstancePublicTimelineStatusListNetworkOnlyListBloc(
      pleromaApiTimelineService: pleromaApiTimelineService,
      instanceUri: instanceUri,
      timelineLocalPreferenceBloc: timelineLocalPreferenceBloc,
    );
    addDisposable(statusNetworkOnlyListBloc);

    statusNetworkOnlyPaginationBloc = StatusNetworkOnlyPaginationBloc(
      paginationSettingsBloc: paginationSettingsBloc,
      maximumCachedPagesCount: null,
      listService: statusNetworkOnlyListBloc,
    );
    addDisposable(statusNetworkOnlyPaginationBloc);

    statusPaginationListBloc = PaginationListBloc(
      paginationBloc: statusNetworkOnlyPaginationBloc,
    );
    addDisposable(statusPaginationListBloc);

    timelineLocalPreferenceBloc.stream.listen(
      (_) {
        statusPaginationListBloc.refreshWithController();
      },
    ).disposeWith(this);
  }

  @override
  // ignore: avoid-late-keyword
  late IStatusNetworkOnlyListBloc statusNetworkOnlyListBloc;

  @override
  // ignore: avoid-late-keyword
  late IStatusNetworkOnlyPaginationBloc statusNetworkOnlyPaginationBloc;

  @override
  // ignore: avoid-late-keyword
  late IPaginationListBloc<PaginationPage<IStatus>, IStatus>
      statusPaginationListBloc;

  @override
  // ignore: avoid-late-keyword
  late ITimelineLocalPreferenceBloc timelineLocalPreferenceBloc;

  @override
  String get userAtHost => remoteInstanceBloc.instanceUri.host;
}
