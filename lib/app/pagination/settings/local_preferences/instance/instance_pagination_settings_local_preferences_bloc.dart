import 'package:fedi/app/pagination/settings/local_preferences/pagination_settings_local_preferences_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IInstancePaginationSettingsLocalPreferencesBloc
    implements IPaginationSettingsLocalPreferencesBloc {
  static IInstancePaginationSettingsLocalPreferencesBloc of(BuildContext context,
      {bool listen = true}) =>
      Provider.of<IInstancePaginationSettingsLocalPreferencesBloc>(context,
          listen: listen);
}