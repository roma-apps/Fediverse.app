// Mocks generated by Mockito 5.0.10 from annotations
// in fedi/test/app/conversation/conversation_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;

import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_model.dart'
    as _i6;
import 'package:fedi/pleroma/api/account/my/pleroma_api_my_account_service.dart'
    as _i13;
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart' as _i7;
import 'package:fedi/pleroma/api/conversation/pleroma_api_conversation_model.dart'
    as _i3;
import 'package:fedi/pleroma/api/conversation/pleroma_api_conversation_service.dart'
    as _i8;
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i11;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i10;
import 'package:fedi/pleroma/api/status/auth/pleroma_api_auth_status_service.dart'
    as _i12;
import 'package:fedi/pleroma/api/status/context/pleroma_api_status_context_model.dart'
    as _i5;
import 'package:fedi/pleroma/api/status/pleroma_api_status_model.dart' as _i4;
import 'package:fedi/rest/rest_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIRestService extends _i1.Fake implements _i2.IRestService {}

class _FakeIPleromaApiConversation extends _i1.Fake
    implements _i3.IPleromaApiConversation {}

class _FakeIPleromaApiStatus extends _i1.Fake implements _i4.IPleromaApiStatus {
}

class _FakeIPleromaApiScheduledStatus extends _i1.Fake
    implements _i4.IPleromaApiScheduledStatus {}

class _FakeIPleromaApiStatusContext extends _i1.Fake
    implements _i5.IPleromaApiStatusContext {}

class _FakeIPleromaApiMyAccount extends _i1.Fake
    implements _i6.IPleromaApiMyAccount {}

class _FakeIPleromaApiAccountRelationship extends _i1.Fake
    implements _i7.IPleromaApiAccountRelationship {}

/// A class which mocks [IPleromaApiConversationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPleromaApiConversationService extends _i1.Mock
    implements _i8.IPleromaApiConversationService {
  MockIPleromaApiConversationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i9.Stream<_i10.PleromaApiState> get pleromaApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiStateStream),
              returnValue: Stream<_i10.PleromaApiState>.empty())
          as _i9.Stream<_i10.PleromaApiState>);
  @override
  _i10.PleromaApiState get pleromaApiState =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiState),
          returnValue: _i10.PleromaApiState.validAuth) as _i10.PleromaApiState);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i9.Future<List<_i4.IPleromaApiStatus>> getConversationStatuses(
          {String? conversationRemoteId,
          _i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getConversationStatuses, [], {
                #conversationRemoteId: conversationRemoteId,
                #pagination: pagination
              }),
              returnValue: Future<List<_i4.IPleromaApiStatus>>.value(
                  <_i4.IPleromaApiStatus>[]))
          as _i9.Future<List<_i4.IPleromaApiStatus>>);
  @override
  _i9.Future<_i3.IPleromaApiConversation> getConversation(
          {String? conversationRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#getConversation, [],
                  {#conversationRemoteId: conversationRemoteId}),
              returnValue: Future<_i3.IPleromaApiConversation>.value(
                  _FakeIPleromaApiConversation()))
          as _i9.Future<_i3.IPleromaApiConversation>);
  @override
  _i9.Future<_i3.IPleromaApiConversation> markConversationAsRead(
          {String? conversationRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#markConversationAsRead, [],
                  {#conversationRemoteId: conversationRemoteId}),
              returnValue: Future<_i3.IPleromaApiConversation>.value(
                  _FakeIPleromaApiConversation()))
          as _i9.Future<_i3.IPleromaApiConversation>);
  @override
  _i9.Future<dynamic> deleteConversation({String? conversationRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(#deleteConversation, [],
              {#conversationRemoteId: conversationRemoteId}),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<List<_i3.IPleromaApiConversation>> getConversations(
          {_i11.IPleromaApiPaginationRequest? pagination,
          List<String>? recipientsIds}) =>
      (super.noSuchMethod(
              Invocation.method(#getConversations, [],
                  {#pagination: pagination, #recipientsIds: recipientsIds}),
              returnValue: Future<List<_i3.IPleromaApiConversation>>.value(
                  <_i3.IPleromaApiConversation>[]))
          as _i9.Future<List<_i3.IPleromaApiConversation>>);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
}

/// A class which mocks [IPleromaApiAuthStatusService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPleromaApiAuthStatusService extends _i1.Mock
    implements _i12.IPleromaApiAuthStatusService {
  MockIPleromaApiAuthStatusService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i9.Stream<_i10.PleromaApiState> get pleromaApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiStateStream),
              returnValue: Stream<_i10.PleromaApiState>.empty())
          as _i9.Stream<_i10.PleromaApiState>);
  @override
  _i10.PleromaApiState get pleromaApiState =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiState),
          returnValue: _i10.PleromaApiState.validAuth) as _i10.PleromaApiState);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  _i9.Future<_i4.IPleromaApiStatus> postStatus(
          {_i4.IPleromaApiPostStatus? data}) =>
      (super.noSuchMethod(Invocation.method(#postStatus, [], {#data: data}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiScheduledStatus> scheduleStatus(
          {_i4.IPleromaApiScheduleStatus? data}) =>
      (super.noSuchMethod(Invocation.method(#scheduleStatus, [], {#data: data}),
              returnValue: Future<_i4.IPleromaApiScheduledStatus>.value(
                  _FakeIPleromaApiScheduledStatus()))
          as _i9.Future<_i4.IPleromaApiScheduledStatus>);
  @override
  _i9.Future<dynamic> deleteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #deleteStatus, [], {#statusRemoteId: statusRemoteId}),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> muteStatus(
          {String? statusRemoteId, int? expireDurationInSeconds}) =>
      (super.noSuchMethod(
              Invocation.method(#muteStatus, [], {
                #statusRemoteId: statusRemoteId,
                #expireDurationInSeconds: expireDurationInSeconds
              }),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> unMuteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unMuteStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> pinStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(#pinStatus, [], {#statusRemoteId: statusRemoteId}),
          returnValue: Future<_i4.IPleromaApiStatus>.value(
              _FakeIPleromaApiStatus())) as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> unPinStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unPinStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> favouriteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #favouriteStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> unFavouriteStatus(
          {String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unFavouriteStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> bookmarkStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #bookmarkStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> unBookmarkStatus(
          {String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unBookmarkStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> reblogStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #reblogStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> unReblogStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unReblogStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue:
                  Future<_i4.IPleromaApiStatus>.value(_FakeIPleromaApiStatus()))
          as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<List<_i7.IPleromaApiAccount>> favouritedBy(
          {String? statusRemoteId,
          _i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#favouritedBy, [],
                  {#statusRemoteId: statusRemoteId, #pagination: pagination}),
              returnValue: Future<List<_i7.IPleromaApiAccount>>.value(
                  <_i7.IPleromaApiAccount>[]))
          as _i9.Future<List<_i7.IPleromaApiAccount>>);
  @override
  _i9.Future<List<_i7.IPleromaApiAccount>> rebloggedBy(
          {String? statusRemoteId,
          _i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#rebloggedBy, [],
                  {#statusRemoteId: statusRemoteId, #pagination: pagination}),
              returnValue: Future<List<_i7.IPleromaApiAccount>>.value(
                  <_i7.IPleromaApiAccount>[]))
          as _i9.Future<List<_i7.IPleromaApiAccount>>);
  @override
  _i9.Future<_i4.IPleromaApiStatus> getStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(#getStatus, [], {#statusRemoteId: statusRemoteId}),
          returnValue: Future<_i4.IPleromaApiStatus>.value(
              _FakeIPleromaApiStatus())) as _i9.Future<_i4.IPleromaApiStatus>);
  @override
  _i9.Future<_i5.IPleromaApiStatusContext> getStatusContext(
          {String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getStatusContext, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future<_i5.IPleromaApiStatusContext>.value(
                  _FakeIPleromaApiStatusContext()))
          as _i9.Future<_i5.IPleromaApiStatusContext>);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
}

/// A class which mocks [IPleromaApiMyAccountService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPleromaApiMyAccountService extends _i1.Mock
    implements _i13.IPleromaApiMyAccountService {
  MockIPleromaApiMyAccountService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i9.Stream<_i10.PleromaApiState> get pleromaApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiStateStream),
              returnValue: Stream<_i10.PleromaApiState>.empty())
          as _i9.Stream<_i10.PleromaApiState>);
  @override
  _i10.PleromaApiState get pleromaApiState =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiState),
          returnValue: _i10.PleromaApiState.validAuth) as _i10.PleromaApiState);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i9.Future<_i6.IPleromaApiMyAccount> updateCredentials(
          _i6.IPleromaApiMyAccountEdit? accountEditData) =>
      (super.noSuchMethod(
              Invocation.method(#updateCredentials, [accountEditData]),
              returnValue: Future<_i6.IPleromaApiMyAccount>.value(
                  _FakeIPleromaApiMyAccount()))
          as _i9.Future<_i6.IPleromaApiMyAccount>);
  @override
  _i9.Future<_i6.IPleromaApiMyAccount> updateFiles(
          _i6.PleromaApiMyAccountFilesRequest? accountFilesRequest) =>
      (super.noSuchMethod(
              Invocation.method(#updateFiles, [accountFilesRequest]),
              returnValue: Future<_i6.IPleromaApiMyAccount>.value(
                  _FakeIPleromaApiMyAccount()))
          as _i9.Future<_i6.IPleromaApiMyAccount>);
  @override
  _i9.Future<_i6.IPleromaApiMyAccount> verifyCredentials() =>
      (super.noSuchMethod(Invocation.method(#verifyCredentials, []),
              returnValue: Future<_i6.IPleromaApiMyAccount>.value(
                  _FakeIPleromaApiMyAccount()))
          as _i9.Future<_i6.IPleromaApiMyAccount>);
  @override
  _i9.Future<List<String>> getDomainBlocks(
          {_i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
          Invocation.method(#getDomainBlocks, [], {#pagination: pagination}),
          returnValue:
              Future<List<String>>.value(<String>[])) as _i9
          .Future<List<String>>);
  @override
  _i9.Future<List<_i7.IPleromaApiAccount>> getAccountBlocks(
          {_i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
          Invocation.method(#getAccountBlocks, [], {#pagination: pagination}),
          returnValue: Future<List<_i7.IPleromaApiAccount>>.value(
              <_i7.IPleromaApiAccount>[])) as _i9
          .Future<List<_i7.IPleromaApiAccount>>);
  @override
  _i9.Future<List<_i7.IPleromaApiAccount>> getAccountMutes(
          {_i11.IPleromaApiPaginationRequest? pagination,
          bool? withRelationship}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountMutes, [], {
                #pagination: pagination,
                #withRelationship: withRelationship
              }),
              returnValue: Future<List<_i7.IPleromaApiAccount>>.value(
                  <_i7.IPleromaApiAccount>[]))
          as _i9.Future<List<_i7.IPleromaApiAccount>>);
  @override
  _i9.Future<List<_i4.IPleromaApiStatus>> getBookmarks(
          {_i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getBookmarks, [], {#pagination: pagination}),
              returnValue: Future<List<_i4.IPleromaApiStatus>>.value(
                  <_i4.IPleromaApiStatus>[]))
          as _i9.Future<List<_i4.IPleromaApiStatus>>);
  @override
  _i9.Future<List<_i4.IPleromaApiStatus>> getFavourites(
          {_i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getFavourites, [], {#pagination: pagination}),
              returnValue: Future<List<_i4.IPleromaApiStatus>>.value(
                  <_i4.IPleromaApiStatus>[]))
          as _i9.Future<List<_i4.IPleromaApiStatus>>);
  @override
  _i9.Future<List<_i7.IPleromaApiAccount>> getFollowRequests(
          {_i11.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
          Invocation.method(#getFollowRequests, [], {#pagination: pagination}),
          returnValue: Future<List<_i7.IPleromaApiAccount>>.value(
              <_i7.IPleromaApiAccount>[])) as _i9
          .Future<List<_i7.IPleromaApiAccount>>);
  @override
  _i9.Future<_i7.IPleromaApiAccountRelationship> acceptFollowRequest(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #acceptFollowRequest, [], {#accountRemoteId: accountRemoteId}),
          returnValue: Future<_i7.IPleromaApiAccountRelationship>.value(
              _FakeIPleromaApiAccountRelationship())) as _i9
          .Future<_i7.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i7.IPleromaApiAccountRelationship> rejectFollowRequest(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #rejectFollowRequest, [], {#accountRemoteId: accountRemoteId}),
          returnValue: Future<_i7.IPleromaApiAccountRelationship>.value(
              _FakeIPleromaApiAccountRelationship())) as _i9
          .Future<_i7.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i9.Future<dynamic>);
}
