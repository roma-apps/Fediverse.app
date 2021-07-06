// Mocks generated by Mockito 5.0.7 from annotations
// in fedi/test/app/filter/filter_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:fedi/pleroma/api/filter/pleroma_api_filter_model.dart' as _i3;
import 'package:fedi/pleroma/api/filter/pleroma_api_filter_service.dart' as _i4;
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i7;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i6;
import 'package:fedi/rest/rest_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeIRestService extends _i1.Fake implements _i2.IRestService {}

class _FakeIPleromaApiFilter extends _i1.Fake implements _i3.IPleromaApiFilter {
}

/// A class which mocks [IPleromaApiFilterService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPleromaApiFilterService extends _i1.Mock
    implements _i4.IPleromaApiFilterService {
  MockIPleromaApiFilterService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
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
          returnValue: Future<dynamic>.value(null)) as _i5.Future<dynamic>);
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
}
