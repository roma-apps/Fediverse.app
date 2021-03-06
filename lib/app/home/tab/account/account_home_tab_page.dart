import 'package:auto_size_text/auto_size_text.dart';
import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/header/account_header_background_widget.dart';
import 'package:fedi/app/account/my/action/my_account_action_list_bottom_sheet_dialog.dart';
import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/account/my/my_account_widget.dart';
import 'package:fedi/app/account/my/statuses/favourited/my_account_favourited_statuses_cached_list_bloc.dart';
import 'package:fedi/app/account/my/statuses/favourited/my_account_favourited_statuses_cached_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/account_statuses_media_widget.dart';
import 'package:fedi/app/account/statuses/account_statuses_tab_indicator_item_widget.dart';
import 'package:fedi/app/account/statuses/account_statuses_tab_model.dart';
import 'package:fedi/app/account/statuses/account_statuses_timeline_widget.dart';
import 'package:fedi/app/account/statuses/media_only/cached/account_statuses_media_only_cached_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/pinned_only/network_only/local/local_account_statuses_pinned_only_network_only_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/with_replies/cached/account_statuses_with_replies_cached_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/without_replies/cached/account_statuses_without_replies_cached_list_bloc_impl.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/home/tab/account/account_home_tab_bloc.dart';
import 'package:fedi/app/home/tab/account/menu/account_home_tab_menu_dialog.dart';
import 'package:fedi/app/home/tab/account/menu/badge/account_home_tab_menu_int_badge_bloc_impl.dart';
import 'package:fedi/app/home/tab/home_tab_header_bar_widget.dart';
import 'package:fedi/app/list/cached/pleroma_cached_list_bloc.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc_loading_widget.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc_proxy_provider.dart';
import 'package:fedi/app/status/list/status_list_tap_to_load_overlay_widget.dart';
import 'package:fedi/app/status/pagination/cached/list/status_cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc_impl.dart';
import 'package:fedi/app/status/pagination/network_only/status_network_only_pagination_bloc_impl.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/ui/badge/int/fedi_int_badge_widget.dart';
import 'package:fedi/app/ui/button/icon/fedi_icon_in_circle_blurred_button.dart';
import 'package:fedi/app/ui/fedi_border_radius.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/list/fedi_list_tile.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_with_nested_scrollable_tabs_bloc.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_with_nested_scrollable_tabs_bloc_impl.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_with_nested_scrollable_tabs_widget.dart';
import 'package:fedi/app/ui/spacer/fedi_big_horizontal_spacer.dart';
import 'package:fedi/app/ui/spacer/fedi_small_horizontal_spacer.dart';
import 'package:fedi/app/ui/status_bar/fedi_dark_status_bar_style_area.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/collapsible/owner/collapsible_owner_widget.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/list/pagination_list_bloc_impl.dart';
import 'package:fedi/pagination/pagination_bloc.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_service.dart';
import 'package:fedi/provider/tab_controller_provider.dart';
import 'package:fedi/ui/scroll/scroll_controller_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _headerBackgroundHeight = 120.0;

class AccountHomeTabPage extends StatelessWidget {
  const AccountHomeTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountHomeTabBloc = IAccountHomeTabBloc.of(context);

    return TabControllerProvider(
      tabControllerCreator:
          (BuildContext context, TickerProvider tickerProvider) =>
              TabController(
        vsync: tickerProvider,
        length: accountHomeTabBloc.tabs.length,
      ),
      child: Scaffold(
        backgroundColor: IFediUiColorTheme.of(context).white,
        body: Stack(
          children: [
            ProxyProvider<IMyAccountBloc, IAccountBloc>(
              update: (context, value, previous) => value,
              child: Container(
                height: _headerBackgroundHeight,
                child: const AccountHeaderBackgroundWidget(),
              ),
            ),
            const _AccountHomeTabPageBody(),
          ],
        ),
      ),
    );
  }
}

class _AccountHomeTabPageBody extends StatelessWidget {
  const _AccountHomeTabPageBody();

  @override
  Widget build(BuildContext context) {
    var accountHomeTabBloc = IAccountHomeTabBloc.of(context);
    var tabController = Provider.of<TabController>(context);
    var tabs = accountHomeTabBloc.tabs;

    return DisposableProvider<
        IFediNestedScrollViewWithNestedScrollableTabsBloc>(
      create: (context) => FediNestedScrollViewWithNestedScrollableTabsBloc(
        nestedScrollControllerBloc:
            accountHomeTabBloc.nestedScrollControllerBloc,
        tabController: tabController,
      ),
      child: FediNestedScrollViewWithNestedScrollableTabsWidget(
        onLongScrollUpTopOverlayWidget: null,
        // todo: refactor
        // ignore: no-magic-number
        topSliverScrollOffsetToShowWhiteStatusBar: 100,
        topSliverWidgets: [
          const _AccountHomeTabFediTabMainHeaderBarWidget(),
          const _AccountHomeTabMyAccountWidget(),
          const _AccountHomeTabTextIndicatorWidget(),
        ],
        tabKeyPrefix: 'AccountHomeTabPage',
        tabBodyProviderBuilder:
            (BuildContext context, int index, Widget child) =>
                _AccountHomeTabPageBodyProviderWidget(
          index: index,
          child: child,
        ),
        tabBodyContentBuilder: (BuildContext context, int index) => Container(
          color: IFediUiColorTheme.of(context).offWhite,
          child: _buildTabContent(tabs[index]),
        ),
        tabBodyOverlayBuilder: (BuildContext context, int index) =>
            _buildTabOverlay(tabs[index]),
        tabBarViewContainerBuilder: null,
      ),
    );
  }

  Widget _buildTabOverlay(AccountStatusesTab tab) {
    switch (tab) {
      case AccountStatusesTab.withReplies:
      case AccountStatusesTab.withoutReplies:
      case AccountStatusesTab.media:
        return const StatusListTapToLoadOverlayWidget();
      case AccountStatusesTab.favourites:
      case AccountStatusesTab.pinned:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTabContent(AccountStatusesTab tab) {
    switch (tab) {
      case AccountStatusesTab.withReplies:
      case AccountStatusesTab.withoutReplies:
      case AccountStatusesTab.pinned:
      case AccountStatusesTab.favourites:
        return const CollapsibleOwnerWidget(
          child: AccountStatusesTimelineWidget(),
        );
      case AccountStatusesTab.media:
        return const AccountStatusesMediaWidget();
    }
  }
}

class _AccountHomeTabPageBodyProviderWidget extends StatelessWidget {
  final int index;
  final Widget child;

  const _AccountHomeTabPageBodyProviderWidget({
    Key? key,
    required this.index,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountHomeTabBloc = IAccountHomeTabBloc.of(context);

    return ProxyProvider<IMyAccountBloc, IAccountBloc>(
      update: (context, value, previous) => value,
      child: Builder(
        builder: (context) {
          var tab = accountHomeTabBloc.tabs[index];

          switch (tab) {
            case AccountStatusesTab.withReplies:
              return _AccountHomeTabProviderWithRepliesTabProviderWidget(
                child: child,
              );
            case AccountStatusesTab.withoutReplies:
              return _AccountHomeTabProviderWithoutRepliesTabProviderWidget(
                child: child,
              );
            case AccountStatusesTab.media:
              return _AccountHomeTabProviderMediaTabProviderWidget(
                child: child,
              );
            case AccountStatusesTab.pinned:
              return _AccountHomeTabProviderPinnedTabProviderWidget(
                child: child,
              );
            case AccountStatusesTab.favourites:
              return _AccountHomeTabProviderFavouritedTabProviderWidget(
                child: child,
              );
          }
        },
      ),
    );
  }
}

class _AccountHomeTabMyAccountWidget extends StatelessWidget {
  const _AccountHomeTabMyAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<IMyAccountBloc, IAccountBloc>(
      update: (context, value, previous) => value,
      child: FediDarkStatusBarStyleArea(
        child: ClipRRect(
          borderRadius: FediBorderRadius.topOnlyBigBorderRadius,
          child: Container(
            color: IFediUiColorTheme.of(context).offWhite,
            child: FediListTile(
              isFirstInList: true,
              noPadding: true,
              // special hack to avoid 1px horizontal line on some devices
              oneSidePadding: FediSizes.bigPadding - 1,
              child: MyAccountWidget(
                onStatusesTapCallback: _onStatusesTapCallback,
                footer: null,
                brightness: Brightness.dark,
              ),
//                    oneSidePadding: FediSizes.smallPadding - 1,
            ),
          ),
        ),
      ),
    );
  }
}

void _onStatusesTapCallback(BuildContext context) {
  var scrollControllerBloc = IScrollControllerBloc.of(context, listen: false);
  scrollControllerBloc.scrollController!.animateTo(
    // todo: refactor
    // ignore: no-magic-number
    MediaQuery.of(context).size.height / 2,
    // todo: refactor
    // ignore: no-magic-number
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOut,
  );
}

class _AccountHomeTabProviderWithRepliesTabProviderWidget
    extends StatelessWidget {
  final Widget child;

  const _AccountHomeTabProviderWithRepliesTabProviderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);

    return AccountStatusesWithRepliesCachedListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusCachedListBlocLoadingWidget(
        child: StatusCachedPaginationBloc.provideToContext(
          context,
          child: StatusCachedPaginationListWithNewItemsBloc.provideToContext(
            context,
            mergeNewItemsImmediately: true,
            child: child,
            mergeOwnStatusesImmediately: false,
          ),
        ),
      ),
    );
  }
}

class _AccountHomeTabProviderWithoutRepliesTabProviderWidget
    extends StatelessWidget {
  final Widget child;

  const _AccountHomeTabProviderWithoutRepliesTabProviderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);

    return AccountStatusesWithoutRepliesListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusCachedListBlocLoadingWidget(
        child: StatusCachedPaginationBloc.provideToContext(
          context,
          child: StatusCachedPaginationListWithNewItemsBloc.provideToContext(
            context,
            mergeNewItemsImmediately: true,
            child: child,
            mergeOwnStatusesImmediately: false,
          ),
        ),
      ),
    );
  }
}

class _AccountHomeTabProviderMediaTabProviderWidget extends StatelessWidget {
  final Widget child;

  const _AccountHomeTabProviderMediaTabProviderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);

    return AccountStatusesMediaOnlyCachedListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusCachedListBlocLoadingWidget(
        child: StatusCachedPaginationBloc.provideToContext(
          context,
          child: StatusCachedPaginationListWithNewItemsBloc.provideToContext(
            context,
            mergeNewItemsImmediately: true,
            child: child,
            mergeOwnStatusesImmediately: false,
          ),
        ),
      ),
    );
  }
}

class _AccountHomeTabProviderPinnedTabProviderWidget extends StatelessWidget {
  final Widget child;

  const _AccountHomeTabProviderPinnedTabProviderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);

    return LocalAccountStatusesPinnedOnlyNetworkOnlyListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusNetworkOnlyPaginationBloc.provideToContext(
        context,
        child: DisposableProvider<
            IPaginationListBloc<PaginationPage<IStatus>, IStatus>>(
          create: (context) =>
              PaginationListBloc<PaginationPage<IStatus>, IStatus>(
            paginationBloc:
                Provider.of<IPaginationBloc<PaginationPage<IStatus>, IStatus>>(
              context,
              listen: false,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _AccountHomeTabProviderFavouritedTabProviderWidget
    extends StatelessWidget {
  final Widget child;

  const _AccountHomeTabProviderFavouritedTabProviderWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisposableProvider<IMyAccountFavouritedStatusesCachedListBloc>(
      create: (context) => MyAccountFavouritedStatusesCachedListBloc(
        pleromaMyAccountService: IPleromaApiMyAccountService.of(
          context,
          listen: false,
        ),
        statusRepository: IStatusRepository.of(
          context,
          listen: false,
        ),
      ),
      child: ProxyProvider<IMyAccountFavouritedStatusesCachedListBloc,
          IStatusCachedListBloc>(
        update: (context, value, previous) => value,
        child: StatusCachedListBlocProxyProvider(
          child: ProxyProvider<IMyAccountFavouritedStatusesCachedListBloc,
              IPleromaCachedListBloc<IStatus?>>(
            update: (context, value, previous) => value,
            child: StatusCachedListBlocLoadingWidget(
              child: StatusCachedPaginationBloc.provideToContext(
                context,
                child:
                    StatusCachedPaginationListWithNewItemsBloc.provideToContext(
                  context,
                  child: child,
                  mergeNewItemsImmediately: false,
                  mergeOwnStatusesImmediately: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountHomeTabCurrentInstanceNameWidget extends StatelessWidget {
  const _AccountHomeTabCurrentInstanceNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentInstanceBloc =
        ICurrentAuthInstanceBloc.of(context, listen: false);

    return AutoSizeText(
      currentInstanceBloc.currentInstance!.userAtHost,
      minFontSize: IFediUiTextTheme.of(context).smallShortBoldWhite.fontSize!,
      maxFontSize:
          IFediUiTextTheme.of(context).subHeaderShortBoldWhite.fontSize!,
      maxLines: 1,
      style: IFediUiTextTheme.of(context).subHeaderShortBoldWhite,
    );
  }
}

class _AccountHomeTabTextIndicatorWidget extends StatelessWidget {
  const _AccountHomeTabTextIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountHomeTabBloc = IAccountHomeTabBloc.of(context);

    return Padding(
      // ignore: no-magic-number
      padding: EdgeInsets.only(top: 3.0, right: FediSizes.bigPadding),
      child: AccountTabTextTabIndicatorItemWidget(
        accountTabs: accountHomeTabBloc.tabs,
      ),
    );
  }
}

class _AccountHomeTabFediTabMainHeaderBarWidget extends StatelessWidget {
  const _AccountHomeTabFediTabMainHeaderBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FediTabMainHeaderBarWidget(
        leadingWidgets: null,
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showMyAccountActionListBottomSheetDialog(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child:
                              const _AccountHomeTabCurrentInstanceNameWidget(),
                        ),
                        const FediSmallHorizontalSpacer(),
                        Icon(
                          FediIcons.chevron_down,
                          // todo: refactor
                          // ignore: no-magic-number
                          size: 18.0,
                          color: IFediUiColorTheme.of(context).white,
                        ),
                      ],
                    ),
                  ),
                ),
                const FediBigHorizontalSpacer(),
                AccountHomeTabMenuIntBadgeBloc.provideToContext(
                  context,
                  child: FediIntBadgeWidget(
                    offset: 0.0,
                    child: FediIconInCircleBlurredButton(
                      FediIcons.settings,
                      // todo: refactor
                      // ignore: no-magic-number
                      iconSize: 15.0,
                      onPressed: () {
                        showAccountHomeTabMenuDialog(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        endingWidgets: null,
      );
}
