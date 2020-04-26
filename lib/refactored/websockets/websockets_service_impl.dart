import 'package:fedi/refactored/disposable/disposable.dart';
import 'package:fedi/refactored/disposable/disposable_owner.dart';
import 'package:fedi/refactored/websockets/websockets_channel.dart';
import 'package:fedi/refactored/websockets/websockets_channel_impl.dart';
import 'package:fedi/refactored/websockets/websockets_channel_model.dart';
import 'package:fedi/refactored/websockets/websockets_model.dart';
import 'package:fedi/refactored/websockets/websockets_service.dart';
import 'package:flutter/widgets.dart';

class WebSocketsService extends DisposableOwner implements IWebSocketsService {
  @visibleForTesting
  final Map<Uri, IWebSocketsChannel> urlToChannel = Map();

  WebSocketsService() {
    addDisposable(disposable: CustomDisposable(() {
      urlToChannel.values.forEach((channel) => channel.dispose());
      urlToChannel.clear();
    }));
  }

  IWebSocketsChannel<T> getOrCreateWebSocketsChannel<T extends WebSocketsEvent>(
      {@required IWebSocketsChannelConfig<T> config}) {
    var url = config.calculateWebSocketsUrl();
    if (!urlToChannel.containsKey(url)) {
      urlToChannel[url] = createChannel<T>(config);
    }

    return urlToChannel[url];
  }

  IWebSocketsChannel createChannel<T extends WebSocketsEvent>(
          IWebSocketsChannelConfig<T> config) =>
      WebSocketsChannel<T>(config: config);
}
