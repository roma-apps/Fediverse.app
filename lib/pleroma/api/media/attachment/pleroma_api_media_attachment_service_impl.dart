import 'dart:io';

import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_exception.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_model.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_service.dart';
import 'package:fedi/pleroma/api/rest/auth/pleroma_api_auth_rest_service.dart';
import 'package:fedi/rest/rest_request_model.dart';
import 'package:fedi/rest/rest_response_model.dart';

class PleromaMediaAttachmentService extends DisposableOwner
    implements IPleromaMediaAttachmentService {
  @override
  final IPleromaApiAuthRestService restService;

  PleromaMediaAttachmentService({
    required this.restService,
  });

  @override
  Stream<PleromaApiState> get pleromaApiStateStream =>
      restService.pleromaApiStateStream;

  @override
  PleromaApiState get pleromaApiState => restService.pleromaApiState;

  @override
  bool get isConnected => restService.isConnected;

  @override
  Stream<bool> get isConnectedStream => restService.isConnectedStream;

  @override
  Future<PleromaApiMediaAttachment> uploadMedia({
    required File file,
  }) async {
    var httpResponse = await restService.uploadFileMultipartRequest(
      UploadMultipartRestRequest.post(
        relativePath: "/api/v1/media",
        files: {
          "file": file,
        },
      ),
    );

    if (httpResponse.statusCode == RestResponse.successResponseStatusCode) {
      return PleromaApiMediaAttachment.fromJsonString(httpResponse.body);
    } else {
      throw PleromaApiMediaAttachmentUploadException(
        file: file,
        statusCode: httpResponse.statusCode,
        body: httpResponse.body,
      );
    }
  }

  @override
  Future dispose() async {
    return await super.dispose();
  }
}