import 'package:fedi/refactored/app/account/account_model.dart';
import 'package:fedi/refactored/app/account/account_model_adapter.dart';
import 'package:fedi/refactored/app/account/repository/account_repository_impl.dart';
import 'package:fedi/refactored/app/conversation/conversation_model.dart';
import 'package:fedi/refactored/app/database/app_database.dart';
import 'package:fedi/refactored/app/status/repository/status_repository_impl.dart';
import 'package:fedi/refactored/app/status/repository/status_repository_model.dart';
import 'package:fedi/refactored/app/status/status_model.dart';
import 'package:fedi/refactored/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:fedi/refactored/pleroma/tag/pleroma_tag_model.dart';
import 'package:fedi/refactored/pleroma/visibility/pleroma_visibility_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';

import '../account/account_repository_model_helper.dart';
import 'status_repository_model_helper.dart';

final String baseUrl = "https://pleroma.com";

void main() {
  AppDatabase database;
  AccountRepository accountRepository;
  StatusRepository statusRepository;

  DbStatusPopulated dbStatusPopulated;
  DbStatus dbStatus;

  DbAccount dbAccount;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    accountRepository = AccountRepository(appDatabase: database);
    statusRepository = StatusRepository(
        appDatabase: database, accountRepository: accountRepository);

    dbAccount = createTestAccount(seed: "seed1");

    var accountId = await accountRepository.insert(dbAccount);
    // assign local id for further equal with data retrieved from db
    dbAccount = dbAccount.copyWith(id: accountId);

    dbStatus = await createTestStatus(seed: "seed3", dbAccount: dbAccount);

    dbStatusPopulated =
        await createTestStatusPopulated(dbStatus, accountRepository);
  });

  tearDown(() async {
    await database.close();
  });

  test('insert & find by id', () async {
    var id = await statusRepository.insert(dbStatus);
    assert(id != null, true);
    expectDbStatusPopulated(
        await statusRepository.findById(id), dbStatusPopulated);
  });

  test('reblog join', () async {
    var reblogDbAccount = createTestAccount(seed: "seed11");
    accountRepository.insert(reblogDbAccount);
    var reblogDbStatus =
        await createTestStatus(seed: "seed33", dbAccount: reblogDbAccount);
    var reblogStatusId = await statusRepository.insert(reblogDbStatus);

    dbStatus = dbStatus.copyWith(reblogStatusRemoteId: reblogDbStatus.remoteId);

    dbStatusPopulated = DbStatusPopulated(
        status: dbStatus,
        account: dbAccount,
        rebloggedStatus: reblogDbStatus,
        rebloggedStatusAccount: reblogDbAccount);

    assert(reblogStatusId != null, true);

    var id = await statusRepository.insert(dbStatus);
    assert(id != null, true);
    expectDbStatusPopulated(
        await statusRepository.findById(id), dbStatusPopulated);
  });

  test('upsertAll', () async {
    var dbStatus1 =
        (await createTestStatus(seed: "seed5", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId1");
    // same remote id
    var dbStatus2 =
        (await createTestStatus(seed: "seed6", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId1");

    await statusRepository.upsertAll([dbStatus1]);

    expect((await statusRepository.getAll()).length, 1);

    await statusRepository.upsertAll([dbStatus2]);
    expect((await statusRepository.getAll()).length, 1);

    expectDbStatusPopulated((await statusRepository.getAll()).first,
        await createTestStatusPopulated(dbStatus2, accountRepository));
  });

  test('updateById', () async {
    var id = await statusRepository.insert(dbStatus);
    assert(id != null, true);

    await statusRepository.updateById(
        id, dbStatus.copyWith(remoteId: "newRemoteId"));

    expect((await statusRepository.findById(id)).remoteId, "newRemoteId");
  });

  test('findByRemoteId', () async {
    await statusRepository.insert(dbStatus);
    expectDbStatusPopulated(
        await statusRepository.findByRemoteId(dbStatus.remoteId),
        dbStatusPopulated);
  });

  test('createQuery empty', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith());

    expect((await query.get()).length, 1);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith());
    expect((await query.get()).length, 2);
  });

  test('createQuery containsBaseUrlOrIsPleromaLocal', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: OnlyLocalStatusFilter("pleroma.com"),
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(pleromaLocal: false, url: "https://pleroma.com/one"));

    expect((await query.get()).length, 1);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(pleromaLocal: false, url: "https://google.com/one"));

    expect((await query.get()).length, 1);

    // check several with seed
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(pleromaLocal: false, url: "https://pleroma.com/two"));

    // check local flag
    expect((await query.get()).length, 2);
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed4", dbAccount: dbAccount))
            .copyWith(pleromaLocal: true, url: "https://google.com/one"));

    expect((await query.get()).length, 3);
  });

  test('createQuery onlyWithMedia', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: true,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(mediaAttachments: null));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(mediaAttachments: []));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(mediaAttachments: [PleromaMediaAttachment()]));

    expect((await query.get()).length, 1);
  });

  test('createQuery onlyNotMuted', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: true,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed1", dbAccount: dbAccount, pleromaThreadMuted: null))
            .copyWith(muted: true));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed2", dbAccount: dbAccount, pleromaThreadMuted: false))
            .copyWith(muted: true));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed3", dbAccount: dbAccount, pleromaThreadMuted: true))
            .copyWith(muted: false));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed4", dbAccount: dbAccount, pleromaThreadMuted: true))
            .copyWith(muted: true));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed5", dbAccount: dbAccount, pleromaThreadMuted: false))
            .copyWith(muted: false));

    expect((await query.get()).length, 1);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed6", dbAccount: dbAccount, pleromaThreadMuted: null))
            .copyWith(muted: false));

    expect((await query.get()).length, 2);
  });

  test('createQuery excludeVisibilities', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: [
          PleromaVisibility.DIRECT,
          PleromaVisibility.UNLISTED
        ],
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(visibility: PleromaVisibility.DIRECT));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(visibility: PleromaVisibility.UNLISTED));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(visibility: PleromaVisibility.PUBLIC));

    expect((await query.get()).length, 1);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed4", dbAccount: dbAccount))
            .copyWith(visibility: PleromaVisibility.LIST));

    expect((await query.get()).length, 2);
  });

  test('createQuery newerThanStatus', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: createFakePopulatedStatusWithRemoteId("remoteId5"),
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId4"));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId5"));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId6"));

    expect((await query.get()).length, 1);
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId7"));

    expect((await query.get()).length, 2);
  });

  test('createQuery notNewerThanStatus', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: createFakePopulatedStatusWithRemoteId("remoteId5"),
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId3"));

    expect((await query.get()).length, 1);
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId4"));

    expect((await query.get()).length, 2);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId5"));

    expect((await query.get()).length, 2);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId6"));

    expect((await query.get()).length, 2);
  });

  test('createQuery notNewerThanStatus & newerThanStatus', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: createFakePopulatedStatusWithRemoteId("remoteId2"),
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: createFakePopulatedStatusWithRemoteId("remoteId5"),
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId1"));

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId2"));

    expect((await query.get()).length, 0);
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId3"));

    expect((await query.get()).length, 1);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed4", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId4"));

    expect((await query.get()).length, 2);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed5", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId5"));

    expect((await query.get()).length, 2);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed6", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId6"));

    expect((await query.get()).length, 2);
  });

  test('createQuery orderingTermData remoteId asc no limit', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: StatusOrderingTermData(
            orderByType: StatusOrderByType.remoteId,
            orderingMode: OrderingMode.asc),
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    var status2 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId2"));
    var status1 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId1"));
    var status3 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId3"));

    List<DbStatusPopulated> actualList =
        (await query.map(statusRepository.dao.typedResultToPopulated).get());
    expect(actualList.length, 3);

    expectActualStatus(actualList[0], status1, dbAccount);
    expectActualStatus(actualList[1], status2, dbAccount);
    expectActualStatus(actualList[2], status3, dbAccount);
  });

  test('createQuery orderingTermData remoteId desc no limit', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: StatusOrderingTermData(
            orderByType: StatusOrderByType.remoteId,
            orderingMode: OrderingMode.desc),
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    var status2 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId2"));
    var status1 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId1"));
    var status3 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId3"));

    List<DbStatusPopulated> actualList =
        (await query.map(statusRepository.dao.typedResultToPopulated).get());
    expect(actualList.length, 3);

    expectActualStatus(actualList[0], status3, dbAccount);
    expectActualStatus(actualList[1], status2, dbAccount);
    expectActualStatus(actualList[2], status1, dbAccount);
  });

  test('createQuery orderingTermData remoteId desc & limit & offset', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: 1,
        offset: 1,
        orderingTermData: StatusOrderingTermData(
            orderByType: StatusOrderByType.remoteId,
            orderingMode: OrderingMode.desc),
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    var status2 = await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId2"));
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId1"));
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(remoteId: "remoteId3"));

    List<DbStatusPopulated> actualList =
        (await query.map(statusRepository.dao.typedResultToPopulated).get());
    expect(actualList.length, 1);

    expectActualStatus(actualList[0], status2, dbAccount);
  });

  test('createQuery onlyNoNsfwSensitive', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: true,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(sensitive: false));

    expect((await query.get()).length, 1);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(sensitive: true));
    expect((await query.get()).length, 1);
  });

  test('createQuery onlyNoReplies', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: true,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(inReplyToRemoteId: "inReplyToRemoteId"));

    expect((await query.get()).length, 0);

    var status2 = (await createTestStatus(seed: "seed2", dbAccount: dbAccount));

    // because copyWith is not possible to use with null
    var status2Json = status2.toJson();
    status2Json["inReplyToRemoteId"] = null;
    status2 = DbStatus.fromJson(status2Json);

    await insertDbStatus(statusRepository, status2);
    expect((await query.get()).length, 1);
  });

  test('createQuery onlyFromAccountsFollowingByAccount', () async {
    var accountRemoteId = "accountRemoteId";
    var accountInvalidRemoteId = "accountInvalidRemoteId";
    var followingAccountRemoteId = "followingAccountRemoteId";

    await accountRepository.updateAccountFollowings(accountRemoteId, [
      mapLocalAccountToRemoteAccount(DbAccountWrapper(
          createTestAccount(seed: followingAccountRemoteId)
              .copyWith(remoteId: followingAccountRemoteId)))
    ]);

    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: DbAccountWrapper(DbAccount(
            id: null,
            remoteId: followingAccountRemoteId,
            username: null,
            url: null,
            note: null,
            locked: null,
            headerStatic: null,
            header: null,
            followingCount: null,
            followersCount: null,
            statusesCount: null,
            displayName: null,
            createdAt: null,
            avatarStatic: null,
            avatar: null,
            acct: null,
            lastStatusAt: null)),
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed1",
                dbAccount:
                    dbAccount.copyWith(remoteId: accountInvalidRemoteId)))
            .copyWith());

    expect((await query.get()).length, 0);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed2",
                dbAccount: dbAccount.copyWith(remoteId: accountRemoteId)))
            .copyWith());

    expect((await query.get()).length, 0);
  });

  test('createQuery withHashtag', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: "#cats",
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    var dbStatus1 =
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith(tags: null);
    await statusRepository.updateStatusTags(dbStatus1.remoteId, dbStatus1.tags);
    await insertDbStatus(statusRepository, dbStatus1);

    expect((await query.get()).length, 0);

    var dbStatus2 =
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith(tags: []);
    await statusRepository.updateStatusTags(dbStatus2.remoteId, dbStatus2.tags);
    await insertDbStatus(statusRepository, dbStatus2);

    expect((await query.get()).length, 0);

    var dbStatus3 =
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith(tags: [PleromaTag(name: "#dogs")]);
    await statusRepository.updateStatusTags(dbStatus3.remoteId, dbStatus3.tags);
    await insertDbStatus(statusRepository, dbStatus3);

    expect((await query.get()).length, 0);

    var dbStatus4 =
        (await createTestStatus(seed: "seed4", dbAccount: dbAccount))
            .copyWith(tags: [
      PleromaTag(name: "#cats"),
    ]);
    await statusRepository.updateStatusTags(dbStatus4.remoteId, dbStatus4.tags);
    await insertDbStatus(statusRepository, dbStatus4);

    expect((await query.get()).length, 1);

    var dbStatus5 =
        (await createTestStatus(seed: "seed5", dbAccount: dbAccount))
            .copyWith(tags: [
      PleromaTag(name: "#dogs"),
      PleromaTag(name: "#cats"),
    ]);
    await statusRepository.updateStatusTags(dbStatus5.remoteId, dbStatus5.tags);
    await insertDbStatus(statusRepository, dbStatus5);

    expect((await query.get()).length, 2);

    var dbStatus6 =
        (await createTestStatus(seed: "seed6", dbAccount: dbAccount))
            .copyWith(tags: [
      PleromaTag(name: "#ca"),
    ]);
    await statusRepository.updateStatusTags(dbStatus6.remoteId, dbStatus6.tags);
    await insertDbStatus(statusRepository, dbStatus6);

    expect((await query.get()).length, 2);
  });

  test('createQuery onlyInListWithRemoteId', () async {
    var listWithRemoteId = "listRemoteId";
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: listWithRemoteId);

    var dbStatus1 =
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus1);

    expect((await query.get()).length, 0);

    var dbStatus2 =
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus2);
    await statusRepository
        .addStatusesToList([dbStatus2.remoteId], "invalidStatusRemoteId");

    expect((await query.get()).length, 0);

    var dbStatus3 =
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus3);
    await statusRepository
        .addStatusesToList([dbStatus3.remoteId], listWithRemoteId);

    expect((await query.get()).length, 1);

    // duplicate adding. Should be skipped
    await statusRepository
        .addStatusesToList([dbStatus3.remoteId], listWithRemoteId);
    expect((await query.get()).length, 1);

    var dbStatus4 =
        (await createTestStatus(seed: "seed4", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus4);
    await statusRepository
        .addStatusesToList([dbStatus4.remoteId], listWithRemoteId);

    expect((await query.get()).length, 2);
  });

  test('createQuery onlyInConversation', () async {
    var conversationRemoteId = "conversationRemoteId";
    var query = statusRepository.createQuery(
        onlyInConversation: DbConversationWrapper(DbConversation(
            remoteId: conversationRemoteId, unread: false, id: null)),
        onlyFromAccount: null,
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    var dbStatus1 =
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus1);

    expect((await query.get()).length, 0);

    var dbStatus2 =
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus2);
    await statusRepository.addStatusesToConversation(
        [dbStatus2.remoteId], "invalidConversationId");

    expect((await query.get()).length, 0);

    var dbStatus3 =
        (await createTestStatus(seed: "seed3", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus3);
    await statusRepository
        .addStatusesToConversation([dbStatus3.remoteId], conversationRemoteId);

    expect((await query.get()).length, 1);

    // duplicate adding. Should be skipped
    await statusRepository
        .addStatusesToConversation([dbStatus3.remoteId], conversationRemoteId);
    expect((await query.get()).length, 1);

    var dbStatus4 =
        (await createTestStatus(seed: "seed4", dbAccount: dbAccount))
            .copyWith();
    await insertDbStatus(statusRepository, dbStatus4);
    await statusRepository
        .addStatusesToConversation([dbStatus4.remoteId], conversationRemoteId);

    expect((await query.get()).length, 2);
  });

  test('createQuery onlyFromAccount', () async {
    var query = statusRepository.createQuery(
        onlyInConversation: null,
        onlyFromAccount: DbAccountWrapper(dbAccount),
        onlyWithMedia: null,
        onlyNotMuted: null,
        excludeVisibilities: null,
        newerThanStatus: null,
        limit: null,
        offset: null,
        orderingTermData: null,
        onlyNoNsfwSensitive: null,
        onlyLocal: null,
        onlyNoReplies: null,
        onlyWithHashtag: null,
        onlyFromAccountsFollowingByAccount: null,
        olderThanStatus: null,
        onlyInListWithRemoteId: null);

    expect((await query.get()).length, 0);
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed1", dbAccount: dbAccount))
            .copyWith());

    expect((await query.get()).length, 1);
    await insertDbStatus(
        statusRepository,
        (await createTestStatus(seed: "seed2", dbAccount: dbAccount))
            .copyWith());

    expect((await query.get()).length, 2);

    await insertDbStatus(
        statusRepository,
        (await createTestStatus(
                seed: "seed3",
                dbAccount: dbAccount.copyWith(remoteId: "newAccountRetmotId")))
            .copyWith());
    expect((await query.get()).length, 2);
  });
}
