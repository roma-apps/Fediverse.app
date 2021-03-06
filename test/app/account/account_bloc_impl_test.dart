import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/account_model_adapter.dart';
import 'package:fedi/app/account/local_account_bloc_impl.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/account/repository/account_repository_impl.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/emoji/text/emoji_text_model.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/repository/status_repository_impl.dart';
import 'package:fedi/pleroma/api/account/auth/pleroma_api_auth_account_service.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/emoji/pleroma_api_emoji_model.dart';
import 'package:fedi/pleroma/api/field/pleroma_api_field_model.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/api/web_sockets/pleroma_api_web_sockets_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/ffi.dart';

import 'account_bloc_impl_test.mocks.dart';
import 'account_test_helper.dart';
// ignore_for_file: avoid-late-keyword

@GenerateMocks([
  IPleromaApiAuthAccountService,
  IPleromaApiWebSocketsService,
])
void main() {
  late IAccount account;
  late IAccountBloc accountBloc;
  late MockIPleromaApiAuthAccountService pleromaAuthAccountServiceMock;
  late AppDatabase database;
  late IAccountRepository accountRepository;
  late IStatusRepository statusRepository;
  late MockIPleromaApiWebSocketsService pleromaWebSocketsService;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    accountRepository = AccountRepository(appDatabase: database);
    statusRepository = StatusRepository(
      appDatabase: database,
      accountRepository: accountRepository,
    );

    pleromaAuthAccountServiceMock = MockIPleromaApiAuthAccountService();

    when(pleromaAuthAccountServiceMock.isConnected).thenReturn(true);
    when(pleromaAuthAccountServiceMock.pleromaApiState)
        .thenReturn(PleromaApiState.validAuth);

    account = await AccountTestHelper.createTestAccount(seed: 'seed1');

    pleromaWebSocketsService = MockIPleromaApiWebSocketsService();

    await accountRepository.upsertInRemoteType(
      account.toPleromaApiAccount(),
    );
    account = (await accountRepository.findByRemoteIdInAppType(
      account.remoteId,
    ))!;

    accountBloc = LocalAccountBloc(
      account: account,
      pleromaAuthAccountService: pleromaAuthAccountServiceMock,
      accountRepository: accountRepository,
      delayInit: false,
      pleromaWebSocketsService: pleromaWebSocketsService,
      statusRepository: statusRepository,
      myAccount: null,
    );
  });

  tearDown(() async {
    await accountBloc.dispose();
    await accountRepository.dispose();
    await database.close();
  });

  Future _update(IAccount account) async {
    await accountRepository.upsertInRemoteType(
      account.toPleromaApiAccount(),
    );
    // hack to execute notify callbacks
    await Future.delayed(
      Duration(
        milliseconds: 1,
      ),
    );
  }

  test('account', () async {
    AccountTestHelper.expectAccount(accountBloc.account, account);

    var newValue = await AccountTestHelper.createTestAccount(
      seed: 'seed2',
      remoteId: account.remoteId,
    );

    var listenedValue;

    var subscription = accountBloc.accountStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    AccountTestHelper.expectAccount(listenedValue, account);

    await _update(newValue);

    AccountTestHelper.expectAccount(accountBloc.account, newValue);
    AccountTestHelper.expectAccount(listenedValue, newValue);
    await subscription.cancel();
  });

  test('acct', () async {
    expect(accountBloc.acct, account.acct);

    var newValue = 'newAcct';

    var listenedValue;

    var subscription = accountBloc.acctStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.acct);

    await _update(
      account.copyWith(
        acct: newValue,
      ),
    );

    expect(accountBloc.acct, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('note', () async {
    expect(accountBloc.note, account.note);

    var newValue = 'newNote';

    var listenedValue;

    var subscription = accountBloc.noteStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.note);

    await _update(account.copyWith(note: newValue));

    expect(accountBloc.note, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('header', () async {
    expect(accountBloc.header, account.header);

    var newValue = 'newHeader';

    var listenedValue;

    var subscription = accountBloc.headerStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.header);

    await _update(account.copyWith(header: newValue));

    expect(accountBloc.header, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('avatar', () async {
    expect(accountBloc.avatar, account.avatar);

    var newValue = 'newAvatar';

    var listenedValue;

    var subscription = accountBloc.avatarStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.avatar);

    await _update(account.copyWith(avatar: newValue));

    expect(accountBloc.avatar, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('displayName', () async {
    expect(accountBloc.displayName, account.displayName);

    var newValue = 'newDisplayName';

    var listenedValue;

    var subscription = accountBloc.displayNameStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.displayName);

    await _update(account.copyWith(displayName: newValue));

    expect(accountBloc.displayName, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('fields', () async {
    expect(accountBloc.fields, account.fields ?? []);

    var newValue = [
      PleromaApiField(
        name: 'newName',
        value: 'newValue',
        verifiedAt: null,
      ),
    ];

    var listenedValue;

    var subscription = accountBloc.fieldsStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.fields ?? []);

    await _update(account.copyWith(fields: newValue));

    expect(accountBloc.fields, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });

  test('statusesCount', () async {
    expect(accountBloc.statusesCount, account.statusesCount);

    var newValue = account.statusesCount + 1;

    var listenedValue;

    var subscription = accountBloc.statusesCountStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.statusesCount);

    await _update(account.copyWith(statusesCount: newValue));

    expect(accountBloc.statusesCount, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('statusesCount', () async {
    expect(accountBloc.statusesCount, account.statusesCount);

    var newValue = account.statusesCount + 1;

    var listenedValue;

    var subscription = accountBloc.statusesCountStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.statusesCount);

    await _update(account.copyWith(statusesCount: newValue));

    expect(accountBloc.statusesCount, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('followingCount', () async {
    expect(accountBloc.followingCount, account.followingCount);

    var newValue = account.followingCount + 1;

    var listenedValue;

    var subscription = accountBloc.followingCountStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.followingCount);

    await _update(account.copyWith(followingCount: newValue));

    expect(accountBloc.followingCount, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });
  test('followersCount', () async {
    expect(accountBloc.followersCount, account.followersCount);

    var newValue = account.followersCount + 1;

    var listenedValue;

    var subscription = accountBloc.followersCountStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, account.followersCount);

    await _update(account.copyWith(followersCount: newValue));

    expect(accountBloc.followersCount, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });

  test('displayNameEmojiText', () async {
    expect(
      accountBloc.displayNameEmojiText,
      EmojiText(
        text: account.displayName!,
        emojis: account.emojis,
      ),
    );

    var newDisplayNameValue = 'newDisplayName';

    var listenedValue;

    var subscription =
        accountBloc.displayNameEmojiTextStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(
      listenedValue,
      EmojiText(
        text: account.displayName!,
        emojis: account.emojis,
      ),
    );

    await _update(
      account.copyWith(
        displayName: newDisplayNameValue,
      ),
    );

    expect(
      accountBloc.displayNameEmojiText,
      EmojiText(
        text: newDisplayNameValue,
        emojis: account.emojis,
      ),
    );
    expect(
      listenedValue,
      EmojiText(
        text: newDisplayNameValue,
        emojis: account.emojis,
      ),
    );
    await subscription.cancel();

    var newEmojis = [
      PleromaApiEmoji(
        url: 'url',
        staticUrl: 'staticUrl',
        visibleInPicker: null,
        shortcode: null,
        category: null,
      ),
    ];

    subscription = accountBloc.displayNameEmojiTextStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(
      listenedValue,
      EmojiText(text: newDisplayNameValue, emojis: account.emojis),
    );

    await _update(
      account.copyWith(
        displayName: newDisplayNameValue,
        emojis: newEmojis,
      ),
    );

    expect(
      accountBloc.displayNameEmojiText,
      equals(
        EmojiText(
          text: newDisplayNameValue,
          emojis: newEmojis,
        ),
      ),
    );
    expect(
      listenedValue,
      equals(
        EmojiText(text: newDisplayNameValue, emojis: newEmojis),
      ),
    );
    await subscription.cancel();
  });

  test('accountRelationship', () async {
    expect(accountBloc.relationship, account.pleromaRelationship);

    var newValue =
        AccountTestHelper.createTestAccountRelationship(seed: 'seed0');

    var listenedValue;

    var subscription = accountBloc.relationshipStream!.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(accountBloc.relationship, account.pleromaRelationship);

    await _update(account.copyWith(pleromaRelationship: newValue));

    expect(accountBloc.relationship, newValue);
    expect(listenedValue, newValue);
    await subscription.cancel();
  });

  test('refreshFromNetwork', () async {
    AccountTestHelper.expectAccount(accountBloc.account, account);

    var newValue = await AccountTestHelper.createTestAccount(
      seed: 'seed2',
      remoteId: account.remoteId,
    );

    var listenedValue;

    var subscription = accountBloc.accountStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    AccountTestHelper.expectAccount(listenedValue, account);

    var newRelationship =
        AccountTestHelper.createTestAccountRelationship(seed: 'seed11');
    when(pleromaAuthAccountServiceMock.getAccount(
      accountRemoteId: account.remoteId,
      withRelationship: false,
    )).thenAnswer((_) async => newValue.toPleromaApiAccount());

    when(
      pleromaAuthAccountServiceMock.getRelationshipWithAccounts(
        remoteAccountIds: [
          account.remoteId,
        ],
      ),
    ).thenAnswer((_) async => [newRelationship]);

    await accountBloc.refreshFromNetwork(isNeedPreFetchRelationship: true);
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    AccountTestHelper.expectAccount(
      accountBloc.account,
      newValue.copyWith(pleromaRelationship: newRelationship),
    );
    AccountTestHelper.expectAccount(
      listenedValue,
      newValue.copyWith(pleromaRelationship: newRelationship),
    );
    await subscription.cancel();
  });

  test('toggleBlock', () async {
    expect(accountBloc.relationship, account.pleromaRelationship);

    IPleromaApiAccountRelationship? listenedValue;

    var subscription = accountBloc.relationshipStream!.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(accountBloc.relationship, account.pleromaRelationship);

    when(
      pleromaAuthAccountServiceMock.blockAccount(
        accountRemoteId: account.remoteId,
      ),
    ).thenAnswer(
      (_) async => account.pleromaRelationship!.copyWith(
        blocking: true,
      ),
    );

    when(
      pleromaAuthAccountServiceMock.unBlockAccount(
        accountRemoteId: account.remoteId,
      ),
    ).thenAnswer(
      (_) async => account.pleromaRelationship!.copyWith(
        blocking: false,
      ),
    );

    var initialValue = account.pleromaRelationship!.blocking!;

    await accountBloc.toggleBlock();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.blocking, !initialValue);
    expect(listenedValue!.blocking, !initialValue);

    await accountBloc.toggleBlock();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.blocking, initialValue);
    expect(listenedValue!.blocking, initialValue);

    await subscription.cancel();
  });
  test('toggleFollow', () async {
    expect(accountBloc.relationship, account.pleromaRelationship);

    IPleromaApiAccountRelationship? listenedValue;

    var subscription = accountBloc.relationshipStream!.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(accountBloc.relationship, account.pleromaRelationship);

    when(pleromaAuthAccountServiceMock.followAccount(
      accountRemoteId: account.remoteId,
    )).thenAnswer(
      (_) async => account.pleromaRelationship!.copyWith(following: true),
    );

    when(pleromaAuthAccountServiceMock.unFollowAccount(
      accountRemoteId: account.remoteId,
    )).thenAnswer((_) async => account.pleromaRelationship!.copyWith(
          following: false,
          requested: false,
        ));

    var initialValue = account.pleromaRelationship!.following!;

    await accountBloc.toggleFollow();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.following, !initialValue);
    expect(listenedValue!.following, !initialValue);

    await accountBloc.toggleFollow();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.following, initialValue);
    expect(listenedValue!.following, initialValue);

    await subscription.cancel();
  });
  test('mute & unmute', () async {
    expect(accountBloc.relationship, account.pleromaRelationship);

    IPleromaApiAccountRelationship? listenedValue;

    var subscription = accountBloc.relationshipStream!.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(accountBloc.relationship, account.pleromaRelationship);

    when(pleromaAuthAccountServiceMock.muteAccount(
      accountRemoteId: account.remoteId,
      notifications: true,
      expireDurationInSeconds: null,
    )).thenAnswer((_) async => account.pleromaRelationship!.copyWith(
          muting: true,
          mutingNotifications: true,
        ));

    when(pleromaAuthAccountServiceMock.muteAccount(
      accountRemoteId: account.remoteId,
      notifications: false,
      expireDurationInSeconds: null,
    )).thenAnswer((_) async => account.pleromaRelationship!.copyWith(
          muting: true,
          mutingNotifications: false,
        ));

    when(pleromaAuthAccountServiceMock.unMuteAccount(
      accountRemoteId: account.remoteId,
    )).thenAnswer(
      (_) async => account.pleromaRelationship!.copyWith(muting: false),
    );

    if (accountBloc.relationshipMuting == true) {
      await accountBloc.unMute();
    }

    var initialValue = account.pleromaRelationship!.muting!;

    await accountBloc.mute(
      notifications: false,
      duration: null,
    );
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.muting, !initialValue);
    expect(listenedValue!.muting, !initialValue);

    await accountBloc.unMute();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.muting, initialValue);
    expect(listenedValue!.muting, initialValue);

    await subscription.cancel();
  });
  test('togglePin', () async {
    expect(accountBloc.relationship, account.pleromaRelationship);

    IPleromaApiAccountRelationship? listenedValue;

    var subscription = accountBloc.relationshipStream!.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(accountBloc.relationship, account.pleromaRelationship);

    when(pleromaAuthAccountServiceMock.pinAccount(
      accountRemoteId: account.remoteId,
    )).thenAnswer(
      (_) async => account.pleromaRelationship!.copyWith(muting: true),
    );

    when(pleromaAuthAccountServiceMock.unPinAccount(
      accountRemoteId: account.remoteId,
    )).thenAnswer(
      (_) async => account.pleromaRelationship!.copyWith(muting: false),
    );

    var initialValue = account.pleromaRelationship!.muting!;

    await accountBloc.togglePin();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.muting, !initialValue);
    expect(listenedValue!.muting, !initialValue);

    await accountBloc.togglePin();
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));

    expect(accountBloc.relationship!.muting, initialValue);
    expect(listenedValue!.muting, initialValue);

    await subscription.cancel();
  });
}
