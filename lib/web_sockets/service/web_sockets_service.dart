import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_model.dart';
import 'package:fedi/web_sockets/web_sockets_model.dart';

abstract class IWebSocketsService extends IDisposable {
  IWebSocketsChannel<T>
      getOrCreateWebSocketsChannel<T extends WebSocketsEvent>({
    required IWebSocketsChannelConfig<T> config,
  });
}
