// Mocks generated by Mockito 5.0.0-nullsafety.7 from annotations
// in fedi/test/websockets/websockets_service_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:connectivity/connectivity.dart' as _i2;
import 'package:connectivity_platform_interface/src/enums.dart' as _i5;
import 'package:fedi/async/loading/async_loading_service_impl.dart' as _i7;
import 'package:fedi/async/loading/init/async_init_loading_model.dart' as _i6;
import 'package:fedi/connection/connection_service_impl.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeConnectivity extends _i1.Fake implements _i2.Connectivity {}

/// A class which mocks [ConnectionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockConnectionService extends _i1.Mock implements _i3.ConnectionService {
  MockConnectionService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Connectivity get connectivity =>
      (super.noSuchMethod(Invocation.getter(#connectivity),
          returnValue: _FakeConnectivity()) as _i2.Connectivity);
  @override
  set connectivity(_i2.Connectivity? _connectivity) =>
      super.noSuchMethod(Invocation.setter(#connectivity, _connectivity),
          returnValueForMissingStub: null);
  @override
  _i4.Stream<_i5.ConnectivityResult> get connectionStateStream =>
      (super.noSuchMethod(Invocation.getter(#connectionStateStream),
              returnValue: Stream<_i5.ConnectivityResult>.empty())
          as _i4.Stream<_i5.ConnectivityResult>);
  @override
  _i4.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i4.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  _i4.Stream<_i6.AsyncInitLoadingState> get initLoadingStateStream =>
      (super.noSuchMethod(Invocation.getter(#initLoadingStateStream),
              returnValue: Stream<_i6.AsyncInitLoadingState>.empty())
          as _i4.Stream<_i6.AsyncInitLoadingState>);
  @override
  _i6.AsyncInitLoadingState get initLoadingState =>
      (super.noSuchMethod(Invocation.getter(#initLoadingState),
              returnValue: _i6.AsyncInitLoadingState.notStarted)
          as _i6.AsyncInitLoadingState);
  @override
  bool get isInitLoadingStateFinished =>
      (super.noSuchMethod(Invocation.getter(#isInitLoadingStateFinished),
          returnValue: false) as bool);
  @override
  _i4.Stream<bool> get isLoadingStream =>
      (super.noSuchMethod(Invocation.getter(#isLoadingStream),
          returnValue: Stream<bool>.empty()) as _i4.Stream<bool>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i4.Future<dynamic> internalAsyncInit() =>
      (super.noSuchMethod(Invocation.method(#internalAsyncInit, []),
          returnValue: Future.value(null)) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> performAsyncInit() =>
      (super.noSuchMethod(Invocation.method(#performAsyncInit, []),
          returnValue: Future.value(null)) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> performLoading(_i7.LoadingFunction? loadingFunction) =>
      (super.noSuchMethod(Invocation.method(#performLoading, [loadingFunction]),
          returnValue: Future.value(null)) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future.value(null)) as _i4.Future<dynamic>);
}
