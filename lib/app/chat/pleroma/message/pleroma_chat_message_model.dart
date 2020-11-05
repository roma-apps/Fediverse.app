import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/chat/message/chat_message_model.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/pleroma/card/pleroma_card_model.dart';
import 'package:fedi/pleroma/emoji/pleroma_emoji_model.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:flutter/widgets.dart';

abstract class IPleromaChatMessage extends IChatMessage {
  @override
  IPleromaChatMessage copyWith({
    int localId,
    String remoteId,
    String chatRemoteId,
    IAccount account,
    String content,
    DateTime createdAt,
    List<IPleromaMediaAttachment> mediaAttachments,
    List<PleromaEmoji> emojis,
    IPleromaCard card,
  });
}

class DbChatMessagePopulatedWrapper extends IPleromaChatMessage {
  final DbChatMessagePopulated dbChatMessagePopulated;

  DbChatMessagePopulatedWrapper(this.dbChatMessagePopulated);

  @override
  int get localId => dbChatMessagePopulated.dbChatMessage.id;

  @override
  IAccount get account => DbAccountWrapper(dbChatMessagePopulated.dbAccount);

  @override
  String get chatRemoteId => dbChatMessagePopulated.dbChatMessage.chatRemoteId;

  @override
  String get content => dbChatMessagePopulated.dbChatMessage.content;

  @override
  IPleromaCard get card => dbChatMessagePopulated.dbChatMessage.card;

  @override
  DateTime get createdAt => dbChatMessagePopulated.dbChatMessage.createdAt;

  @override
  List<IPleromaEmoji> get emojis => dbChatMessagePopulated.dbChatMessage.emojis;

  @override
  String get remoteId => dbChatMessagePopulated.dbChatMessage.remoteId;

  @override
  List<IPleromaMediaAttachment> get mediaAttachments =>
      dbChatMessagePopulated.dbChatMessage.mediaAttachment != null
          ? [
              dbChatMessagePopulated.dbChatMessage.mediaAttachment,
            ]
          : null;

  @override
  DbChatMessagePopulatedWrapper copyWith({
    int localId,
    String remoteId,
    String chatRemoteId,
    IAccount account,
    String content,
    DateTime createdAt,
    List<IPleromaMediaAttachment> mediaAttachments,
    List<PleromaEmoji> emojis,
    IPleromaCard card,
  }) =>
      DbChatMessagePopulatedWrapper(dbChatMessagePopulated.copyWith(
        localId: localId,
        remoteId: remoteId,
        chatRemoteId: chatRemoteId,
        account: account,
        content: content,
        createdAt: createdAt,
        mediaAttachment: mediaAttachments?.isNotEmpty == true
            ? mediaAttachments.first
            : null,
        emojis: emojis,
        card: card,
      ));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbChatMessagePopulatedWrapper &&
          runtimeType == other.runtimeType &&
          dbChatMessagePopulated == other.dbChatMessagePopulated;

  @override
  int get hashCode => dbChatMessagePopulated.hashCode;
}

class DbChatMessagePopulated {
  final DbChatMessage dbChatMessage;
  final DbAccount dbAccount;

  DbChatMessagePopulated({
    @required this.dbChatMessage,
    @required this.dbAccount,
  });

  DbChatMessagePopulated copyWith({
    int localId,
    String remoteId,
    String chatRemoteId,
    IAccount account,
    String content,
    DateTime createdAt,
    IPleromaMediaAttachment mediaAttachment,
    List<IPleromaEmoji> emojis,
    IPleromaCard card,
  }) =>
      DbChatMessagePopulated(
          dbChatMessage: DbChatMessage(
            id: localId ?? dbChatMessage.id,
            remoteId: remoteId ?? dbChatMessage.remoteId,
            chatRemoteId: chatRemoteId ?? dbChatMessage.chatRemoteId,
            content: content ?? dbChatMessage.content,
            createdAt: createdAt ?? dbChatMessage.createdAt,
            emojis: emojis ?? dbChatMessage.emojis,
            card: card ?? dbChatMessage.card,
            mediaAttachment: mediaAttachment ?? dbChatMessage.mediaAttachment,
            accountRemoteId: account?.remoteId ?? dbAccount.remoteId,
          ),
          dbAccount:
              account != null ? dbAccountFromAccount(account) : dbAccount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbChatMessagePopulated &&
          runtimeType == other.runtimeType &&
          dbChatMessage == other.dbChatMessage &&
          dbAccount == other.dbAccount;

  @override
  int get hashCode => dbChatMessage.hashCode ^ dbAccount.hashCode;

  @override
  String toString() {
    return 'DbStatusPopulated{dbStatus: $dbChatMessage, dbAccount: $dbAccount}';
  }
}