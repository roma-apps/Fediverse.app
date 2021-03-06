import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/ui/theme/ui_theme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FediUiThemeProxyProvider extends StatelessWidget {
  final Widget child;

  FediUiThemeProxyProvider({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => ProxyProvider<IFediUiTheme, IUiTheme>(
        update: (context, value, previous) => value,
        child: ProxyProvider<IFediUiTheme, IFediUiColorTheme>(
          update: (context, value, previous) => value.colorTheme,
          child: ProxyProvider<IFediUiTheme, IFediUiTextTheme>(
            update: (context, value, previous) => value.textTheme,
            child: child,
          ),
        ),
      );
}
