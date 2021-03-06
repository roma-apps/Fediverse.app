import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/list/network_only/account_network_only_list_bloc.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IMyAccountAccountMuteNetworkOnlyAccountListBloc
    implements IDisposable, IAccountNetworkOnlyListBloc {
  static IMyAccountAccountMuteNetworkOnlyAccountListBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IMyAccountAccountMuteNetworkOnlyAccountListBloc>(
        context,
        listen: listen,
      );

  Future changeAccountMute({
    required IAccount? account,
    required bool notifications,
    required Duration? duration,
  });

  Future removeAccountMute({required IAccount? account});

  Future addAccountMute({required IAccount account});
}
