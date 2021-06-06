// Mocks generated by Mockito 5.0.9 from annotations
// in fedi/test/app/filter/filter_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:fedi/disposable/disposable.dart' as _i8;
import 'package:fedi/pleroma/api/filter/pleroma_api_filter_model.dart' as _i3;
import 'package:fedi/pleroma/api/filter/pleroma_api_filter_service_impl.dart'
    as _i4;
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i7;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i6;
import 'package:fedi/pleroma/api/rest/auth/pleroma_api_auth_rest_service.dart'
    as _i2;
import 'package:flutter/src/widgets/editable_text.dart' as _i9;
import 'package:flutter/src/widgets/focus_manager.dart' as _i11;
import 'package:flutter/src/widgets/scroll_controller.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/subject.dart' as _i12;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIPleromaApiAuthRestService extends _i1.Fake
    implements _i2.IPleromaApiAuthRestService {}

class _FakeIPleromaApiFilter extends _i1.Fake implements _i3.IPleromaApiFilter {
}

/// A class which mocks [PleromaApiFilterService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaApiFilterService extends _i1.Mock
    implements _i4.PleromaApiFilterService {
  MockPleromaApiFilterService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get filterRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#filterRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i2.IPleromaApiAuthRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
              returnValue: _FakeIPleromaApiAuthRestService())
          as _i2.IPleromaApiAuthRestService);
  @override
  _i2.IPleromaApiAuthRestService get restApiAuthService =>
      (super.noSuchMethod(Invocation.getter(#restApiAuthService),
              returnValue: _FakeIPleromaApiAuthRestService())
          as _i2.IPleromaApiAuthRestService);
  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  _i5.Stream<_i6.PleromaApiState> get pleromaApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiStateStream),
              returnValue: Stream<_i6.PleromaApiState>.empty())
          as _i5.Stream<_i6.PleromaApiState>);
  @override
  _i6.PleromaApiState get pleromaApiState =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiState),
          returnValue: _i6.PleromaApiState.validAuth) as _i6.PleromaApiState);
  @override
  _i5.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i5.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i5.Future<List<_i3.IPleromaApiFilter>> getFilters(
          {_i7.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getFilters, [], {#pagination: pagination}),
              returnValue: Future<List<_i3.IPleromaApiFilter>>.value(
                  <_i3.IPleromaApiFilter>[]))
          as _i5.Future<List<_i3.IPleromaApiFilter>>);
  @override
  _i5.Future<_i3.IPleromaApiFilter> getFilter({String? filterRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(#getFilter, [], {#filterRemoteId: filterRemoteId}),
          returnValue: Future<_i3.IPleromaApiFilter>.value(
              _FakeIPleromaApiFilter())) as _i5.Future<_i3.IPleromaApiFilter>);
  @override
  _i5.Future<dynamic> deleteFilter({String? filterRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #deleteFilter, [], {#filterRemoteId: filterRemoteId}),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<_i3.IPleromaApiFilter> createFilter(
          {_i3.IPostPleromaApiFilter? postPleromaFilter}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #createFilter, [], {#postPleromaFilter: postPleromaFilter}),
              returnValue:
                  Future<_i3.IPleromaApiFilter>.value(_FakeIPleromaApiFilter()))
          as _i5.Future<_i3.IPleromaApiFilter>);
  @override
  _i5.Future<_i3.IPleromaApiFilter> updateFilter(
          {String? filterRemoteId,
          _i3.IPostPleromaApiFilter? postPleromaFilter}) =>
      (super.noSuchMethod(
              Invocation.method(#updateFilter, [], {
                #filterRemoteId: filterRemoteId,
                #postPleromaFilter: postPleromaFilter
              }),
              returnValue:
                  Future<_i3.IPleromaApiFilter>.value(_FakeIPleromaApiFilter()))
          as _i5.Future<_i3.IPleromaApiFilter>);
  @override
  _i5.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  void addDisposable(
          {_i8.IDisposable? disposable,
          _i5.StreamSubscription<dynamic>? streamSubscription,
          _i9.TextEditingController? textEditingController,
          _i10.ScrollController? scrollController,
          _i11.FocusNode? focusNode,
          _i12.Subject<dynamic>? subject,
          _i5.StreamController<dynamic>? streamController,
          _i5.Timer? timer,
          _i5.FutureOr<dynamic>? Function()? custom}) =>
      super.noSuchMethod(
          Invocation.method(#addDisposable, [], {
            #disposable: disposable,
            #streamSubscription: streamSubscription,
            #textEditingController: textEditingController,
            #scrollController: scrollController,
            #focusNode: focusNode,
            #subject: subject,
            #streamController: streamController,
            #timer: timer,
            #custom: custom
          }),
          returnValueForMissingStub: null);
}
