import 'dart:io';

import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/status/post/post_status_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';

void main() {
  AppDatabase database;

  setUp(() async {
    database = AppDatabase(VmDatabase(
        File('test_resources/app/database/fedi2_database_dump_v2.sqlite')));
  });

  tearDown(() async {
    await database.close();
  });

  test('test scheduled', () async {
    var scheduledStatusDao = database.scheduledStatusDao;
    // sqldump should have old scheduled
    expect((await scheduledStatusDao.getAll()).isNotEmpty, true);

    await scheduledStatusDao.clear();

    expect((await scheduledStatusDao.getAll()).isNotEmpty, false);

    await scheduledStatusDao.insert(DbScheduledStatus(
        scheduledAt: DateTime.now(),
        canceled: false,
        id: null,
        remoteId: "asda"));

    expect((await scheduledStatusDao.getAll()).isNotEmpty, true);
  });
  test('test draft', () async {
    var draftStatusDao = database.draftStatusDao;

    expect((await draftStatusDao.getAll()).isNotEmpty, false);

    await draftStatusDao.insert(DbDraftStatus(
        id: null,
        updatedAt: DateTime.now(),
        data: PostStatusData(
            subject: null,
            text: null,
            scheduledAt: null,
            visibility: null,
            to: null,
            mediaAttachments: null,
            poll: null,
            inReplyToPleromaStatus: null,
            inReplyToConversationId: null,
            isNsfwSensitiveEnabled: null)));

    expect((await draftStatusDao.getAll()).isNotEmpty, true);
  });
}