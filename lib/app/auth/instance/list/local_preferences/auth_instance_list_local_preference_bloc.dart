import 'package:fedi/app/auth/instance/list/auth_instance_list_model.dart';
import 'package:fedi/local_preferences/local_preference_bloc_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IAuthInstanceListLocalPreferenceBloc
    implements LocalPreferenceBloc<AuthInstanceList?> {
  static IAuthInstanceListLocalPreferenceBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IAuthInstanceListLocalPreferenceBloc>(
        context,
        listen: listen,
      );
}
