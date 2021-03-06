import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/chat/conversation/conversation_chat_new_messages_handler_bloc.dart';
import 'package:fedi/app/chat/conversation/repository/conversation_chat_repository.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_new_messages_handler_bloc.dart';
import 'package:fedi/app/instance/announcement/repository/instance_announcement_repository.dart';
import 'package:fedi/app/notification/repository/notification_repository.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/web_sockets/web_sockets_handler.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_model.dart';
import 'package:fedi/pleroma/api/web_sockets/pleroma_api_web_sockets_model.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel.dart';
import 'package:fedi/web_sockets/channel/web_sockets_channel_model.dart';
import 'package:fedi/web_sockets/listen_type/web_sockets_listen_type_model.dart';
import 'package:logging/logging.dart';


abstract class WebSocketsChannelHandler extends DisposableOwner
    implements IWebSocketsHandler {
  // ignore: avoid-late-keyword
  late Logger _logger;

  String get logTag;

  final IWebSocketsChannel<PleromaApiWebSocketsEvent> webSocketsChannel;
  final IStatusRepository statusRepository;
  final INotificationRepository notificationRepository;
  final IInstanceAnnouncementRepository instanceAnnouncementRepository;
  final IConversationChatRepository conversationRepository;
  final IPleromaChatNewMessagesHandlerBloc chatNewMessagesHandlerBloc;
  final IConversationChatNewMessagesHandlerBloc
      conversationChatNewMessagesHandlerBloc;

  final IMyAccountBloc myAccountBloc;

  final String? statusListRemoteId;
  final String? statusConversationRemoteId;
  final bool isFromHomeTimeline;
  final WebSocketsListenType listenType;

  WebSocketsChannelHandler({
    required this.webSocketsChannel,
    required this.statusRepository,
    required this.conversationRepository,
    required this.notificationRepository,
    required this.instanceAnnouncementRepository,
    required this.chatNewMessagesHandlerBloc,
    required this.conversationChatNewMessagesHandlerBloc,
    required this.statusListRemoteId,
    required this.statusConversationRemoteId,
    required this.myAccountBloc,
    required this.isFromHomeTimeline,
    required this.listenType,
  }) {
    _logger = Logger(logTag);
    _logger.finest(() =>
        'Start listen to ${webSocketsChannel.config.calculateWebSocketsUrl()}');

    addDisposable(webSocketsChannel.listenForEvents(
        listener: WebSocketChannelListener<PleromaApiWebSocketsEvent>(
          listenType: listenType,
          onEvent: (PleromaApiWebSocketsEvent event) {
            handleEvent(event);
          },
        ),
      ),
    );
  }

  Future handleEvent(PleromaApiWebSocketsEvent event) async {
    _logger.finest(() => 'event $event');

    // todo: report bug to pleroma
    if (event.payload == null || event.payload == 'null') {
      _logger.warning(() => 'event payload is empty');

      return;
    }

    switch (event.eventType) {
      case PleromaApiWebSocketsEventType.update:
        await statusRepository.upsertRemoteStatusWithAllArguments(
          event.parsePayloadAsStatus(),
          isFromHomeTimeline: isFromHomeTimeline,
          listRemoteId: statusListRemoteId,
          conversationRemoteId: statusConversationRemoteId,
          batchTransaction: null,
        );
        break;
      case PleromaApiWebSocketsEventType.notification:
        var notification = event.parsePayloadAsNotification();

        var pleromaNotificationType = notification.typeAsPleromaApi;
        // refresh to update followRequestCount
        if (pleromaNotificationType ==
            PleromaApiNotificationType.followRequest) {
          // ignore: unawaited_futures
            myAccountBloc.refreshFromNetwork(
              isNeedPreFetchRelationship: false,
            );
        }

        await notificationRepository.upsertRemoteNotification(
          notification,
          unread: true,
          batchTransaction: null,
        );

        var chatMessage = notification.chatMessage;
        if (chatMessage != null) {
          await chatNewMessagesHandlerBloc.handleNewMessage(chatMessage);
        }
        break;

      case PleromaApiWebSocketsEventType.announcement:
        var announcement = event.parsePayloadAsAnnouncement();

        await instanceAnnouncementRepository.upsertInRemoteType(
          announcement,
        );

        break;
      case PleromaApiWebSocketsEventType.delete:
        var statusRemoteId = event.payload!;

        await statusRepository.markStatusAsDeleted(
          statusRemoteId: statusRemoteId,
        );
        break;
      case PleromaApiWebSocketsEventType.filtersChanged:
        // nothing
        break;
      case PleromaApiWebSocketsEventType.conversation:
        await conversationChatNewMessagesHandlerBloc.handleChatUpdate(
          event.parsePayloadAsConversation(),
        );
        break;
      case PleromaApiWebSocketsEventType.pleromaChatUpdate:
        var chat = event.parsePayloadAsChat();
        await chatNewMessagesHandlerBloc.handleChatUpdate(chat);
        break;
      case PleromaApiWebSocketsEventType.unknown:
        // TODO: Handle this case.
        break;
    }
  }
}
