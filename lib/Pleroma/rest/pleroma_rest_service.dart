import 'package:fedi/Pleroma/api/pleroma_api_service.dart';
import 'package:fedi/rest/rest_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IPleromaRestService implements IRestService, IPleromaApi {
  static IPleromaRestService of(BuildContext context, {listen: true}) =>
      Provider.of<IPleromaRestService>(context, listen: listen);
}
