import 'package:fedi/pleroma/rest/pleroma_rest_model.dart';

class PleromaFilterException extends PleromaRestException {
  PleromaFilterException({required int statusCode, required String body})
      : super(statusCode: statusCode, body: body);
}
