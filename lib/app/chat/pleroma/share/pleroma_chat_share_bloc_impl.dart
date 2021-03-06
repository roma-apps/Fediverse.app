import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/chat/pleroma/message/repository/pleroma_chat_message_repository.dart';
import 'package:fedi/app/chat/pleroma/repository/pleroma_chat_repository.dart';
import 'package:fedi/app/chat/pleroma/repository/pleroma_chat_repository_model.dart';
import 'package:fedi/app/chat/pleroma/share/pleroma_chat_share_bloc.dart';
import 'package:fedi/app/share/to_account/share_to_account_bloc_impl.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_service.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_model.dart';
import 'package:fedi/pleroma/api/chat/pleroma_api_chat_service.dart';
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart';
import 'package:fedi/repository/repository_model.dart';

abstract class PleromaChatShareBloc extends ShareToAccountBloc
    implements IPleromaChatShareBloc {
  final IPleromaChatRepository chatRepository;
  final IPleromaChatMessageRepository chatMessageRepository;
  final IPleromaApiChatService pleromaChatService;

  PleromaChatShareBloc({
    required this.chatRepository,
    required this.chatMessageRepository,
    required this.pleromaChatService,
    required IMyAccountBloc myAccountBloc,
    required IAccountRepository accountRepository,
    required IPleromaApiAccountService pleromaAccountService,
  }) : super(
          myAccountBloc: myAccountBloc,
          accountRepository: accountRepository,
          pleromaAccountService: pleromaAccountService,
        );

  @override
  Future<bool> actuallyShareToAccount(IAccount account) async {
    var messageSendDataList = await createPleromaChatMessageSendDataList();

    var targetAccounts = [account];
    List<IPleromaApiChat> pleromaChatsByAccounts;
    if (targetAccounts.isNotEmpty) {
      var chatsByAccountsFuture = targetAccounts.map(
        (account) => pleromaChatService.getOrCreateChatByAccountId(
          accountId: account.remoteId,
        ),
      );

      pleromaChatsByAccounts = await Future.wait(chatsByAccountsFuture);
      await chatRepository.upsertAllInRemoteType(
        pleromaChatsByAccounts,
        batchTransaction: null,
      );
    } else {
      pleromaChatsByAccounts = [];
    }

    var allChatsIds = pleromaChatsByAccounts
        .map(
          (pleromaChat) => pleromaChat.id,
        )
        .toList();


    // todo: think about throttling & sorting
    // perhaps send in sequence instead of parallel
    Iterable<Future<List<IPleromaApiChatMessage>>>
        pleromaChatMessagesListFuture;
    pleromaChatMessagesListFuture = allChatsIds.map(
      (chatId) {
        var futures = messageSendDataList.map(
          (messageSendData) => pleromaChatService.sendMessage(
            chatId: chatId,
            data: messageSendData,
          ),
        );

        return Future.wait(futures);
      },
    );

    List<List<IPleromaApiChatMessage>> pleromaChatMessagesList;
    pleromaChatMessagesList = await Future.wait(pleromaChatMessagesListFuture);

    var pleromaChatMessages = <IPleromaApiChatMessage>[];

    pleromaChatMessagesList.forEach(
      (List<IPleromaApiChatMessage> items) {
        pleromaChatMessages.addAll(items);
      },
    );

    await chatMessageRepository.upsertAllInRemoteType(
      pleromaChatMessages,
      batchTransaction: null,
    );

    return true;
  }

  Future<List<PleromaApiChatMessageSendData>>
      createPleromaChatMessageSendDataList();

  @override
  Future<List<IAccount>> customLocalAccountListLoader({
    required int? limit,
    required IAccount? newerThan,
    required IAccount? olderThan,
  }) async {
    if (newerThan != null || olderThan != null) {
      return [];
    }
    var chats = await chatRepository.findAllInAppType(
      filters: null,
      pagination: RepositoryPagination(
        limit: limit,
      ),
      orderingTerms: [
        PleromaChatRepositoryOrderingTermData.updatedAtDesc,
      ],
    );

    return chats.map((chat) => chat.accounts.first).toList();
  }

  @override
  Future<List<IPleromaApiAccount>> customRemoteAccountListLoader({
    required int? limit,
    required IAccount? newerThan,
    required IAccount? olderThan,
  }) async {
    if (newerThan != null || olderThan != null) {
      return [];
    }
    var pleromaChats = await pleromaChatService.getChats(
      pagination: PleromaApiPaginationRequest(
        limit: limit,
      ),
    );

    await chatRepository.upsertAllInRemoteType(
      pleromaChats,
      batchTransaction: null,
    );

    return pleromaChats
        .map(
          (pleromaChat) => pleromaChat.account,
        )
        .toList();
  }
}
