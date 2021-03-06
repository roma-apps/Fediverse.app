import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/status/list/status_list_bloc.dart';
import 'package:fedi/app/status/list/cached/status_cached_list_bloc.dart';
import 'package:fedi/app/list/cached/pleroma_cached_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class StatusCachedListBlocProxyProvider extends StatelessWidget {
  final Widget child;

  StatusCachedListBlocProxyProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<IStatusCachedListBloc,
        IPleromaCachedListBloc<IStatus?>>(
      update: (context, value, previous) => value,
      child: ProxyProvider<IStatusCachedListBloc, IStatusListBloc>(
        update: (context, value, previous) => value,
        child: child,
      ),
    );
  }
}
