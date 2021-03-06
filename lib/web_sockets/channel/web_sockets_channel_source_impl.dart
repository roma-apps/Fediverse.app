import 'dart:async';
import 'dart:convert';

import 'package:fedi/connection/connection_service.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_source.dart';
import 'package:fedi/web_sockets/web_sockets_model.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';

var _logger = Logger('web_sockets_channel_source_impl.dart');

class WebSocketsChannelSource<T extends WebSocketsEvent> extends DisposableOwner
    implements IWebSocketsChannelSource<T> {
  StreamController<T> eventsStreamController = StreamController.broadcast();

  @override
  Stream<T> get eventsStream => eventsStreamController.stream;
  @override
  final Uri url;
  final WebSocketsEventParser<T> eventParser;

  IOWebSocketChannel? _channel;
  StreamSubscription? _channelSubscription;

  WebSocketsChannelSource({
    required IConnectionService connectionService,
    required this.url,
    required this.eventParser,
  }) {
    addDisposable(CustomDisposable(() async {
      await _disconnect();
    }));
    if (connectionService.isConnected) {
      _connect();
    }

    connectionService.isConnectedStream.distinct().listen(
          (isConnected) {
        if (isConnected) {
          _connect();
        } else {
          _disconnect();
        }
      },
    ).disposeWith(this);
  }

  void _connect() {
    _logger.finest(() => '_connect ${_channel == null}');
    if (_channel == null) {
      _channel = IOWebSocketChannel.connect(url);
      _channelSubscription = _channel!.stream.listen(
        (dynamic message) {
          _logger.finest(() => '$url message $message');
          var event = _mapChannelData(message);
          if(event != null) {
            eventsStreamController.add(event);
          }
        },
        onDone: () {
          _logger.finest(() => 'ws channel closed $url');
        },
        onError: (error) {
          _logger.shout(() => 'ws error $error');
        },
      );
    }
  }

  Future _disconnect() async {
    _logger.finest(() => '_disconnect $url');
    await _channelSubscription?.cancel();
    await _channel?.sink.close();
    _channel = null;
  }

  T? _mapChannelData(data) {
    if (data is String) {
      if (data.isNotEmpty) {
        try {
          var json = jsonDecode(data);
          var event = eventParser(json);
          _logger.finest(() => '$url event $event');

          return event;
        } catch (e) {
          _logger.severe(
            () => '$url: failed to parse event from String($e): '
                '$data, ',
            e,
          );

          return null;
        }
      } else {
        return null;
      }
    } else {
      _logger.severe(() => '$url: failed to parse event from not String: '
          '$data');

      return null;
    }
  }
}
