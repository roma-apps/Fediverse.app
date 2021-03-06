import 'dart:async';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_model.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_source.dart';
import 'package:fedi/web_sockets/handling_type/web_sockets_handling_type_model.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:fedi/web_sockets/service/config/web_sockets_service_config_bloc.dart';
import 'package:fedi/web_sockets/web_sockets_model.dart';
import 'package:logging/logging.dart';

var _logger = Logger('web_sockets_channel_impl.dart');

class WebSocketsChannel<T extends WebSocketsEvent> extends DisposableOwner
    implements IWebSocketsChannel<T> {
  @override
  final IWebSocketsChannelConfig<T> config;
  final IWebSocketsServiceConfigBloc serviceConfigBloc;
  final List<WebSocketChannelListener<T>> listeners = [];

  IWebSocketsChannelSource? _source;
  StreamSubscription? _sourceSubscription;

  WebSocketsHandlingType? handlingType;

  WebSocketsChannel({
    required this.config,
    required this.serviceConfigBloc,
  }) {
    _logger.finest(() => 'constructor $config');

    handlingType = serviceConfigBloc.handlingType;

    serviceConfigBloc.handlingTypeStream.listen(
      (handlingType) {
        this.handlingType = handlingType;
        _recheckSubscription();
      },
    ).disposeWith(this);

    addCustomDisposable(
      () async {
        await _source?.dispose();
        await _sourceSubscription?.cancel();
      },
    );
  }

  bool listening = false;

  void _onCancel() {
    listening = false;
    _logger.finest(() => '_onCancel');
    _source?.dispose();
    _sourceSubscription?.cancel();
    _source = null;
    _sourceSubscription = null;
  }

  void _onListen() {
    listening = true;
    _logger.finest(() => '_onListen called');
    _source = config.createChannelSource();
    var eventsStream = _source!.eventsStream;
    _sourceSubscription = eventsStream.listen(
      (event) {
        _logger.finest(() => 'newEvent event');
        listeners.forEach(
          (listener) {
            // todo: think about cast
            listener.onEvent(event! as T);
          },
        );
      },
    );
  }

  @override
  IDisposable listenForEvents({
    required WebSocketChannelListener<T> listener,
  }) {
    _logger.finest(() => 'listenForEvents');
    listeners.add(listener);
    _recheckSubscription();

    return CustomDisposable(
      () {
        listeners.remove(listener);
        _recheckSubscription();
      },
    );
  }

  final bool isListening = false;

  void _recheckSubscription() {
    bool isNeedListen;

    var isHaveForegroundListeners = false;
    var isHaveBackgroundListeners = false;

    if (handlingType == WebSocketsHandlingType.disabled) {
      isNeedListen = false;
    } else {
      for (var listener in listeners) {
        switch (listener.listenType) {
          case WebSocketsListenType.background:
            isHaveBackgroundListeners = true;
            break;
          case WebSocketsListenType.foreground:
            isHaveForegroundListeners = true;
            break;
        }
        if (isHaveForegroundListeners) {
          break;
        }
      }

      if (isHaveForegroundListeners) {
        isNeedListen = true;
      } else {
        if (isHaveBackgroundListeners &&
            handlingType == WebSocketsHandlingType.foregroundAndBackground) {
          isNeedListen = true;
        } else {
          isNeedListen = false;
        }
      }
    }

    _logger.finest(() => '_recheckSubscription \n'
        'handlingType $handlingType \n'
        'isNeedListen $isNeedListen \n'
        'listening $listening \n');

    if (isNeedListen && !listening) {
      _onListen();
    } else if (!isNeedListen && listening) {
      _onCancel();
    }
  }
}
