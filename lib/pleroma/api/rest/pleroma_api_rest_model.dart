import 'dart:convert';

import 'package:logging/logging.dart';

var _logger = Logger('pleroma_rest_exception.dart');

abstract class PleromaApiException implements Exception {
  String get exceptionType;

  @override
  String toString() {
    return '$exceptionType{' '}';
  }
}

abstract class PleromaApiRestException implements PleromaApiException {
  static const jsonBodyErrorKey = 'error';

  final int statusCode;
  final String body;

  String? decodedErrorDescription;

  String get decodedErrorDescriptionOrBody => decodedErrorDescription ?? body;

  PleromaApiRestException({
    required this.statusCode,
    required this.body,
  }) {
    try {
      var jsonBody = jsonDecode(body);
      decodedErrorDescription = jsonBody[jsonBodyErrorKey];
    } catch (e, stackTrace) {
      _logger.warning(
        () => 'error during parse error from API response',
        e,
        stackTrace,
      );
    }
  }

  @override
  String toString() {
    return '$exceptionType{'
        'statusCode: $statusCode, '
        'decodedErrorDescriptionOrBody: $decodedErrorDescriptionOrBody, '
        'body: $body ,'
        '}';
  }
}

class PleromaApiOAuthCantLaunchException extends PleromaApiException {
  PleromaApiOAuthCantLaunchException() : super();

  @override
  String get exceptionType => 'PleromaOAuthCantLaunchException';
}

class PleromaApiUnprocessableOrThrottledRestException
    extends PleromaApiRestException {
  static const int httpStatusCode = 429;

  PleromaApiUnprocessableOrThrottledRestException({
    required int statusCode,
    required String body,
  }) : super(statusCode: statusCode, body: body);

  @override
  String get exceptionType =>
      'PleromaApiUnprocessableOrThrottledRestException{}';
}

class PleromaApiForbiddenRestException extends PleromaApiRestException {
  static const int httpStatusCode = 403;

  PleromaApiForbiddenRestException({
    required int statusCode,
    required String body,
  }) : super(
          statusCode: statusCode,
          body: body,
        );

  @override
  String get exceptionType => 'PleromaApiForbiddenRestException{}';
}

class PleromaApiUnknownRestException extends PleromaApiRestException {
  PleromaApiUnknownRestException({
    required int statusCode,
    required String body,
  }) : super(
          statusCode: statusCode,
          body: body,
        );

  @override
  String get exceptionType => 'PleromaApiUnknownRestException{}';
}

class PleromaApiNotJsonResponseRestException extends PleromaApiRestException {
  PleromaApiNotJsonResponseRestException({
    required int statusCode,
    required String body,
  }) : super(
          statusCode: statusCode,
          body: body,
        );

  @override
  String get exceptionType => 'PleromaApiNotJsonResponseRestException{}';
}

class PleromaApiNotJsonListResponseRestException
    extends PleromaApiRestException {
  PleromaApiNotJsonListResponseRestException({
    required int statusCode,
    required String body,
  }) : super(
          statusCode: statusCode,
          body: body,
        );

  @override
  String get exceptionType => 'PleromaApiNotJsonListResponseRestException{}';
}

class PleromaApiInvalidCredentialsForbiddenRestException
    extends PleromaApiRestException {
  static const pleromaErrorValue = 'Invalid credentials.';
  static const pleromaStatusCode = 403;

  static const mastodonStatusCode = 401;
  static const mastodonErrorValue = 'The access token was revoked';

  PleromaApiInvalidCredentialsForbiddenRestException({
    required int statusCode,
    required String body,
  }) : super(
          statusCode: statusCode,
          body: body,
        );

  @override
  String get exceptionType =>
      'PleromaApiInvalidCredentialsForbiddenRestException{}';
}

class PleromaApiRecordNotFoundRestException extends PleromaApiRestException {
  static const pleromaErrorValue = 'Record not found';
  static const pleromaStatusCode = 404;

  PleromaApiRecordNotFoundRestException({
    required int statusCode,
    required String body,
  }) : super(
          statusCode: statusCode,
          body: body,
        );

  @override
  String get exceptionType => 'PleromaApiRecordNotFoundRestException{}';
}
