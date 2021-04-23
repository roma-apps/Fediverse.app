import 'dart:async';

import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/oauth/pleroma_api_oauth_exception.dart';
import 'package:fedi/pleroma/api/oauth/pleroma_api_oauth_model.dart';
import 'package:fedi/pleroma/api/oauth/pleroma_api_oauth_service.dart';
import 'package:fedi/pleroma/api/rest/pleroma_api_rest_service.dart';
import 'package:fedi/rest/rest_request_model.dart';
import 'package:fedi/rest/rest_response_model.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:uni_links2/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

var _logger = Logger("pleroma_api_oauth_service_impl.dart");

class PleromaApiOAuthService extends DisposableOwner
    implements IPleromaApiOAuthService {
  final oauthRelativeUrlPath = "/oauth/";
  @override
  final IPleromaApiRestService restService;

  @override
  Stream<PleromaApiState> get pleromaApiStateStream =>
      restService.pleromaApiStateStream;

  @override
  PleromaApiState get pleromaApiState => restService.pleromaApiState;

  @override
  bool get isConnected => restService.isConnected;

  @override
  Stream<bool> get isConnectedStream => restService.isConnectedStream;

  PleromaApiOAuthService({required this.restService});

  @override
  Future dispose() async {
    return super.dispose();
  }

  PleromaApiOAuthToken parseTokenResponse(Response httpResponse) {
    RestResponse<PleromaApiOAuthToken> restResponse = RestResponse.fromResponse(
      response: httpResponse,
      resultParser: (body) =>
          PleromaApiOAuthToken.fromJsonString(httpResponse.body),
    );

    if (restResponse.isSuccess) {
      return restResponse.body!;
    } else {
      throw PleromaApiOAuthException(
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  @override
  Future<String?> launchAuthorizeFormAndExtractAuthorizationCode({
    required PleromaApiOAuthAuthorizeRequest authorizeRequest,
  }) async {
    _logger.finest(() => "launchAuthorizeFormAndExtractAuthorizationCode");
    var host = restService.baseUri;
    var baseUrl = join(oauthRelativeUrlPath, "authorize");

    var keyValueMap = authorizeRequest.toJson();

    var queryArgs = keyValueMap.entries
        .map((entry) => "${entry.key}=${entry.value}")
        .join("&");

    queryArgs = queryArgs.replaceAll(" ", "%20");

    var url = "$host/$baseUrl?$queryArgs";
    var isCanLaunch = await canLaunch(url);

    _logger.finest(() => "launchAuthorizeFormAndExtractAuthorizationCode \n"
        "\t url = $url\n"
        "\t canLaunch=$isCanLaunch");

    var completer = Completer<String>();
    if (isCanLaunch) {
      late StreamSubscription<Uri?> subscription;
      subscription = uriLinkStream.listen(
        (Uri? uri) {
          subscription.cancel();
          closeWebView();
          var code = extractAuthCodeFromUri(uri!);
          completer.complete(code);
        },
        onError: (e) {
          subscription.cancel();
          closeWebView();
          completer.completeError(e);
        },
      );
      _logger.finest(() => "launch url=$url");
      await launch(url);
    } else {
      completer.completeError(PleromaOAuthCantLaunchException());
    }

    return completer.future;
  }

  String extractAuthCodeFromUri(Uri uri) =>
      uri.queryParameters['code'].toString();

  @override
  Future<PleromaApiOAuthToken> retrieveAccountAccessToken({
    required PleromaApiOAuthAccountTokenRequest tokenRequest,
  }) async {
    var queryArgs = tokenRequest
        .toJson()
        .entries
        .map(
          (entry) => RestRequestQueryArg(
            entry.key,
            entry.value,
          ),
        )
        .toList();

    var request = RestRequest.post(
      relativePath: join(oauthRelativeUrlPath, "token"), queryArgs: queryArgs,
//        bodyJson: tokenRequest.toJson()
    );
    var httpResponse = await restService.sendHttpRequest(request);

    return parseTokenResponse(httpResponse);
  }

  @override
  Future<PleromaApiOAuthToken?> retrieveAppAccessToken({
    required PleromaApiOAuthAppTokenRequest tokenRequest,
  }) async {
    var request = RestRequest.post(
      relativePath: join(oauthRelativeUrlPath, "token"),
      bodyJson: tokenRequest.toJson(),
    );
    var httpResponse = await restService.sendHttpRequest(request);

    return parseTokenResponse(httpResponse);
  }

  @override
  Future<bool> revokeToken({
    required PleromaApiOAuthAppTokenRevokeRequest revokeRequest,
  }) async {
    var request = RestRequest.post(
      relativePath: join(oauthRelativeUrlPath, "revoke"),
      bodyJson: revokeRequest.toJson(),
    );
    var httpResponse = await restService.sendHttpRequest(request);

    return httpResponse.statusCode == RestResponse.successResponseStatusCode;
  }
}