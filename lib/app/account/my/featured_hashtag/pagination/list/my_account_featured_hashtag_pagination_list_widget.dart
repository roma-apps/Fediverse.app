import 'package:fedi/app/account/my/featured_hashtag/list/my_account_featured_hashtag_list_item_widget.dart';
import 'package:fedi/app/account/my/featured_hashtag/my_account_featured_hashtag_bloc.dart';
import 'package:fedi/app/account/my/featured_hashtag/my_account_featured_hashtag_bloc_impl.dart';
import 'package:fedi/app/account/my/featured_hashtag/my_account_featured_hashtag_model.dart';
import 'package:fedi/app/ui/pagination/fedi_pagination_list_widget.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/list/pagination_list_widget.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AccountFeaturedHashtagPaginationListWidget
    extends FediPaginationListWidget<IMyAccountFeaturedHashtag> {
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const AccountFeaturedHashtagPaginationListWidget({
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
  });

  @override
  ScrollView buildItemsCollectionView({
    BuildContext? context,
    required List<IMyAccountFeaturedHashtag> items,
    Widget? header,
    Widget? footer,
  }) {
    return PaginationListWidget.buildItemsListView(
      context: context,
      keyboardDismissBehavior: keyboardDismissBehavior,
      items: items,
      header: header,
      footer: footer,
      itemBuilder: (context, index) {
        var item = items[index];

        return Provider<IMyAccountFeaturedHashtag>.value(
          value: item,
          child: DisposableProxyProvider<IMyAccountFeaturedHashtag,
              IMyAccountFeaturedHashtagBloc>(
            update: (context, value, previous) =>
                MyAccountFeaturedHashtagBloc.createFromContext(
              context,
              featuredHashtag: value,
            ),
            child: const AccountFeaturedHashtagListItemWidget(),
          ),
        );
      },
    );
  }

  @override
  IPaginationListBloc<PaginationPage<IMyAccountFeaturedHashtag>,
      IMyAccountFeaturedHashtag> retrievePaginationListBloc(
    BuildContext context, {
    bool listen = false,
  }) =>
      Provider.of<
          IPaginationListBloc<PaginationPage<IMyAccountFeaturedHashtag>,
              IMyAccountFeaturedHashtag>>(
        context,
        listen: listen,
      );
}
