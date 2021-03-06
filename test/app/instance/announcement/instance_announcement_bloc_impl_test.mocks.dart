// Mocks generated by Mockito 5.0.10 from annotations
// in fedi/test/app/instance/announcement/instance_announcement_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:fedi/pleroma/api/announcement/pleroma_api_announcement_model.dart'
    as _i6;
import 'package:fedi/pleroma/api/announcement/pleroma_api_announcement_service.dart'
    as _i3;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i5;
import 'package:fedi/rest/rest_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIRestService extends _i1.Fake implements _i2.IRestService {}

/// A class which mocks [IPleromaApiAnnouncementService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPleromaApiAnnouncementService extends _i1.Mock
    implements _i3.IPleromaApiAnnouncementService {
  MockIPleromaApiAnnouncementService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i4.Stream<_i5.PleromaApiState> get pleromaApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiStateStream),
              returnValue: Stream<_i5.PleromaApiState>.empty())
          as _i4.Stream<_i5.PleromaApiState>);
  @override
  _i5.PleromaApiState get pleromaApiState =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiState),
          returnValue: _i5.PleromaApiState.validAuth) as _i5.PleromaApiState);
  @override
  _i4.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i4.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i4.Future<List<_i6.IPleromaApiAnnouncement>> getAnnouncements(
          {bool? withDismissed = false}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getAnnouncements, [], {#withDismissed: withDismissed}),
              returnValue: Future<List<_i6.IPleromaApiAnnouncement>>.value(
                  <_i6.IPleromaApiAnnouncement>[]))
          as _i4.Future<List<_i6.IPleromaApiAnnouncement>>);
  @override
  _i4.Future<dynamic> dismissAnnouncement({String? announcementId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #dismissAnnouncement, [], {#announcementId: announcementId}),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> addAnnouncementReaction(
          {String? announcementId, String? name}) =>
      (super.noSuchMethod(
          Invocation.method(#addAnnouncementReaction, [],
              {#announcementId: announcementId, #name: name}),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> removeAnnouncementReaction(
          {String? announcementId, String? name}) =>
      (super.noSuchMethod(
          Invocation.method(#removeAnnouncementReaction, [],
              {#announcementId: announcementId, #name: name}),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
}
