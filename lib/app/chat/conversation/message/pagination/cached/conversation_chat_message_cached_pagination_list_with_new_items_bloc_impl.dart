import 'dart:async';

import 'package:fedi/app/chat/conversation/conversation_chat_bloc.dart';
import 'package:fedi/app/chat/conversation/message/conversation_chat_message_model.dart';
import 'package:fedi/app/chat/conversation/message/list/cached/conversation_chat_message_cached_list_bloc.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:fedi/pagination/cached/cached_pagination_bloc.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc_proxy_provider.dart';
import 'package:fedi/pagination/pagination_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

var _logger = Logger(
    "conversation_chat_message_cached_pagination_list_with_new_items_bloc_impl.dart");

class ConversationChatMessageCachedPaginationListWithNewItemsBloc<
        TPage extends CachedPaginationPage<IConversationChatMessage>>
    extends CachedPaginationListWithNewItemsBloc<TPage,
        IConversationChatMessage> {
  final IConversationChatMessageCachedListBloc chatMessageCachedListService;

  final IConversationChatBloc conversationChatBloc;

  ConversationChatMessageCachedPaginationListWithNewItemsBloc({
    required bool mergeNewItemsImmediately,
    required this.chatMessageCachedListService,
    required this.conversationChatBloc,
    required
        ICachedPaginationBloc<TPage, IConversationChatMessage>
            cachedPaginationBloc,
  }) : super(
          mergeNewItemsImmediately: mergeNewItemsImmediately,
          paginationBloc: cachedPaginationBloc,
        ) {
    addDisposable(
      streamSubscription:
          conversationChatBloc.onMessageLocallyHiddenStream.listen(
        (hiddenMessage) {
          hideItem(hiddenMessage);
        },
      ),
    );

    addDisposable(subject: hiddenItemsSubject);
  }

  final BehaviorSubject<List<IConversationChatMessage?>?> hiddenItemsSubject =
      BehaviorSubject.seeded([]);

  List<IConversationChatMessage?>? get hiddenItems => hiddenItemsSubject.value;

  Stream<List<IConversationChatMessage?>?> get hiddenItemsStream =>
      hiddenItemsSubject.stream;

  void hideItem(IConversationChatMessage? itemToHide) {
    hiddenItems!.add(itemToHide);
    hiddenItemsSubject.add(hiddenItems);
  }

  // todo: rework copy-paste
  @override
  List<IConversationChatMessage> get items {
    return excludeHiddenItems(super.items, hiddenItems);
  }

  @override
  Stream<List<IConversationChatMessage>> get itemsStream => Rx.combineLatest2(
    super.itemsStream,
    hiddenItemsStream,
    excludeHiddenItems,
  );

  List<IConversationChatMessage> excludeHiddenItems(
      List<IConversationChatMessage> superItems,
      List<IConversationChatMessage?>? hiddenItems,
      ) {
    if (hiddenItems!.isEmpty) {
      return superItems;
    }
    superItems.removeWhere((currentItem) =>
    hiddenItems.firstWhere(
            (hiddenItem) => isItemsEqual(hiddenItem!, currentItem),
        orElse: () => null) !=
        null);

    return superItems;
  }
  

  @override
  Stream<List<IConversationChatMessage>> watchItemsNewerThanItem(
    IConversationChatMessage item,
  ) {
    _logger.finest(() => "watchItemsNewerThanItem item = $item");
    return chatMessageCachedListService.watchLocalItemsNewerThanItem(item);
  }

  @override
  int compareItemsToSort(
    IConversationChatMessage a,
    IConversationChatMessage b,
  ) {
    if (a?.createdAt == null && b?.createdAt == null) {
      return 0;
    }

    if (a?.createdAt != null && b?.createdAt == null) {
      return 1;
    }
    if (a?.createdAt == null && b?.createdAt != null) {
      return -1;
    }
    return a.createdAt!.compareTo(b.createdAt!);
  }

  @override
  bool isItemsEqual(
    IConversationChatMessage a,
    IConversationChatMessage b,
  ) =>
      a.remoteId == b.remoteId;

  static ConversationChatMessageCachedPaginationListWithNewItemsBloc
      createFromContext(
    BuildContext context, {
    required bool mergeNewItemsImmediately,
  }) {
    return ConversationChatMessageCachedPaginationListWithNewItemsBloc(
      mergeNewItemsImmediately: true,
      chatMessageCachedListService: IConversationChatMessageCachedListBloc.of(
        context,
        listen: false,
      ),
      cachedPaginationBloc: Provider.of<
          IPaginationBloc<CachedPaginationPage<IConversationChatMessage>,
              IConversationChatMessage>>(
        context,
        listen: false,
      ) as ICachedPaginationBloc<CachedPaginationPage<IConversationChatMessage>, IConversationChatMessage>,
      conversationChatBloc: IConversationChatBloc.of(
        context,
        listen: false,
      ),
    );
  }

  static Widget provideToContext(
    BuildContext context, {
    required bool mergeNewItemsImmediately,
    required Widget child,
  }) {
    return DisposableProvider<
        ICachedPaginationListWithNewItemsBloc<
            CachedPaginationPage<IConversationChatMessage>,
            IConversationChatMessage?>>(
      create: (context) =>
          ConversationChatMessageCachedPaginationListWithNewItemsBloc
              .createFromContext(
        context,
        mergeNewItemsImmediately: mergeNewItemsImmediately,
      ),
      child: CachedPaginationListWithNewItemsBlocProxyProvider<
          CachedPaginationPage<IConversationChatMessage>,
          IConversationChatMessage>(child: child),
    );
  }
}
