import 'dart:convert';

import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_exception.dart';
import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_model.dart';
import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_service.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/pleroma/api/rest/auth/pleroma_api_auth_rest_service.dart';
import 'package:fedi/pleroma/api/status/pleroma_api_status_model.dart';
import 'package:fedi/rest/rest_request_model.dart';
import 'package:fedi/rest/rest_response_model.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

var urlPath = path.Context(style: path.Style.url);

var _logger = Logger("pleroma_api_my_account_service_impl.dart");

class PleromaApiMyAccountService extends DisposableOwner
    implements IPleromaApiMyAccountService {
  final verifyProfileRelativeUrlPath = "/api/v1/accounts/verify_credentials";
  final editProfileRelativeUrlPath = "/api/v1/accounts/update_credentials";
  @override
  final IPleromaApiAuthRestService restService;

  @override
  Stream<PleromaApiState> get pleromaApiStateStream =>
      restService.pleromaApiStateStream;

  @override
  PleromaApiState get pleromaApiState => restService.pleromaApiState;

  @override
  bool get isConnected => restService.isConnected;

  @override
  Stream<bool> get isConnectedStream => restService.isConnectedStream;

  PleromaApiMyAccountService({required this.restService});

  IPleromaApiMyAccount parseMyAccountResponse(Response httpResponse) {
    if (httpResponse.statusCode == RestResponse.successResponseStatusCode) {
      return PleromaApiMyAccount.fromJsonString(
        httpResponse.body,
      );
    } else {
      throw PleromaApiMyAccountException(
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  IPleromaApiAccountRelationship parseAccountRelationshipResponse(
    Response httpResponse,
  ) {
    if (httpResponse.statusCode == RestResponse.successResponseStatusCode) {
      return PleromaApiAccountRelationship.fromJsonString(httpResponse.body);
    } else {
      throw PleromaApiMyAccountException(
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  List<IPleromaApiStatus> parseStatusListResponse(Response httpResponse) {
    if (httpResponse.statusCode == RestResponse.successResponseStatusCode) {
      return PleromaApiStatus.listFromJsonString(httpResponse.body);
    } else {
      throw PleromaApiMyAccountException(
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  List<IPleromaApiAccount> parseAccountListResponse(Response httpResponse) {
    if (httpResponse.statusCode == RestResponse.successResponseStatusCode) {
      return PleromaApiAccount.listFromJsonString(httpResponse.body);
    } else {
      throw PleromaApiMyAccountException(
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  List<String> parseStringListResponse(Response httpResponse) {
    if (httpResponse.statusCode == RestResponse.successResponseStatusCode) {
      var result = <String>[];
      try {
        var list = json.decode(httpResponse.body) as List;
        list.forEach((element) {
          result.add(element.toString());
        });
      } catch (e, stackTrace) {
        _logger.severe(() => "failed to parse domain list", e, stackTrace);
      }
      return result;
    } else {
      throw PleromaApiMyAccountException(
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  @override
  Future<IPleromaApiMyAccount> updateCredentials(
    IPleromaApiMyAccountEdit data,
  ) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.patch(
        relativePath: editProfileRelativeUrlPath,
        bodyJson: data.toJson(),
      ),
    );

    return parseMyAccountResponse(httpResponse);
  }

  @override
  Future<IPleromaApiMyAccount> updateFiles(
    PleromaApiMyAccountFilesRequest accountFiles,
  ) async {
    _logger.finest(() => "updateFiles $accountFiles");
    var httpResponse = await restService.uploadFileMultipartRequest(
      UploadMultipartRestRequest.patch(
        relativePath: editProfileRelativeUrlPath,
        files: {
          if (accountFiles.header != null) "header": accountFiles.header!,
          if (accountFiles.avatar != null) "avatar": accountFiles.avatar!,
          if (accountFiles.pleromaBackgroundImage != null)
            "pleroma_background_image": accountFiles.pleromaBackgroundImage!,
        },
      ),
    );

    return parseMyAccountResponse(httpResponse);
  }

  @override
  Future<IPleromaApiMyAccount> verifyCredentials() async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(relativePath: verifyProfileRelativeUrlPath),
    );

    return parseMyAccountResponse(httpResponse);
  }

  @override
  Future<List<IPleromaApiStatus>> getBookmarks({
    IPleromaApiPaginationRequest? pagination,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(
        relativePath: urlPath.join("api/v1/bookmarks"),
        queryArgs: pagination?.toQueryArgs(),
      ),
    );

    return parseStatusListResponse(httpResponse);
  }

  @override
  Future<List<IPleromaApiStatus>> getFavourites({
    IPleromaApiPaginationRequest? pagination,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(
        relativePath: urlPath.join("api/v1/favourites"),
        queryArgs: pagination?.toQueryArgs(),
      ),
    );

    return parseStatusListResponse(httpResponse);
  }

  @override
  Future<List<IPleromaApiAccount>> getFollowRequests({
    IPleromaApiPaginationRequest? pagination,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(
        relativePath: urlPath.join("api/v1/follow_requests"),
        queryArgs: pagination?.toQueryArgs(),
      ),
    );

    return parseAccountListResponse(httpResponse);
  }

  @override
  Future dispose() async {
    return await super.dispose();
  }

  @override
  Future<IPleromaApiAccountRelationship> acceptFollowRequest({
    required String accountRemoteId,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.post(
        relativePath: urlPath.join(
          "api/v1/follow_requests",
          accountRemoteId,
          "authorize",
        ),
      ),
    );

    return parseAccountRelationshipResponse(httpResponse);
  }

  @override
  Future<IPleromaApiAccountRelationship> rejectFollowRequest({
    required String accountRemoteId,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.post(
        relativePath: urlPath.join(
          "api/v1/follow_requests",
          accountRemoteId,
          "reject",
        ),
      ),
    );

    return parseAccountRelationshipResponse(httpResponse);
  }

  @override
  Future<List<String>> getDomainBlocks({
    IPleromaApiPaginationRequest? pagination,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(
        relativePath: urlPath.join("api/v1/domain_blocks"),
        queryArgs: pagination?.toQueryArgs(),
      ),
    );

    return parseStringListResponse(httpResponse);
  }

  @override
  Future<List<IPleromaApiAccount>> getAccountBlocks({
    IPleromaApiPaginationRequest? pagination,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(
        relativePath: urlPath.join("api/v1/blocks"),
        queryArgs: pagination?.toQueryArgs(),
      ),
    );

    return parseAccountListResponse(httpResponse);
  }

  @override
  Future<List<IPleromaApiAccount>> getAccountMutes({
    IPleromaApiPaginationRequest? pagination,
  }) async {
    var httpResponse = await restService.sendHttpRequest(
      RestRequest.get(
        relativePath: urlPath.join("api/v1/mutes"),
        queryArgs: pagination?.toQueryArgs(),
      ),
    );

    return parseAccountListResponse(httpResponse);
  }
}