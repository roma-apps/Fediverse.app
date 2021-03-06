import 'package:fedi/app/hashtag/hashtag_model.dart';
import 'package:fedi/app/pagination/network_only/network_only_pleroma_pagination_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IHashtagNetworkOnlyPaginationBloc
    implements INetworkOnlyPleromaPaginationBloc<IHashtag> {
  static IHashtagNetworkOnlyPaginationBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IHashtagNetworkOnlyPaginationBloc>(context, listen: listen);
}
