import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/settings/instance/instance_settings_widget.dart';
import 'package:fedi/app/ui/page/fedi_sub_page_title_app_bar.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstanceSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentAuthInstanceBloc = ICurrentAuthInstanceBloc.of(context);
    var currentInstance = currentAuthInstanceBloc.currentInstance;
    return Scaffold(
      appBar: FediSubPageTitleAppBar(
        title: S.of(context).app_account_home_tab_menu_action_instance_settings(
              currentInstance.userAtHost,
            ),
      ),
      body: const _InstanceSettingsBody(),
    );
  }

  const InstanceSettingsPage();
}

class _InstanceSettingsBody extends StatelessWidget {
  const _InstanceSettingsBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const InstanceSettingsWidget(),
      ],
    );
  }
}

void goToInstanceSettingsPage(BuildContext context) {
  Navigator.push(
    context,
    createInstanceSettingsPageRoute(),
  );
}

MaterialPageRoute createInstanceSettingsPageRoute() {
  return MaterialPageRoute(
    builder: (context) => const InstanceSettingsPage(),
  );
}