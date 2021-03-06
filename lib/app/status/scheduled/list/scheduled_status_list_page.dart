import 'package:fedi/app/status/scheduled/list/cached/scheduled_status_cached_list_bloc_impl.dart';
import 'package:fedi/app/status/scheduled/pagination/cached/scheduled_status_cached_pagination_bloc_impl.dart';
import 'package:fedi/app/status/scheduled/pagination/list/scheduled_status_pagination_list_widget.dart';
import 'package:fedi/app/status/scheduled/pagination/list/scheduled_status_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/ui/empty/fedi_empty_widget.dart';
import 'package:fedi/app/ui/page/app_bar/fedi_page_title_app_bar.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduledStatusListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FediPageTitleAppBar(
        title: S.of(context).app_account_my_statuses_scheduled_title,
      ),
      body: SafeArea(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) =>
      ScheduledStatusPaginationListTimelineWidget(
        key: PageStorageKey('ScheduledStatusPaginationListTimelineWidget'),
        customEmptyWidget: const _ScheduledStatusListPageEmptyWidget(),
        needWatchLocalRepositoryForUpdates: true,
        successCallback: () {
          var cachedPaginationListWithNewItemsBloc =
              ICachedPaginationListWithNewItemsBloc.of(context, listen: false);
          cachedPaginationListWithNewItemsBloc.refreshWithController();
        },
      );

  const ScheduledStatusListPage({Key? key}) : super(key: key);
}

class _ScheduledStatusListPageEmptyWidget extends StatelessWidget {
  const _ScheduledStatusListPageEmptyWidget();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);

    return FediEmptyWidget(
      title: s.app_account_my_statuses_scheduled_empty_title,
      subTitle: s.app_account_my_statuses_scheduled_subtitle,
    );
  }
}

void goToScheduledStatusListPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ScheduledStatusCachedListBloc.provideToContext(
        context,
        child: ScheduledStatusCachedPaginationBloc.provideToContext(
          context,
          // todo: refactor
          // ignore: no-magic-number
          itemsCountPerPage: 20,
          maximumCachedPagesCount: null,
          child: ScheduledStatusPaginationListWithNewItemsBloc.provideToContext(
            context,
            child: const ScheduledStatusListPage(),
          ),
        ),
      ),
    ),
  );
}
