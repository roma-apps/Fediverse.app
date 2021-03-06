import 'package:fedi/app/account/my/featured_hashtag/suggestion/my_account_featured_hashtag_suggestion_bloc_impl.dart';
import 'package:fedi/app/account/my/featured_hashtag/suggestion/my_account_featured_hashtag_suggestion_widget.dart';
import 'package:fedi/app/ui/page/app_bar/fedi_page_title_app_bar.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccountFeaturedHashtagSuggestionPage extends StatelessWidget {
  const MyAccountFeaturedHashtagSuggestionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FediPageTitleAppBar(
        title: S.of(context).app_account_my_featuredTags_suggestions_title,
      ),
      body: const SafeArea(
        child: MyAccountFeaturedHashtagSuggestionWidget(),
      ),
    );
  }
}

MaterialPageRoute createMyAccountFeaturedHashtagSuggestionPageRoute() =>
    MaterialPageRoute(
      builder: (context) =>
          MyAccountFeaturedHashtagSuggestionBloc.provideToContext(
        context,
        child: const MyAccountFeaturedHashtagSuggestionPage(),
      ),
    );

void goToMyAccountFeaturedHashtagSuggestionPage(BuildContext context) {
  Navigator.push(
    context,
    createMyAccountFeaturedHashtagSuggestionPageRoute(),
  );
}
