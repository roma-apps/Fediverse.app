import 'package:fedi/app/instance/instance_bloc.dart';
import 'package:fedi/app/instance/location/instance_location_bloc.dart';
import 'package:fedi/app/instance/public_timeline/instance_public_timeline_page_bloc.dart';
import 'package:fedi/app/timeline/local_preferences/timeline_local_preference_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InstancePublicTimelinePageBlocProxyProvider extends StatelessWidget {
  final Widget child;

  InstancePublicTimelinePageBlocProxyProvider({
    required this.child,
  });

  @override
  Widget build(BuildContext context) =>
      ProxyProvider<IInstancePublicTimelinePageBloc, IInstanceLocationBloc>(
        update: (context, bloc, previous) => bloc,
        child: ProxyProvider<IInstancePublicTimelinePageBloc, IInstanceBloc>(
          update: (context, bloc, previous) => bloc,
          child: ProxyProvider<IInstancePublicTimelinePageBloc,
              ITimelineLocalPreferenceBloc>(
            update: (context, bloc, previous) =>
                bloc.timelineLocalPreferenceBloc,
            child: child,
          ),
        ),
      );
}
