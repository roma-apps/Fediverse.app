import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/app/custom_list/accounts/custom_list_account_list_widget.dart';
import 'package:fedi/app/custom_list/form/custom_list_form_widget.dart';
import 'package:fedi/app/ui/button/icon/fedi_icon_button.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:fedi/app/ui/page/fedi_sub_page_title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateCustomListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FediSubPageTitleAppBar(
        title: "app.custom_list.create.title".tr(),
        actions: <Widget>[
          FediIconButton(
            icon: Icon(FediIcons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomListFormWidget(),
            CustomListAccountListWidget(),
          ],
        ),
      ),
    );
  }
}

void goToCreateCustomListPage({
  @required BuildContext context,
}) {
  Navigator.push(
    context,
    createCreateCustomListPageRoute(
      context: context,
    ),
  );
}

MaterialPageRoute createCreateCustomListPageRoute({
  @required BuildContext context,
}) {
  return MaterialPageRoute(builder: (context) => CreateCustomListPage());
}
