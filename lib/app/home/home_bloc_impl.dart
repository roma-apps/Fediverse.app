import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/app/home/home_bloc.dart';
import 'package:fedi/app/home/home_model.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/web_sockets/web_sockets_handler_manager_bloc.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

var _logger = Logger('home_bloc_impl.dart');

const List<HomeTab> _tabs = [
  HomeTab.timelines,
  HomeTab.notifications,
  HomeTab.chat,
  HomeTab.account,
];

class HomeBloc extends DisposableOwner implements IHomeBloc {
  final IStatusRepository statusRepository;
  StreamSubscription? homeTimelinesInactiveUnreadBadgeSubscription;

  // ignore: close_sinks
  final BehaviorSubject<HomeTab> _selectedTabSubject;
  final StreamController<HomeTab> _reselectedTabStreamController =
      StreamController.broadcast();

  final IWebSocketsHandlerManagerBloc webSocketsHandlerManagerBloc;

  @override
  Stream<HomeTab?> get selectedTabStream => _selectedTabSubject.stream;

  @override
  HomeTab? get selectedTab => _selectedTabSubject.valueOrNull;

  final BehaviorSubject<bool> _isTimelinesUnreadSubject =
      BehaviorSubject.seeded(false);

  @override
  bool? get isTimelinesUnread => _isTimelinesUnreadSubject.valueOrNull;

  @override
  Stream<bool> get isTimelinesUnreadStream => _isTimelinesUnreadSubject.stream;

  HomeBloc({
    required HomeTab startTab,
    required this.webSocketsHandlerManagerBloc,
    required this.statusRepository,
  }) : _selectedTabSubject = BehaviorSubject.seeded(startTab) {
    _logger.finest(() => 'constructor');

    _selectedTabSubject.disposeWith(this);
    _isTimelinesUnreadSubject.disposeWith(this);
    _reselectedTabStreamController.disposeWith(this);

    addCustomDisposable(
      () => homeTimelinesInactiveUnreadBadgeSubscription?.cancel(),
    );

    // WebSocketsListenType.background because it is listening for any home tab
    // timelines, notifications, chats overrides websockets listening with
    // WebSocketsListenType.foreground
    addDisposable(webSocketsHandlerManagerBloc.listenMyAccountChannel(
        listenType: WebSocketsListenType.background,
        notification: false,
        chat: false,
      ),
    );

    _selectedTabSubject.listen(
          (_) {
        checkHomeTimelinesInactiveUnreadBadgeSubscription();
      },
    ).disposeWith(this);
  }

  @override
  void selectTab(HomeTab tab) {
    _logger.finest(() => 'selectTab $tab');
    if (selectedTab == tab) {
      _reselectedTabStreamController.add(tab);
    } else {
      _selectedTabSubject.add(tab);
    }
  }

  @override
  void updateTimelinesUnread(bool unread) {
    _isTimelinesUnreadSubject.add(unread);
  }

  bool get isTimelinesTabSelected => selectedTab == HomeTab.timelines;

  @override
  List<HomeTab> get tabs => _tabs;

  @override
  Stream<HomeTab> get reselectedTabStream =>
      _reselectedTabStreamController.stream;

  @override
  Stream<bool> get selectedTabReselectedStream => Rx.combineLatest2(
        selectedTabStream,
        reselectedTabStream,
        (dynamic selectedTab, dynamic reselectedTab) =>
            selectedTab == reselectedTab,
      );

  Future checkHomeTimelinesInactiveUnreadBadgeSubscription() async {
    if (isTimelinesTabSelected) {
      await homeTimelinesInactiveUnreadBadgeSubscription?.cancel();
      // todo: refactor?
      // unread controlled by tab body content via updateTimelinesUnread
    } else {
      var status = await statusRepository.findNewestForHomeTimeline();

      if (status != null) {
        homeTimelinesInactiveUnreadBadgeSubscription = statusRepository
            .watchNewestCountForHomeTimeline(
          lastSeenStatus: status,
        )
            .listen(
          (count) {
            var unread = count > 0;
            updateTimelinesUnread(unread);
          },
        );
      }
    }
  }
}
