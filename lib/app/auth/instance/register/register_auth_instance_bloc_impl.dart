import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/app/auth/host/auth_host_bloc_impl.dart';
import 'package:fedi/app/auth/host/auth_host_model.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/auth/instance/register/form/register_auth_instance_form_bloc_impl.dart';
import 'package:fedi/app/auth/instance/register/register_auth_instance_bloc.dart';
import 'package:fedi/app/auth/oauth_last_launched/local_preferences/auth_oauth_last_launched_host_to_login_local_preference_bloc.dart';
import 'package:fedi/app/config/config_service.dart';
import 'package:fedi/app/localization/settings/localization_settings_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:fedi/connection/connection_service.dart';
import 'package:fedi/form/form_item_bloc.dart';
import 'package:fedi/local_preferences/local_preferences_service.dart';
import 'package:fedi/pleroma/api/captcha/pleroma_api_captcha_service.dart';
import 'package:fedi/pleroma/api/captcha/pleroma_api_captcha_service_impl.dart';
import 'package:fedi/pleroma/api/instance/pleroma_api_instance_model.dart';
import 'package:fedi/pleroma/api/instance/pleroma_api_instance_service.dart';
import 'package:fedi/pleroma/api/instance/pleroma_api_instance_service_impl.dart';
import 'package:fedi/pleroma/api/rest/pleroma_api_rest_service.dart';
import 'package:fedi/pleroma/api/rest/pleroma_api_rest_service_impl.dart';
import 'package:fedi/rest/rest_service.dart';
import 'package:fedi/rest/rest_service_impl.dart';
import 'package:logging/logging.dart';

final _logger = Logger('register_auth_instance_bloc_impl.dart');

class RegisterAuthInstanceBloc extends AsyncInitLoadingBloc
    implements IRegisterAuthInstanceBloc {
  @override
  final Uri instanceBaseUri;

  final ILocalPreferencesService localPreferencesService;
  final IConnectionService connectionService;
  final ICurrentAuthInstanceBloc currentInstanceBloc;
  final IAuthApiOAuthLastLaunchedHostToLoginLocalPreferenceBloc
  pleromaOAuthLastLaunchedHostToLoginLocalPreferenceBloc;
  final ILocalizationSettingsBloc localizationSettingsBloc;
  final IConfigService configService;

  // ignore: avoid-late-keyword
  late IPleromaApiInstance pleromaApiInstance;

  // ignore: avoid-late-keyword
  late IRestService restService;

  // ignore: avoid-late-keyword
  late IPleromaApiRestService pleromaRestService;

  // ignore: avoid-late-keyword
  late IPleromaApiCaptchaService pleromaApiCaptchaService;

  // ignore: avoid-late-keyword
  late IPleromaApiInstanceService pleromaInstanceService;

  @override
  // ignore: avoid-late-keyword
  late RegisterAuthInstanceFormBloc registerAuthInstanceFormBloc;

  RegisterAuthInstanceBloc({
    required this.instanceBaseUri,
    required this.localPreferencesService,
    required this.connectionService,
    required this.currentInstanceBloc,
    required this.pleromaOAuthLastLaunchedHostToLoginLocalPreferenceBloc,
    required this.localizationSettingsBloc,
    required this.configService,
  }) : super() {
    restService = RestService(baseUri: instanceBaseUri);
    pleromaRestService = PleromaApiRestService(
      connectionService: connectionService,
      restService: restService,
    );

    pleromaApiCaptchaService = PleromaApiCaptchaService(
      restService: pleromaRestService,
    );

    pleromaInstanceService =
        PleromaApiInstanceService(restService: pleromaRestService);

    registrationResultStreamController.disposeWith(this);
    restService.disposeWith(this);
    pleromaRestService.disposeWith(this);
    pleromaInstanceService.disposeWith(this);
  }

  @override
  Future<AuthHostRegistrationResult> submit() async {
    var pleromaAccountRegisterRequest =
    registerAuthInstanceFormBloc.calculateRegisterFormData();

    AuthHostRegistrationResult registrationResult;
    AuthHostBloc? authApplicationBloc;
    try {
      authApplicationBloc = AuthHostBloc(
        instanceBaseUri: instanceBaseUri,
        isPleroma: false,
        preferencesService: localPreferencesService,
        connectionService: connectionService,
        currentInstanceBloc: currentInstanceBloc,
        configService: configService,
        pleromaOAuthLastLaunchedHostToLoginLocalPreferenceBloc:
        pleromaOAuthLastLaunchedHostToLoginLocalPreferenceBloc,
      );
      await authApplicationBloc.performAsyncInit();

      registrationResult = await authApplicationBloc.registerAccount(
        request: pleromaAccountRegisterRequest,
      );
    } catch (e, stackTrace) {
      // todo: refactor
      _logger.warning(() => 'submit', e, stackTrace);
      registerAuthInstanceFormBloc.onRegisterFailed();
      rethrow;
    } finally {
      await authApplicationBloc?.dispose();
    }


    if (!registrationResult.isHaveNoErrors) {
      registerAuthInstanceFormBloc.onRegisterFailed();
    }

    // todo: rework when fail
    registrationResultStreamController.add(registrationResult);

    return registrationResult;
  }

  StreamController<AuthHostRegistrationResult>
  registrationResultStreamController = StreamController.broadcast();

  @override
  Stream<AuthHostRegistrationResult> get registrationResultStream =>
      registrationResultStreamController.stream;

  @override
  bool get isReadyToSubmit =>
      registerAuthInstanceFormBloc.isHaveChangesAndNoErrors;

  @override
  Stream<bool> get isReadyToSubmitStream =>
      registerAuthInstanceFormBloc.isHaveChangesAndNoErrorsStream;

  @override
  Future internalAsyncInit() async {
    pleromaApiInstance = await pleromaInstanceService.getInstance();

    registerAuthInstanceFormBloc = RegisterAuthInstanceFormBloc(
      pleromaApiInstance: pleromaApiInstance,
      pleromaApiCaptchaService: pleromaApiCaptchaService,
      instanceBaseUri: instanceBaseUri,
      // localizationSettingsBloc: localizationSettingsBloc,
      manualApprovalRequired: pleromaApiInstance.approvalRequired == true,
    )
      ..disposeWith(this);
  }
}
