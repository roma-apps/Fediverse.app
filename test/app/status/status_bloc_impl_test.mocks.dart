// Mocks generated by Mockito 5.0.0-nullsafety.7 from annotations
// in fedi/test/app/status/status_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;

import 'package:fedi/pleroma/account/auth/pleroma_auth_account_service_impl.dart'
    as _i13;
import 'package:fedi/pleroma/account/pleroma_account_model.dart' as _i6;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i10;
import 'package:fedi/pleroma/list/pleroma_list_model.dart' as _i14;
import 'package:fedi/pleroma/pagination/pleroma_pagination_model.dart' as _i11;
import 'package:fedi/pleroma/poll/pleroma_poll_model.dart' as _i7;
import 'package:fedi/pleroma/poll/pleroma_poll_service_impl.dart' as _i16;
import 'package:fedi/pleroma/rest/auth/pleroma_auth_rest_service.dart' as _i2;
import 'package:fedi/pleroma/rest/pleroma_rest_service.dart' as _i3;
import 'package:fedi/pleroma/status/auth/pleroma_auth_status_service_impl.dart'
    as _i8;
import 'package:fedi/pleroma/status/context/pleroma_status_context_model.dart'
    as _i5;
import 'package:fedi/pleroma/status/emoji_reaction/pleroma_status_emoji_reaction_service_impl.dart'
    as _i15;
import 'package:fedi/pleroma/status/pleroma_status_model.dart' as _i4;
import 'package:http/src/response.dart' as _i12;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeIPleromaAuthRestService extends _i1.Fake
    implements _i2.IPleromaAuthRestService {}

class _FakeIPleromaRestService extends _i1.Fake
    implements _i3.IPleromaRestService {}

class _FakeIPleromaStatus extends _i1.Fake implements _i4.IPleromaStatus {}

class _FakeIPleromaScheduledStatus extends _i1.Fake
    implements _i4.IPleromaScheduledStatus {}

class _FakePleromaStatus extends _i1.Fake implements _i4.PleromaStatus {}

class _FakePleromaScheduledStatus extends _i1.Fake
    implements _i4.PleromaScheduledStatus {}

class _FakePleromaStatusContext extends _i1.Fake
    implements _i5.PleromaStatusContext {}

class _FakeIPleromaAccountRelationship extends _i1.Fake
    implements _i6.IPleromaAccountRelationship {}

class _FakeIPleromaAccount extends _i1.Fake implements _i6.IPleromaAccount {}

class _FakeIPleromaStatusEmojiReaction extends _i1.Fake
    implements _i4.IPleromaStatusEmojiReaction {}

class _FakePleromaStatusEmojiReaction extends _i1.Fake
    implements _i4.PleromaStatusEmojiReaction {}

class _FakeIPleromaPoll extends _i1.Fake implements _i7.IPleromaPoll {}

class _FakePleromaPoll extends _i1.Fake implements _i7.PleromaPoll {}

/// A class which mocks [PleromaAuthStatusService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaAuthStatusService extends _i1.Mock
    implements _i8.PleromaAuthStatusService {
  MockPleromaAuthStatusService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IPleromaAuthRestService get authRestService =>
      (super.noSuchMethod(Invocation.getter(#authRestService),
              returnValue: _FakeIPleromaAuthRestService())
          as _i2.IPleromaAuthRestService);
  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  String get statusRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#statusRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i3.IPleromaRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIPleromaRestService()) as _i3.IPleromaRestService);
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
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i9.Future<dynamic> deleteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #deleteStatus, [], {#statusRemoteId: statusRemoteId}),
          returnValue: Future.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<_i4.IPleromaStatus> muteStatus(
          {String? statusRemoteId, int? expireDurationInSeconds}) =>
      (super.noSuchMethod(
              Invocation.method(#muteStatus, [], {
                #statusRemoteId: statusRemoteId,
                #expireDurationInSeconds: expireDurationInSeconds
              }),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> unMuteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unMuteStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> pinStatus({String? statusRemoteId}) => (super
      .noSuchMethod(
          Invocation.method(#pinStatus, [], {#statusRemoteId: statusRemoteId}),
          returnValue: Future.value(_FakeIPleromaStatus())) as _i9
      .Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> unPinStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unPinStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<List<_i6.IPleromaAccount>> favouritedBy(
          {String? statusRemoteId,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#favouritedBy, [],
                  {#statusRemoteId: statusRemoteId, #pagination: pagination}),
              returnValue: Future.value(<_i6.IPleromaAccount>[]))
          as _i9.Future<List<_i6.IPleromaAccount>>);
  @override
  _i9.Future<List<_i6.IPleromaAccount>> rebloggedBy(
          {String? statusRemoteId,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#rebloggedBy, [],
                  {#statusRemoteId: statusRemoteId, #pagination: pagination}),
              returnValue: Future.value(<_i6.IPleromaAccount>[]))
          as _i9.Future<List<_i6.IPleromaAccount>>);
  @override
  _i9.Future<_i4.IPleromaStatus> reblogStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #reblogStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> unReblogStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unReblogStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> favouriteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #favouriteStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> unFavouriteStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unFavouriteStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> bookmarkStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #bookmarkStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> unBookmarkStatus({String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unBookmarkStatus, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatus> postStatus({_i4.IPleromaPostStatus? data}) =>
      (super.noSuchMethod(Invocation.method(#postStatus, [], {#data: data}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaScheduledStatus> scheduleStatus(
          {_i4.IPleromaScheduleStatus? data}) =>
      (super.noSuchMethod(Invocation.method(#scheduleStatus, [], {#data: data}),
              returnValue: Future.value(_FakeIPleromaScheduledStatus()))
          as _i9.Future<_i4.IPleromaScheduledStatus>);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<_i4.IPleromaStatus> getStatus({String? statusRemoteId}) => (super
      .noSuchMethod(
          Invocation.method(#getStatus, [], {#statusRemoteId: statusRemoteId}),
          returnValue: Future.value(_FakeIPleromaStatus())) as _i9
      .Future<_i4.IPleromaStatus>);
  @override
  _i4.PleromaStatus parseStatusResponse(_i12.Response? httpResponse) => (super
      .noSuchMethod(Invocation.method(#parseStatusResponse, [httpResponse]),
          returnValue: _FakePleromaStatus()) as _i4.PleromaStatus);
  @override
  _i4.PleromaScheduledStatus parseScheduledStatusResponse(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
              Invocation.method(#parseScheduledStatusResponse, [httpResponse]),
              returnValue: _FakePleromaScheduledStatus())
          as _i4.PleromaScheduledStatus);
  @override
  _i5.PleromaStatusContext parseStatusContextResponse(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
              Invocation.method(#parseStatusContextResponse, [httpResponse]),
              returnValue: _FakePleromaStatusContext())
          as _i5.PleromaStatusContext);
  @override
  List<_i6.PleromaAccount> parseAccountsResponse(_i12.Response? httpResponse) =>
      (super.noSuchMethod(
          Invocation.method(#parseAccountsResponse, [httpResponse]),
          returnValue: <_i6.PleromaAccount>[]) as List<_i6.PleromaAccount>);
  @override
  _i9.Future<_i5.PleromaStatusContext> getStatusContext(
          {String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getStatusContext, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(_FakePleromaStatusContext()))
          as _i9.Future<_i5.PleromaStatusContext>);
}

/// A class which mocks [PleromaAuthAccountService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaAuthAccountService extends _i1.Mock
    implements _i13.PleromaAuthAccountService {
  MockPleromaAuthAccountService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get accountReportRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#accountReportRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i2.IPleromaAuthRestService get authRestService =>
      (super.noSuchMethod(Invocation.getter(#authRestService),
              returnValue: _FakeIPleromaAuthRestService())
          as _i2.IPleromaAuthRestService);
  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
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
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  String get accountRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#accountRelativeUrlPath),
          returnValue: '') as String);
  @override
  String get pleromaAccountRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#pleromaAccountRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i3.IPleromaRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIPleromaRestService()) as _i3.IPleromaRestService);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i9.Future<List<_i6.IPleromaAccountRelationship>> getRelationshipWithAccounts(
          {List<String>? remoteAccountIds}) =>
      (super.noSuchMethod(
              Invocation.method(#getRelationshipWithAccounts, [],
                  {#remoteAccountIds: remoteAccountIds}),
              returnValue: Future.value(<_i6.IPleromaAccountRelationship>[]))
          as _i9.Future<List<_i6.IPleromaAccountRelationship>>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> blockAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #blockAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> followAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #followAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> muteAccount(
          {String? accountRemoteId,
          bool? notifications,
          int? expireDurationInSeconds}) =>
      (super.noSuchMethod(
              Invocation.method(#muteAccount, [], {
                #accountRemoteId: accountRemoteId,
                #notifications: notifications,
                #expireDurationInSeconds: expireDurationInSeconds
              }),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> pinAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #pinAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> unBlockAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unBlockAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> unFollowAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unFollowAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> unMuteAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unMuteAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> unPinAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unPinAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<List<_i6.IPleromaAccountIdentityProof>> getAccountIdentifyProofs(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountIdentifyProofs, [],
                  {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(<_i6.IPleromaAccountIdentityProof>[]))
          as _i9.Future<List<_i6.IPleromaAccountIdentityProof>>);
  @override
  _i9.Future<List<_i14.IPleromaList>> getListsWithAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#getListsWithAccount, [],
                  {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(<_i14.IPleromaList>[]))
          as _i9.Future<List<_i14.IPleromaList>>);
  @override
  _i9.Future<List<_i6.IPleromaAccount>> search(
          {String? query,
          bool? resolve,
          bool? following,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#search, [], {
                #query: query,
                #resolve: resolve,
                #following: following,
                #pagination: pagination
              }),
              returnValue: Future.value(<_i6.IPleromaAccount>[]))
          as _i9.Future<List<_i6.IPleromaAccount>>);
  @override
  _i9.Future<bool> reportAccount(
          {_i6.IPleromaAccountReportRequest? reportRequest}) =>
      (super.noSuchMethod(
          Invocation.method(
              #reportAccount, [], {#reportRequest: reportRequest}),
          returnValue: Future.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<dynamic> blockDomain({String? domain}) => (super.noSuchMethod(
      Invocation.method(#blockDomain, [], {#domain: domain}),
      returnValue: Future.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> unBlockDomain({String? domain}) => (super.noSuchMethod(
      Invocation.method(#unBlockDomain, [], {#domain: domain}),
      returnValue: Future.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> subscribeAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #subscribeAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  _i9.Future<_i6.IPleromaAccountRelationship> unSubscribeAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unSubscribeAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccountRelationship()))
          as _i9.Future<_i6.IPleromaAccountRelationship>);
  @override
  List<_i6.PleromaAccount> parseAccountListResponse(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
          Invocation.method(#parseAccountListResponse, [httpResponse]),
          returnValue: <_i6.PleromaAccount>[]) as List<_i6.PleromaAccount>);
  @override
  List<_i6.IPleromaAccountIdentityProof> parseAccountAccountIdentityProofList(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
              Invocation.method(
                  #parseAccountAccountIdentityProofList, [httpResponse]),
              returnValue: <_i6.IPleromaAccountIdentityProof>[])
          as List<_i6.IPleromaAccountIdentityProof>);
  @override
  List<_i14.IPleromaList> parseListList(_i12.Response? httpResponse) =>
      (super.noSuchMethod(Invocation.method(#parseListList, [httpResponse]),
          returnValue: <_i14.IPleromaList>[]) as List<_i14.IPleromaList>);
  @override
  List<_i4.IPleromaStatus> parseStatusListResponse(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
          Invocation.method(#parseStatusListResponse, [httpResponse]),
          returnValue: <_i4.IPleromaStatus>[]) as List<_i4.IPleromaStatus>);
  @override
  _i6.IPleromaAccountRelationship parseAccountRelationshipResponse(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
          Invocation.method(#parseAccountRelationshipResponse, [httpResponse]),
          returnValue:
              _FakeIPleromaAccountRelationship()) as _i6
          .IPleromaAccountRelationship);
  @override
  List<_i6.IPleromaAccountRelationship> parseAccountRelationshipResponseList(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
              Invocation.method(
                  #parseAccountRelationshipResponseList, [httpResponse]),
              returnValue: <_i6.IPleromaAccountRelationship>[])
          as List<_i6.IPleromaAccountRelationship>);
  @override
  _i6.IPleromaAccount parseAccountResponse(_i12.Response? httpResponse) =>
      (super.noSuchMethod(
          Invocation.method(#parseAccountResponse, [httpResponse]),
          returnValue: _FakeIPleromaAccount()) as _i6.IPleromaAccount);
  @override
  _i9.Future<List<_i6.IPleromaAccount>> getAccountFollowings(
          {String? accountRemoteId,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFollowings, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future.value(<_i6.IPleromaAccount>[]))
          as _i9.Future<List<_i6.IPleromaAccount>>);
  @override
  _i9.Future<_i6.IPleromaAccount> getAccount({String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future.value(_FakeIPleromaAccount()))
          as _i9.Future<_i6.IPleromaAccount>);
  @override
  _i9.Future<List<_i6.PleromaAccount>> getAccountFollowers(
          {String? accountRemoteId,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFollowers, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future.value(<_i6.PleromaAccount>[]))
          as _i9.Future<List<_i6.PleromaAccount>>);
  @override
  _i9.Future<List<_i4.IPleromaStatus>> getAccountStatuses(
          {String? accountRemoteId,
          String? tagged,
          bool? pinned,
          bool? excludeReplies,
          bool? excludeReblogs,
          List<String>? excludeVisibilities,
          bool? withMuted,
          bool? onlyWithMedia,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountStatuses, [], {
                #accountRemoteId: accountRemoteId,
                #tagged: tagged,
                #pinned: pinned,
                #excludeReplies: excludeReplies,
                #excludeReblogs: excludeReblogs,
                #excludeVisibilities: excludeVisibilities,
                #withMuted: withMuted,
                #onlyWithMedia: onlyWithMedia,
                #pagination: pagination
              }),
              returnValue: Future.value(<_i4.IPleromaStatus>[]))
          as _i9.Future<List<_i4.IPleromaStatus>>);
  @override
  _i9.Future<List<_i4.IPleromaStatus>> getAccountFavouritedStatuses(
          {String? accountRemoteId,
          _i11.IPleromaPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFavouritedStatuses, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future.value(<_i4.IPleromaStatus>[]))
          as _i9.Future<List<_i4.IPleromaStatus>>);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future.value(null)) as _i9.Future<dynamic>);
}

/// A class which mocks [PleromaStatusEmojiReactionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaStatusEmojiReactionService extends _i1.Mock
    implements _i15.PleromaStatusEmojiReactionService {
  MockPleromaStatusEmojiReactionService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get pleromaStatusesRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#pleromaStatusesRelativeUrlPath),
          returnValue: '') as String);
  @override
  String get reactionsRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#reactionsRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i2.IPleromaAuthRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
              returnValue: _FakeIPleromaAuthRestService())
          as _i2.IPleromaAuthRestService);
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
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i9.Future<_i4.IPleromaStatus> addReaction(
          {String? statusRemoteId, String? emoji}) =>
      (super.noSuchMethod(
              Invocation.method(#addReaction, [],
                  {#statusRemoteId: statusRemoteId, #emoji: emoji}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i9.Future<_i4.IPleromaStatusEmojiReaction> getReaction(
          {String? statusRemoteId, String? emoji}) =>
      (super.noSuchMethod(
              Invocation.method(#getReaction, [],
                  {#statusRemoteId: statusRemoteId, #emoji: emoji}),
              returnValue: Future.value(_FakeIPleromaStatusEmojiReaction()))
          as _i9.Future<_i4.IPleromaStatusEmojiReaction>);
  @override
  _i9.Future<List<_i4.IPleromaStatusEmojiReaction>> getReactions(
          {String? statusRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getReactions, [], {#statusRemoteId: statusRemoteId}),
              returnValue: Future.value(<_i4.IPleromaStatusEmojiReaction>[]))
          as _i9.Future<List<_i4.IPleromaStatusEmojiReaction>>);
  @override
  _i9.Future<_i4.IPleromaStatus> removeReaction(
          {String? statusRemoteId, String? emoji}) =>
      (super.noSuchMethod(
              Invocation.method(#removeReaction, [],
                  {#statusRemoteId: statusRemoteId, #emoji: emoji}),
              returnValue: Future.value(_FakeIPleromaStatus()))
          as _i9.Future<_i4.IPleromaStatus>);
  @override
  _i4.PleromaStatus parseStatusResponse(_i12.Response? httpResponse) => (super
      .noSuchMethod(Invocation.method(#parseStatusResponse, [httpResponse]),
          returnValue: _FakePleromaStatus()) as _i4.PleromaStatus);
  @override
  _i4.PleromaStatusEmojiReaction parseEmojiReactionResponse(
          _i12.Response? httpResponse) =>
      (super.noSuchMethod(
              Invocation.method(#parseEmojiReactionResponse, [httpResponse]),
              returnValue: _FakePleromaStatusEmojiReaction())
          as _i4.PleromaStatusEmojiReaction);
  @override
  List<_i4.PleromaStatusEmojiReaction> parseEmojiReactionListResponse(
          _i12.Response? httpResponse) =>
      (super
              .noSuchMethod(
                  Invocation.method(
                      #parseEmojiReactionListResponse, [httpResponse]),
                  returnValue: <_i4.PleromaStatusEmojiReaction>[])
          as List<_i4.PleromaStatusEmojiReaction>);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future.value(null)) as _i9.Future<dynamic>);
}

/// A class which mocks [PleromaPollService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaPollService extends _i1.Mock
    implements _i16.PleromaPollService {
  MockPleromaPollService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get pollRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#pollRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i2.IPleromaAuthRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
              returnValue: _FakeIPleromaAuthRestService())
          as _i2.IPleromaAuthRestService);
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
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  _i9.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i9.Stream<bool>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<_i7.IPleromaPoll> getPoll({String? pollRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#getPoll, [], {#pollRemoteId: pollRemoteId}),
              returnValue: Future.value(_FakeIPleromaPoll()))
          as _i9.Future<_i7.IPleromaPoll>);
  @override
  _i9.Future<_i7.IPleromaPoll> vote(
          {String? pollRemoteId, List<int>? voteIndexes}) =>
      (super.noSuchMethod(
              Invocation.method(#vote, [],
                  {#pollRemoteId: pollRemoteId, #voteIndexes: voteIndexes}),
              returnValue: Future.value(_FakeIPleromaPoll()))
          as _i9.Future<_i7.IPleromaPoll>);
  @override
  _i7.PleromaPoll parsePollResponse(_i12.Response? httpResponse) =>
      (super.noSuchMethod(Invocation.method(#parsePollResponse, [httpResponse]),
          returnValue: _FakePleromaPoll()) as _i7.PleromaPoll);
}