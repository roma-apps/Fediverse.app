// Mocks generated by Mockito 5.0.7 from annotations
// in fedi/test/app/account/account_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;

import 'package:fedi/connection/connection_service.dart' as _i5;
import 'package:fedi/disposable/disposable.dart' as _i14;
import 'package:fedi/pleroma/api/account/auth/pleroma_api_auth_account_service_impl.dart'
    as _i8;
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart' as _i4;
import 'package:fedi/pleroma/api/list/pleroma_api_list_model.dart' as _i11;
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i12;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i10;
import 'package:fedi/pleroma/api/rest/auth/pleroma_api_auth_rest_service.dart'
    as _i2;
import 'package:fedi/pleroma/api/rest/pleroma_api_rest_service.dart' as _i3;
import 'package:fedi/pleroma/api/status/pleroma_api_status_model.dart' as _i13;
import 'package:fedi/pleroma/api/web_sockets/pleroma_api_web_sockets_model.dart'
    as _i20;
import 'package:fedi/pleroma/api/web_sockets/pleroma_api_web_sockets_service_impl.dart'
    as _i19;
import 'package:fedi/web_sockets/channel/web_sockets_channel.dart' as _i7;
import 'package:fedi/web_sockets/web_sockets_model.dart' as _i6;
import 'package:flutter/src/widgets/editable_text.dart' as _i15;
import 'package:flutter/src/widgets/focus_manager.dart' as _i17;
import 'package:flutter/src/widgets/scroll_controller.dart' as _i16;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/subject.dart' as _i18;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeIPleromaApiAuthRestService extends _i1.Fake
    implements _i2.IPleromaApiAuthRestService {}

class _FakeIPleromaApiRestService extends _i1.Fake
    implements _i3.IPleromaApiRestService {}

class _FakeIPleromaApiAccountRelationship extends _i1.Fake
    implements _i4.IPleromaApiAccountRelationship {}

class _FakeIPleromaApiAccount extends _i1.Fake
    implements _i4.IPleromaApiAccount {}

class _FakeUri extends _i1.Fake implements Uri {}

class _FakeIConnectionService extends _i1.Fake
    implements _i5.IConnectionService {}

class _FakeIWebSocketsChannel<T extends _i6.WebSocketsEvent> extends _i1.Fake
    implements _i7.IWebSocketsChannel<T> {}

class _FakeWebSocketsEvent extends _i1.Fake implements _i6.WebSocketsEvent {}

/// A class which mocks [PleromaApiAuthAccountService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaApiAuthAccountService extends _i1.Mock
    implements _i8.PleromaApiAuthAccountService {
  MockPleromaApiAuthAccountService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get accountReportRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#accountReportRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i2.IPleromaApiAuthRestService get authRestService =>
      (super.noSuchMethod(Invocation.getter(#authRestService),
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
  String get accountRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#accountRelativeUrlPath),
          returnValue: '') as String);
  @override
  String get pleromaAccountRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#pleromaAccountRelativeUrlPath),
          returnValue: '') as String);
  @override
  _i3.IPleromaApiRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
              returnValue: _FakeIPleromaApiRestService())
          as _i3.IPleromaApiRestService);
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
  _i9.Future<List<_i4.IPleromaApiAccountRelationship>>
      getRelationshipWithAccounts({List<String>? remoteAccountIds}) =>
          (super.noSuchMethod(
                  Invocation.method(#getRelationshipWithAccounts, [],
                      {#remoteAccountIds: remoteAccountIds}),
                  returnValue:
                      Future<List<_i4.IPleromaApiAccountRelationship>>.value(
                          <_i4.IPleromaApiAccountRelationship>[]))
              as _i9.Future<List<_i4.IPleromaApiAccountRelationship>>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> blockAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #blockAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> followAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #followAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> muteAccount(
          {String? accountRemoteId,
          bool? notifications,
          int? expireDurationInSeconds}) =>
      (super.noSuchMethod(
              Invocation.method(#muteAccount, [], {
                #accountRemoteId: accountRemoteId,
                #notifications: notifications,
                #expireDurationInSeconds: expireDurationInSeconds
              }),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> pinAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #pinAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> unBlockAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unBlockAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> unFollowAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unFollowAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> unMuteAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unMuteAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> unPinAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unPinAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<List<_i4.IPleromaApiAccountIdentityProof>>
      getAccountIdentifyProofs({String? accountRemoteId}) => (super
              .noSuchMethod(
                  Invocation.method(#getAccountIdentifyProofs, [], {
                    #accountRemoteId: accountRemoteId
                  }),
                  returnValue:
                      Future<List<_i4.IPleromaApiAccountIdentityProof>>.value(
                          <_i4.IPleromaApiAccountIdentityProof>[]))
          as _i9.Future<List<_i4.IPleromaApiAccountIdentityProof>>);
  @override
  _i9.Future<List<_i11.IPleromaApiList>> getListsWithAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #getListsWithAccount, [], {#accountRemoteId: accountRemoteId}),
          returnValue: Future<List<_i11.IPleromaApiList>>.value(
              <_i11.IPleromaApiList>[])) as _i9
          .Future<List<_i11.IPleromaApiList>>);
  @override
  _i9.Future<List<_i4.IPleromaApiAccount>> search(
          {String? query,
          bool? resolve,
          bool? following,
          _i12.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#search, [], {
                #query: query,
                #resolve: resolve,
                #following: following,
                #pagination: pagination
              }),
              returnValue: Future<List<_i4.IPleromaApiAccount>>.value(
                  <_i4.IPleromaApiAccount>[]))
          as _i9.Future<List<_i4.IPleromaApiAccount>>);
  @override
  _i9.Future<dynamic> reportAccount(
          {_i4.IPleromaApiAccountReportRequest? reportRequest}) =>
      (super.noSuchMethod(
          Invocation.method(
              #reportAccount, [], {#reportRequest: reportRequest}),
          returnValue: Future<dynamic>.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> blockDomain({String? domain}) => (super.noSuchMethod(
      Invocation.method(#blockDomain, [], {#domain: domain}),
      returnValue: Future<dynamic>.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> unBlockDomain({String? domain}) => (super.noSuchMethod(
      Invocation.method(#unBlockDomain, [], {#domain: domain}),
      returnValue: Future<dynamic>.value(null)) as _i9.Future<dynamic>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> subscribeAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #subscribeAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<_i4.IPleromaApiAccountRelationship> unSubscribeAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unSubscribeAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccountRelationship>.value(
                  _FakeIPleromaApiAccountRelationship()))
          as _i9.Future<_i4.IPleromaApiAccountRelationship>);
  @override
  _i9.Future<List<_i4.IPleromaApiAccount>> getAccountFollowings(
          {String? accountRemoteId,
          _i12.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFollowings, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future<List<_i4.IPleromaApiAccount>>.value(
                  <_i4.IPleromaApiAccount>[]))
          as _i9.Future<List<_i4.IPleromaApiAccount>>);
  @override
  _i9.Future<_i4.IPleromaApiAccount> getAccount({String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i4.IPleromaApiAccount>.value(
                  _FakeIPleromaApiAccount()))
          as _i9.Future<_i4.IPleromaApiAccount>);
  @override
  _i9.Future<List<_i4.PleromaApiAccount>> getAccountFollowers(
          {String? accountRemoteId,
          _i12.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFollowers, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future<List<_i4.PleromaApiAccount>>.value(
                  <_i4.PleromaApiAccount>[]))
          as _i9.Future<List<_i4.PleromaApiAccount>>);
  @override
  _i9.Future<List<_i13.IPleromaApiStatus>> getAccountStatuses(
          {String? accountRemoteId,
          String? tagged,
          bool? pinned,
          bool? excludeReplies,
          bool? excludeReblogs,
          List<String>? excludeVisibilities,
          bool? withMuted,
          bool? onlyWithMedia,
          _i12.IPleromaApiPaginationRequest? pagination}) =>
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
              returnValue: Future<List<_i13.IPleromaApiStatus>>.value(
                  <_i13.IPleromaApiStatus>[]))
          as _i9.Future<List<_i13.IPleromaApiStatus>>);
  @override
  _i9.Future<List<_i13.IPleromaApiStatus>> getAccountFavouritedStatuses(
          {String? accountRemoteId,
          _i12.IPleromaApiPaginationRequest? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFavouritedStatuses, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future<List<_i13.IPleromaApiStatus>>.value(
                  <_i13.IPleromaApiStatus>[]))
          as _i9.Future<List<_i13.IPleromaApiStatus>>);
  @override
  void addDisposable(
          {_i14.IDisposable? disposable,
          _i9.StreamSubscription<dynamic>? streamSubscription,
          _i15.TextEditingController? textEditingController,
          _i16.ScrollController? scrollController,
          _i17.FocusNode? focusNode,
          _i18.Subject<dynamic>? subject,
          _i9.StreamController<dynamic>? streamController,
          _i9.Timer? timer,
          _i9.FutureOr<dynamic>? Function()? custom}) =>
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
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value(null)) as _i9.Future<dynamic>);
}

/// A class which mocks [PleromaApiWebSocketsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaApiWebSocketsService extends _i1.Mock
    implements _i19.PleromaApiWebSocketsService {
  MockPleromaApiWebSocketsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Uri get baseUri =>
      (super.noSuchMethod(Invocation.getter(#baseUri), returnValue: _FakeUri())
          as Uri);
  @override
  String get accessToken =>
      (super.noSuchMethod(Invocation.getter(#accessToken), returnValue: '')
          as String);
  @override
  _i5.IConnectionService get connectionService =>
      (super.noSuchMethod(Invocation.getter(#connectionService),
          returnValue: _FakeIConnectionService()) as _i5.IConnectionService);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getOrCreateNewChannel(
          {String? stream, Map<String, String>? queryArgs}) =>
      (super.noSuchMethod(
              Invocation.method(#getOrCreateNewChannel, [],
                  {#stream: stream, #queryArgs: queryArgs}),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  String mapHttpToWebSocketsScheme(String? scheme) => (super.noSuchMethod(
      Invocation.method(#mapHttpToWebSocketsScheme, [scheme]),
      returnValue: '') as String);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getHashtagChannel(
          {String? hashtag, bool? local}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getHashtagChannel, [], {#hashtag: hashtag, #local: local}),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getListChannel(
          {String? listId}) =>
      (super.noSuchMethod(
              Invocation.method(#getListChannel, [], {#listId: listId}),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getPublicChannel(
          {bool? onlyLocal,
          bool? onlyRemote,
          bool? onlyMedia,
          String? onlyFromInstance}) =>
      (super.noSuchMethod(
              Invocation.method(#getPublicChannel, [], {
                #onlyLocal: onlyLocal,
                #onlyRemote: onlyRemote,
                #onlyMedia: onlyMedia,
                #onlyFromInstance: onlyFromInstance
              }),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getAccountChannel(
          {String? accountId, bool? notification}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountChannel, [],
                  {#accountId: accountId, #notification: notification}),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getMyAccountChannel(
          {bool? notification, bool? chat}) =>
      (super.noSuchMethod(
              Invocation.method(#getMyAccountChannel, [],
                  {#notification: notification, #chat: chat}),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent> getDirectChannel(
          {String? accountId}) =>
      (super.noSuchMethod(
              Invocation.method(#getDirectChannel, [], {#accountId: accountId}),
              returnValue:
                  _FakeIWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>())
          as _i7.IWebSocketsChannel<_i20.PleromaApiWebSocketsEvent>);
  @override
  _i6.WebSocketsEvent eventParser(Map<String, dynamic>? json) =>
      (super.noSuchMethod(Invocation.method(#eventParser, [json]),
          returnValue: _FakeWebSocketsEvent()) as _i6.WebSocketsEvent);
  @override
  void addDisposable(
          {_i14.IDisposable? disposable,
          _i9.StreamSubscription<dynamic>? streamSubscription,
          _i15.TextEditingController? textEditingController,
          _i16.ScrollController? scrollController,
          _i17.FocusNode? focusNode,
          _i18.Subject<dynamic>? subject,
          _i9.StreamController<dynamic>? streamController,
          _i9.Timer? timer,
          _i9.FutureOr<dynamic>? Function()? custom}) =>
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
  @override
  _i9.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value(null)) as _i9.Future<dynamic>);
}
