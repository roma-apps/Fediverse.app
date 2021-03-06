import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/oauth/pleroma_api_oauth_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef AuthorizationCodeSuccessCallback = dynamic Function(String code);
typedef AuthorizationCodeErrorCallback = dynamic Function(dynamic error);

abstract class IPleromaApiOAuthService extends IPleromaApi {
  static IPleromaApiOAuthService of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IPleromaApiOAuthService>(
        context,
        listen: listen,
      );

  Future<String?> launchAuthorizeFormAndExtractAuthorizationCode({
    required PleromaApiOAuthAuthorizeRequest authorizeRequest,
  });

  static String extractAuthCodeFromUri(Uri uri) =>
      uri.queryParameters['code'].toString();

  Future<PleromaApiOAuthToken> retrieveAccountAccessToken({
    required PleromaApiOAuthAccountTokenRequest tokenRequest,
  });

  Future<PleromaApiOAuthToken> retrieveAppAccessToken({
    required PleromaApiOAuthAppTokenRequest tokenRequest,
  });

  Future revokeToken({
    required PleromaApiOAuthAppTokenRevokeRequest revokeRequest,
  });
}
