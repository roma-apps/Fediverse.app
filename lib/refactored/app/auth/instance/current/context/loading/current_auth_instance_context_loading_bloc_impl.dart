import 'package:fedi/refactored/app/account/my/my_account_bloc.dart';
import 'package:fedi/refactored/app/auth/instance/current/context/loading/current_auth_instance_context_loading_bloc.dart';
import 'package:fedi/refactored/app/auth/instance/current/context/loading/current_auth_instance_context_loading_model.dart';
import 'package:fedi/refactored/disposable/disposable_owner.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class CurrentAuthInstanceContextLoadingBloc extends DisposableOwner
    implements ICurrentAuthInstanceContextLoadingBloc {
  final IMyAccountBloc myAccountBloc;

  CurrentAuthInstanceContextLoadingBloc({@required this.myAccountBloc}) {
    refresh();
    addDisposable(subject: stateSubject);
  }

  void refresh() {
    stateSubject.add(
        CurrentAuthInstanceContextLoadingState.loading);
    myAccountBloc.requestRefreshFromNetwork().then((_) {
      if (myAccountBloc.isLocalCacheExist) {
        stateSubject.add(CurrentAuthInstanceContextLoadingState.localCacheExist);
      } else {
        stateSubject.add(
            CurrentAuthInstanceContextLoadingState.cantFetchAndLocalCacheNotExist);
      }
    });
  }

  // ignore: close_sinks
  BehaviorSubject<CurrentAuthInstanceContextLoadingState> stateSubject =
      BehaviorSubject.seeded(CurrentAuthInstanceContextLoadingState.loading);

  @override
  CurrentAuthInstanceContextLoadingState get state => stateSubject.value;

  @override
  Stream<CurrentAuthInstanceContextLoadingState> get stateStream =>
      stateSubject.stream;
}
