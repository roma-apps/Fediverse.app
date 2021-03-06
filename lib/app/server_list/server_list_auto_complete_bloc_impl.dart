import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/app/server_list/server_list_auto_complete_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_bloc_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class ServerListAutoCompleteBloc extends AsyncInitLoadingBloc
    implements IServerListAutoCompleteBloc {
  final BehaviorSubject<List<String>?> serversToAutoCompleteSubject =
      BehaviorSubject();

  @override
  List<String> get serversToAutoComplete =>
      serversToAutoCompleteSubject.valueOrNull ?? [];

  @override
  Stream<List<String>> get serversToAutoCompleteStream =>
      serversToAutoCompleteSubject.stream
          .map((serversToAutoComplete) => serversToAutoComplete ?? []);

  ServerListAutoCompleteBloc() {
    serversToAutoCompleteSubject.disposeWith(this);
  }

  @override
  Future internalAsyncInit() async {
    var list = await _loadServersList();
    serversToAutoCompleteSubject.add(list);
  }

  @override
  List<String> calculateServersSuggestionForTextInput(String textInput) {
    var preparedTextInput = textInput.toLowerCase().trim();

    var filtered = serversToAutoComplete
        .where(
          (server) => server.startsWith(preparedTextInput),
        )
        .toList();

    if (filtered.isEmpty) {
      filtered = serversToAutoComplete
          .where(
            (server) => server.contains(preparedTextInput),
          )
          .toList();
    }

    return filtered;
  }
}

Future<List<String>> _loadServersList() async {
  var fileAsString = await _loadAsset();

  var servers = fileAsString.split('\n');

  if(!kReleaseMode) {
    // debug instances
    servers = [
      'mastodon.jff.name',
      'pleroma.jff.name',
      ...servers,
    ];
  }

  return servers;
}

Future<String> _loadAsset() => rootBundle.loadString('assets/server_list.txt');
