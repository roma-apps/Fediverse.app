import 'package:fedi/local_preferences/local_preference_bloc_impl.dart';
import 'package:fedi/pleroma/api/application/pleroma_api_application_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IAuthHostApplicationLocalPreferenceBloc
    implements LocalPreferenceBloc<PleromaApiClientApplication?> {
  static IAuthHostApplicationLocalPreferenceBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IAuthHostApplicationLocalPreferenceBloc>(
        context,
        listen: listen,
      );
}
