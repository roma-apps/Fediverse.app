import 'package:fedi/app/account/statuses/account_statuses_widget.dart';
import 'package:fedi/app/status/pagination/list/status_cached_pagination_list_media_widget.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:flutter/cupertino.dart';

class AccountStatusesMediaWidget extends AccountStatusesWidget {
  const AccountStatusesMediaWidget({
    Key key,
    Widget header,
    Widget footer,
    bool alwaysShowHeader,
    bool alwaysShowFooter,
    ScrollController scrollController,
  }) : super(
          key: key,
          footer: footer,
          header: header,
          alwaysShowHeader: alwaysShowHeader,
          alwaysShowFooter: alwaysShowFooter,
          scrollController: scrollController,
        );

  @override
  ScrollView buildItemsCollectionView(
          {@required BuildContext context,
          @required List<IStatus> items,
          @required Widget header,
          @required Widget footer}) =>
      StatusCachedPaginationListMediaWidget.buildStaggeredGridView(
        context: context,
        items: items,
        header: header,
        footer: footer,
      );
}