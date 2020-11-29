import 'package:fedi/web_sockets/channel/web_sockets_channel_impl.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_model.dart';
import 'package:fedi/web_sockets/handling_type/web_sockets_handling_type_model.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:fedi/web_sockets/service/config/web_sockets_service_config_bloc_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'websockets_channel_config_mock.dart';
import 'websockets_channel_source_mock.dart';
import 'websockets_model_helper.dart';

void main() {
  WebSocketsChannelConfigMock<TestWebSocketEvent> config;
  WebSocketsChannel<TestWebSocketEvent> channel;
  WebSocketsChannelSourceMock<TestWebSocketEvent> source;
  setUp(() {
    config = WebSocketsChannelConfigMock();
    source = WebSocketsChannelSourceMock<TestWebSocketEvent>(
        url: Uri.parse("wss://fedi1"
            ".app?arg=value"));
    when(config.createChannelSource()).thenReturn(source);
    channel = WebSocketsChannel<TestWebSocketEvent>(
      config: config,
      serviceConfigBloc: WebSocketsServiceConfigBloc(
        WebSocketsHandlingType.foregroundAndBackground,
      ),
    );
  });
  tearDown(() {
    channel.dispose();
  });

  test('config', () {
    expect(channel.config, config);
  });

  test('eventsStream', () async {
    var event1 = TestWebSocketEvent("test1");
    var event2 = TestWebSocketEvent("test2");

    var listenedValue1;
    var listenedValue2;
    var subscriptionDisposable1 = channel.listenForEvents(
      listener: WebSocketChannelListener<TestWebSocketEvent>(
        listenType: WebSocketsListenType.foreground,
        onEvent: (value) {
          listenedValue1 = value;
        },
      ),
    );

    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(listenedValue1, null);

    source.addEvent(event1);
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue1, event1);
    var subscriptionDisposable2 = channel.listenForEvents(
      listener: WebSocketChannelListener<TestWebSocketEvent>(
        listenType: WebSocketsListenType.foreground,
        onEvent: (value) {
          listenedValue2 = value;
        },
      ),
    );
    expect(listenedValue2, null);

    source.addEvent(event2);
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue1, event2);
    expect(listenedValue2, event2);

    await subscriptionDisposable1.dispose();

    source.addEvent(event1);
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue1, event2);
    expect(listenedValue2, event1);

    await subscriptionDisposable2.dispose();
  });
}
