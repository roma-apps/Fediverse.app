import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/app/account/my/avatar/my_account_avatar_widget.dart';
import 'package:fedi/app/status/post/new/new_post_status_page.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/timeline/tab/timeline_tab_model.dart';
import 'package:fedi/app/timeline/timeline_post_status_header_widget.dart';
import 'package:fedi/app/timeline/timeline_tabs_bloc.dart';
import 'package:fedi/app/timeline/timeline_widget.dart';
import 'package:fedi/app/ui/fedi_colors.dart';
import 'package:fedi/app/ui/list/fedi_list_tile.dart';
import 'package:fedi/app/ui/page/fedi_home_sliver_page.dart';
import 'package:fedi/app/ui/page/fedi_home_sliver_page_expandable_sliver_app_bar.dart';
import 'package:fedi/app/ui/status_bar/fedi_dark_status_bar_style_area.dart';
import 'package:fedi/app/ui/tab/fedi_text_tab.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/list/with_new_items/pagination_list_with_new_items_bloc.dart';
import 'package:fedi/pagination/list/with_new_items/pagination_list_with_new_items_header_widget.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

var _logger = Logger("timeline_tabs_widget.dart");

class TimelineTabsWidget extends StatelessWidget {
  final List<Widget> appBarActionWidgets;

  TimelineTabsWidget({@required Key key, @required this.appBarActionWidgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timelinesTabsBloc = ITimelineTabsBloc.of(context, listen: true);

    _logger.finest(() => "build");

    var tabs = timelinesTabsBloc.tabs;

    return DefaultTabController(
        length: tabs.length,
        initialIndex: tabs.indexOf(timelinesTabsBloc.selectedTab),
        child: FediHomeSliverPage(
          body: FediDarkStatusBarStyleArea(child: buildBodyWidget(context)),
          appBar: FediHomeSliverPageExpandableSliverAppBar(
            expandedAppBarBodyHeight: 96,
            expandedAppBarTopBar: buildTabBar(context, tabs, timelinesTabsBloc),
            expandedAppBarBody: FediListTile(
              isFirstInList: true,
              child: TimelinePostStatusHeaderWidget(),
            ),
            collapsedAppBarBody: _buildCollapsedAppBarBody(context),
          ),
        ));
  }

  GestureDetector _buildCollapsedAppBarBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToNewPostStatusPage(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            MyAccountAvatarWidget(
              imageSize: 40,
              progressSize: 24,
            ),
            SizedBox(
              width: 24.0,
            ),
            Text(
              tr("app.status.post.field.message.hint"),
              style: TextStyle(
                  fontSize: 18.0,
                  color: FediColors.lightGrey,
                  height: 1.5,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabBar(BuildContext context, List<TimelineTab> tabs,
          ITimelineTabsBloc timelineTabsBloc) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...tabs
                    .map((tab) => FediTextTab(
                          mapTabToTitle(context, tab),
                          index: tabs.indexOf(tab),
                          isTransparent: true,
                        ))
                    .toList(),
                ...appBarActionWidgets
              ],
            ),
          )
        ],
      );

  Tab buildTab(BuildContext context, TimelineTab tab) =>
      Tab(text: mapTabToTitle(context, tab));

  String mapTabToTitle(BuildContext context, TimelineTab tab) {
    switch (tab) {
      case TimelineTab.public:
        return tr("app.home.tab.timelines.tab.public");
        break;
      case TimelineTab.home:
        return tr("app.home.tab.timelines.tab.home");

        break;
      case TimelineTab.local:
        return tr("app.home.tab.timelines.tab.local");
        break;
    }

    throw "Invalid tab $tab";
  }

  Widget buildBodyWidget(BuildContext context) {
    var timelineTabsBloc = ITimelineTabsBloc.of(context, listen: true);
    _logger.finest(() => "buildBodyWidget");
    var tabs = timelineTabsBloc.tabs;
    return TabBarView(
        children: List<Widget>.generate(
      tabs.length,
      (int index) {
        var tab = tabs[index];

        return buildTabBody(context, tab, timelineTabsBloc);
      },
    ));
  }

  Widget buildTabBody(BuildContext context, TimelineTab tab,
      ITimelineTabsBloc timelineTabsBloc) {
    _logger.finest(() => "new tab $tab");

    return Provider<
        IPaginationListWithNewItemsBloc<PaginationPage<IStatus>,
            IStatus>>.value(
      value: timelineTabsBloc.retrieveTimelineTabPaginationListBloc(tab),
      child: ProxyProvider<
          IPaginationListWithNewItemsBloc<PaginationPage<IStatus>, IStatus>,
          IPaginationListBloc<PaginationPage<IStatus>, IStatus>>(
        update: (context, value, previous) => value,
        child: ProxyProvider<
            IPaginationListWithNewItemsBloc<PaginationPage<IStatus>, IStatus>,
            IPaginationListWithNewItemsBloc>(
          update: (context, value, previous) => value,
          child: PaginationListWithNewItemsHeaderWidget(
            textBuilder: (context, updateItemsCount) => plural(
                "app.status.list.new_items.action.tap_to_load_new",
                updateItemsCount),
            child: TimelineWidget(),
          ),
        ),
      ),
    );
  }
}
