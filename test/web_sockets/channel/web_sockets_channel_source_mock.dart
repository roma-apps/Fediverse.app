import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_source.dart';
import 'package:fedi/web_sockets/web_sockets_model.dart';

class WebSocketsChannelSourceMock<T extends WebSocketsEvent>
    extends DisposableOwner implements IWebSocketsChannelSource<T> {
  @override
  Stream<T> get eventsStream => _eventsStreamController.stream;
  final StreamController<T> _eventsStreamController =
      StreamController.broadcast();

  void addEvent(T event) {
    _eventsStreamController.add(event);
  }

  @override
  final Uri url;

  WebSocketsChannelSourceMock({
    required this.url,
  }) {
    addCustomDisposable(
      () => _eventsStreamController.close(),
    );
  }
}
