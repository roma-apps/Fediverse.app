import 'package:fedi/ui/scroll/nested_scroll_controller_bloc.dart';
import 'package:fedi/ui/scroll/scroll_controller_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NestedScrollControllerBlocProxyProvider extends StatelessWidget {
  final Widget child;

  NestedScrollControllerBlocProxyProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<INestedScrollControllerBloc, IScrollControllerBloc>(
      update: (context, value, previous) => value,
      child: child,
    );
  }
}
