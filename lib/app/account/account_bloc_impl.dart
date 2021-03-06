import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easy_dispose_rxdart/easy_dispose_rxdart.dart';

abstract class AccountBloc extends IAccountBloc {
  final BehaviorSubject<IAccount> accountSubject;

  final IPleromaApiAccountService? pleromaAccountService;

  // todo: remove hack. Dont init when bloc quickly disposed. Help
  AccountBloc({
    required this.pleromaAccountService,
    required IAccount account,
    required bool isNeedRefreshFromNetworkOnInit,
    required bool delayInit,
  }) : accountSubject = BehaviorSubject.seeded(account) {
    // _logger.finest(() => 'AccountBloc constructor ${account.remoteId}');
    accountSubject.disposeWith(this);


    if (delayInit) {
      Future.delayed(Duration(seconds: 1), () {
        _init(
          account: account,
          isNeedRefreshFromNetworkOnInit: isNeedRefreshFromNetworkOnInit,
        );
      });
    } else {
      _init(
        account: account,
        isNeedRefreshFromNetworkOnInit: isNeedRefreshFromNetworkOnInit,
      );
    }
  }

  void _init({
    required IAccount account,
    required bool isNeedRefreshFromNetworkOnInit,
  }) {
    if (!isDisposed) {
      actualInit(
        account: account,
        isNeedRefreshFromNetworkOnInit: isNeedRefreshFromNetworkOnInit,
      );
    }
  }

  Future actualInit({
    required IAccount account,
    required bool isNeedRefreshFromNetworkOnInit,
  });

  @override
  IAccount get account => accountSubject.value;

  @override
  Stream<IAccount> get accountStream => accountSubject.stream.distinct();

  Future<IPleromaApiAccount> loadRemoteAccount() async {
    return pleromaAccountService!.getAccount(
      accountRemoteId: account.remoteId,
      withRelationship: false,
    );
  }
}
