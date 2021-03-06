import 'package:fedi/app/hashtag/hashtag_model.dart';
import 'package:fedi/app/hashtag/list/hashtag_list_bloc.dart';
import 'package:fedi/app/list/network_only/network_only_list_bloc.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IHashtagNetworkOnlyListBloc extends DisposableOwner
    implements INetworkOnlyListBloc<IHashtag>, IHashtagListBloc {
  static IHashtagNetworkOnlyListBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IHashtagNetworkOnlyListBloc>(context, listen: listen);

  @override
  IPleromaApi get pleromaApi;
}
