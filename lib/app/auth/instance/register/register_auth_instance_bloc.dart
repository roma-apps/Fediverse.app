import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/app/auth/host/auth_host_model.dart';
import 'package:fedi/app/auth/instance/register/form/register_auth_instance_form_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IRegisterAuthInstanceBloc
    implements IDisposable, IAsyncInitLoadingBloc {
  static IRegisterAuthInstanceBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IRegisterAuthInstanceBloc>(
        context,
        listen: listen,
      );

  Uri get instanceBaseUri;

  bool get isReadyToSubmit;

  Stream<bool> get isReadyToSubmitStream;

  IRegisterAuthInstanceFormBloc get registerAuthInstanceFormBloc;

  Stream<AuthHostRegistrationResult> get registrationResultStream;

  Future<AuthHostRegistrationResult> submit();
}
