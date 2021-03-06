import 'package:fedi/app/instance/app_bar/instance_host_app_bar_widget.dart';
import 'package:fedi/app/instance/activity/instance_activity_widget.dart';
import 'package:fedi/app/instance/activity/local/local_instance_activity_bloc_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalInstanceActivityPage extends StatelessWidget {
  const LocalInstanceActivityPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InstanceHostAppBarWidget(),
      body: const SafeArea(
        child: InstanceActivityWidget(),
      ),
    );
  }
}

MaterialPageRoute createLocalInstanceActivityPageRoute() => MaterialPageRoute(
      builder: (context) => LocalInstanceActivityBloc.provideToContext(
        context,
        child: const LocalInstanceActivityPage(),
      ),
    );

void goToLocalInstanceActivityPage(BuildContext context) {
  Navigator.push(
    context,
    createLocalInstanceActivityPageRoute(),
  );
}
