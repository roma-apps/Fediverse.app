import 'package:fedi/app/chat/conversation/conversation_chat_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'database/conversation_database_model_helper.dart';

Future<DbConversationChatWrapper> createTestConversation({
  required String seed,
  String? remoteId,
}) async =>
    DbConversationChatWrapper(
      dbConversation: await createTestDbConversation(
        seed: seed,
        remoteId: remoteId,
      ),
    );

void expectConversation(
    IConversationChat? actual, IConversationChat? expected) {
  if (actual == null && expected == null) {
    return;
  }

  expect(actual != null, true);

  expect(actual!.remoteId, expected!.remoteId);
  expect(actual.unread, expected.unread);
}
