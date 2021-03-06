import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/filter/filter_model.dart';
import 'package:fedi/app/filter/repository/filter_repository.dart';
import 'package:fedi/app/filter/repository/filter_repository_model.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/repository/status_repository_model.dart';
import 'package:fedi/app/web_sockets/web_sockets_handler_manager_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:fedi/mastodon/api/filter/mastodon_api_filter_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_dispose/easy_dispose.dart';

abstract class AccountStatusesCachedListBloc extends AsyncInitLoadingBloc
    implements IStatusCachedListBloc {
  final IAccount account;
  final IPleromaApiAccountService pleromaAccountService;

  final IStatusRepository statusRepository;
  final IFilterRepository filterRepository;
  final IMyAccountBloc myAccountBloc;
  // ignore: avoid-late-keyword
  late List<IFilter> filters;

  List<StatusTextCondition> get excludeTextConditions => filters
      .map(
        (filter) => filter.toStatusTextCondition(),
  )
      .toList();

  AccountStatusesCachedListBloc({
    required this.account,
    required this.pleromaAccountService,
    required this.statusRepository,
    required this.filterRepository,
    required this.myAccountBloc,
    required IWebSocketsHandlerManagerBloc webSocketsHandlerManagerBloc,
  }) : super() {
    webSocketsHandlerManagerBloc.listenAccountChannel(
      listenType: WebSocketsListenType.foreground,
      accountId: account.remoteId,
      notification: false,
    ).disposeWith(this);
  }

  @override
  IPleromaApi get pleromaApi => pleromaAccountService;

  @override
  Stream<bool> get settingsChangedStream => Stream.empty();


  FilterRepositoryFilters get filterRepositoryFilters =>
      FilterRepositoryFilters(
        notExpired: true,
        onlyWithContextTypes: [
          MastodonApiFilterContextType.account,
        ],
      );


  @override
  Future internalAsyncInit() async {
    var isAccountIsMe = myAccountBloc.checkAccountIsMe(account);
    if (isAccountIsMe) {
      filters = [];
    } else {

      filters = await filterRepository.findAllInAppType(
        filters: filterRepositoryFilters,
        pagination: null,
        orderingTerms: null,
      );

      filterRepository
          .watchFindAllInAppType(
        filters: filterRepositoryFilters,
        pagination: null,
        orderingTerms: null,
      )
          .listen(
            (newFilters) {
          if (!listEquals(filters, newFilters)) {
            // perhaps we should refresh UI list after this?
            filters = newFilters;
          }
        },
      ).disposeWith(this);

    }
  }
}