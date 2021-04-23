import 'package:fedi/mastodon/api/pagination/mastodon_api_pagination_model.dart';
import 'package:fedi/rest/rest_request_model.dart';

abstract class IPleromaApiPaginationRequest implements IMastodonApiPaginationRequest {
  List<RestRequestQueryArg> toQueryArgs();
}

class PleromaApiPaginationRequest implements IPleromaApiPaginationRequest {
  @override
  final int? limit;
  @override
  final String? maxId;
  @override
  final String? minId;
  @override
  final String? sinceId;

  PleromaApiPaginationRequest({
    this.limit,
    this.maxId,
    this.minId,
    this.sinceId,
  });

  @override
  List<RestRequestQueryArg> toQueryArgs() {
    return [
      if (minId != null) RestRequestQueryArg("min_id", minId),
      if (maxId != null) RestRequestQueryArg("max_id", maxId),
      if (sinceId != null) RestRequestQueryArg("since_id", sinceId),
      if (limit != null) RestRequestQueryArg("limit", limit.toString()),
    ];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaApiPaginationRequest &&
          runtimeType == other.runtimeType &&
          limit == other.limit &&
          maxId == other.maxId &&
          minId == other.minId &&
          sinceId == other.sinceId;

  @override
  int get hashCode =>
      limit.hashCode ^ maxId.hashCode ^ minId.hashCode ^ sinceId.hashCode;

  @override
  String toString() {
    return 'PleromaApiPaginationRequest{'
        'limit: $limit, '
        'maxId: $maxId, '
        'minId: $minId, '
        'sinceId: $sinceId'
        '}';
  }
}