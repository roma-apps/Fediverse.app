import 'package:fedi/refactored/app/account/repository/account_repository_impl.dart';
import 'package:fedi/refactored/app/chat/message/chat_message_model.dart';
import 'package:fedi/refactored/app/database/app_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<DbChatMessagePopulated> createTestDbChatMessagePopulated(
    DbChatMessage dbChatMessage, AccountRepository accountRepository) async {
  DbChatMessagePopulated dbChatMessagePopulated = DbChatMessagePopulated(
    dbChatMessage: dbChatMessage,
    dbAccount:
        (await accountRepository.findByRemoteId(dbChatMessage.accountRemoteId))
            .dbAccount,
  );
  return dbChatMessagePopulated;
}

Future<DbChatMessage> createTestDbChatMessage({
  @required String seed,
  DateTime createdAt,
  @required DbAccount dbAccount,
  bool pleromaThreadMuted = false,
  String remoteId,
  String chatRemoteId,
}) async {
  DbChatMessage dbChatMessage = DbChatMessage(
    id: null,
    remoteId: remoteId ?? seed + "remoteId",
    createdAt: createdAt ?? DateTime(1),
    content: seed + "content",
    accountRemoteId: dbAccount.remoteId,
    emojis: null,
    chatRemoteId: chatRemoteId ?? seed + "chatRemoteId",
  );
  return dbChatMessage;
}

void expectDbChatMessagePopulated(
    IChatMessage actual, DbChatMessagePopulated expected) {
  if (actual == null && expected == null) {
    return;
  }

  expect(actual.localId != null, true);
  var dbChatMessage = expected.dbChatMessage;
  expectDbChatMessage(actual, dbChatMessage);
}

void expectDbChatMessage(IChatMessage actual, DbChatMessage expected) {
  if (actual == null && expected == null) {
    return;
  }
  expect(actual != null, true);

  expect(actual.remoteId, expected.remoteId);

  expect(actual.createdAt, expected.createdAt);
  expect(actual.content, expected.content);
  expect(actual.emojis, expected.emojis);
  expect(actual.mediaAttachment, expected.mediaAttachment);
  expect(actual.chatRemoteId, expected.chatRemoteId);
}
