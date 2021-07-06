// Mocks generated by Mockito 5.0.7 from annotations
// in fedi/test/web_sockets/service/web_sockets_service_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:connectivity/connectivity.dart' as _i2;
import 'package:connectivity_platform_interface/src/enums.dart' as _i5;
import 'package:easy_dispose/src/composite_disposable.dart' as _i7;
import 'package:easy_dispose/src/disposable.dart' as _i8;
import 'package:fedi/async/loading/async_loading_service_impl.dart' as _i9;
import 'package:fedi/async/loading/init/async_init_loading_model.dart' as _i6;
import 'package:fedi/connection/connection_service_impl.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

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
  set initLoadingException(dynamic _initLoadingException) => super.noSuchMethod(
      Invocation.setter(#initLoadingException, _initLoadingException),
      returnValueForMissingStub: null);
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
  _i7.DisposeOrder get disposeOrder =>
      (super.noSuchMethod(Invocation.getter(#disposeOrder),
          returnValue: _i7.DisposeOrder.lifo) as _i7.DisposeOrder);
  @override
  bool get catchExceptions => (super
          .noSuchMethod(Invocation.getter(#catchExceptions), returnValue: false)
      as bool);
  @override
  List<_i8.IDisposable> get disposables =>
      (super.noSuchMethod(Invocation.getter(#disposables),
          returnValue: <_i8.IDisposable>[]) as List<_i8.IDisposable>);
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
          returnValue: Future<dynamic>.value(null)) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> performAsyncInit() =>
      (super.noSuchMethod(Invocation.method(#performAsyncInit, []),
          returnValue: Future<dynamic>.value(null)) as _i4.Future<dynamic>);
  @override
  void markAsAlreadyInitialized() =>
      super.noSuchMethod(Invocation.method(#markAsAlreadyInitialized, []),
          returnValueForMissingStub: null);
  @override
  _i4.Future<dynamic> performLoading(_i9.LoadingFunction? loadingFunction) =>
      (super.noSuchMethod(Invocation.method(#performLoading, [loadingFunction]),
          returnValue: Future<dynamic>.value(null)) as _i4.Future<dynamic>);
  @override
  void addDisposable(_i8.IDisposable? disposable) =>
      super.noSuchMethod(Invocation.method(#addDisposable, [disposable]),
          returnValueForMissingStub: null);
  @override
  void addDisposables(Iterable<_i8.IDisposable>? disposables) =>
      super.noSuchMethod(Invocation.method(#addDisposables, [disposables]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<dynamic> performDispose() =>
      (super.noSuchMethod(Invocation.method(#performDispose, []),
          returnValue: Future<dynamic>.value(null)) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value(null)) as _i4.Future<dynamic>);
}
