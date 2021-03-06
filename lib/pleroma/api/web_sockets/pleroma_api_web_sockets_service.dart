import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pleroma/api/web_sockets/pleroma_api_web_sockets_model.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IPleromaApiWebSocketsService extends DisposableOwner {
  static IPleromaApiWebSocketsService of(
    BuildContext context, {
    listen = true,
  }) =>
      Provider.of(context, listen: listen);

  /// Returns events that are relevant to user with accountId
  IWebSocketsChannel<PleromaApiWebSocketsEvent> getMyAccountChannel({
    required bool notification,
    required bool chat,
  });

  /// Returns events that are relevant to the authorized user,
  /// i.e. home timeline and notifications
  IWebSocketsChannel<PleromaApiWebSocketsEvent> getAccountChannel({
    required String accountId,
    required bool notification,
  });

  /// Returns all direct events
  // todo: why we need account id here?
  IWebSocketsChannel<PleromaApiWebSocketsEvent> getDirectChannel({
    required String? accountId,
  });

  /// Returns all public events
  IWebSocketsChannel<PleromaApiWebSocketsEvent> getPublicChannel({
    required bool? onlyLocal,
    required bool? onlyRemote,
    required bool? onlyMedia,
    required String? onlyFromInstance,
  });

  /// Returns all public events for a particular hashtag
  /// local support mentioned in Mastodon docs but not implemented in Pleroma
  IWebSocketsChannel<PleromaApiWebSocketsEvent> getHashtagChannel({
    required String hashtag,
    required bool? local,
  });

  /// Return events for a list
  IWebSocketsChannel<PleromaApiWebSocketsEvent> getListChannel({
    required String listId,
  });
}
