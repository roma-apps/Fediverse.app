import 'package:fedi/app/account/repository/account_repository_impl.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_model.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

Future<DbChat> createTestDbChat({
  required String seed,
  String? remoteId,
  int? unread,
  DateTime? updatedAt,
  required DbAccount dbAccount,
}) async =>
    DbChat(
      id: null,
      remoteId: remoteId ?? seed + "remoteId1",
      unread: unread ?? seed.hashCode,
      updatedAt: updatedAt ?? DateTime(seed.hashCode % 2000),
      accountRemoteId: dbAccount.remoteId,
    );

Future<DbPleromaChatPopulated> createTestDbChatPopulated(
    DbChat dbChat, AccountRepository accountRepository) async {
  DbPleromaChatPopulated dbChatPopulated = DbPleromaChatPopulated(
    dbChat: dbChat,
    dbAccount: (await accountRepository.findByRemoteId(dbChat.accountRemoteId))
        .dbAccount,
  );
  return dbChatPopulated;
}

void expectDbChat(IPleromaChat? actual, DbChat? expected) {
  if (actual == null && expected == null) {
    return;
  }

  expect(actual != null, true);

  expect(actual!.remoteId, expected!.remoteId);
  expect(actual.unread, expected.unread);
  expect(actual.updatedAt, expected.updatedAt);
}
