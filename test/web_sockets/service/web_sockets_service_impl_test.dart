import 'package:fedi/connection/connection_service_impl.dart';
import 'package:fedi/web_sockets/handling_type/web_sockets_handling_type_model.dart';
import 'package:fedi/web_sockets/service/config/web_sockets_service_config_bloc_impl.dart';
import 'package:fedi/web_sockets/service/web_sockets_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../channel/web_sockets_channel_model_test_impl.dart';
import '../channel/web_sockets_channel_source_mock.dart';
import '../service/web_sockets_service_impl_test.mocks.dart';
import '../websockets_model_test_impl.dart';

// ignore_for_file: no-magic-number, avoid-late-keyword
@GenerateMocks([
  ConnectionService,
])
void main() {
  late WebSocketsService webSocketsService;

  late MockConnectionService connectionServiceMock;
  setUp(() {
    connectionServiceMock = MockConnectionService();

    webSocketsService = WebSocketsService(
      configBloc: WebSocketsServiceConfigBloc(
        WebSocketsHandlingType.foregroundAndBackground,
      ),
    );
  });

  tearDown(() {
    webSocketsService.dispose();
  });

  test('getOrCreateWebSocketsChannel', () {
    webSocketsService.getOrCreateWebSocketsChannel(
      config: WebSocketsChannelConfigTest(
        queryArgs: {'arg': 'value'},
        baseUrl: Uri.parse('wss://fedi.app'),
        connectionService: connectionServiceMock,
        sourceCreator: () => WebSocketsChannelSourceMock<WebSocketEventTest>(
          url: Uri.parse(
            'wss://fedi1.app?arg=value',
          ),
        ),
      ),
    );
    expect(webSocketsService.urlToChannel.length, 1);

    // same
    webSocketsService.getOrCreateWebSocketsChannel(
      config: WebSocketsChannelConfigTest(
        queryArgs: {'arg': 'value'},
        baseUrl: Uri.parse(
          'wss://fedi.app',
        ),
        connectionService: connectionServiceMock,
        sourceCreator: () => WebSocketsChannelSourceMock<WebSocketEventTest>(
          url: Uri.parse(
            'wss://fedi1.app?arg=value',
          ),
        ),
      ),
    );

    expect(webSocketsService.urlToChannel.length, 1);
    // diff query arg
    webSocketsService.getOrCreateWebSocketsChannel(
      config: WebSocketsChannelConfigTest(
        queryArgs: {'arg': 'newValue'},
        baseUrl: Uri.parse('wss://fedi.app'),
        connectionService: connectionServiceMock,
        sourceCreator: () => WebSocketsChannelSourceMock<WebSocketEventTest>(
          url: Uri.parse(
            'wss://fedi1.app?arg=value',
          ),
        ),
      ),
    );

    expect(webSocketsService.urlToChannel.length, 2);

    // diff baseUrl
    webSocketsService.getOrCreateWebSocketsChannel(
      config: WebSocketsChannelConfigTest(
        queryArgs: {'arg': 'newValue'},
        baseUrl: Uri.parse('wss://fedi_2.app'),
        connectionService: connectionServiceMock,
        sourceCreator: () => WebSocketsChannelSourceMock<WebSocketEventTest>(
          url: Uri.parse(
            'wss://fedi1.app?arg=value',
          ),
        ),
      ),
    );

    expect(webSocketsService.urlToChannel.length, 3);
  });
}
