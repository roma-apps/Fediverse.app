import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/media/attachment/upload/upload_media_attachment_bloc.dart';
import 'package:fedi/app/media/attachment/upload/upload_media_attachment_model.dart';
import 'package:fedi/app/message/post_message_bloc_impl.dart';
import 'package:fedi/app/status/post/poll/post_status_poll_bloc.dart';
import 'package:fedi/app/status/post/poll/post_status_poll_bloc_impl.dart';
import 'package:fedi/app/status/post/post_status_bloc.dart';
import 'package:fedi/app/status/repository/status_repository.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_service.dart';
import 'package:fedi/pleroma/status/pleroma_status_model.dart';
import 'package:fedi/pleroma/status/pleroma_status_service.dart';
import 'package:fedi/pleroma/visibility/pleroma_visibility_model.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

var _logger = Logger("post_status_bloc_impl.dart");

final findAcctsRegex = RegExp(r"\B\@(([\w.@\-]+))");

abstract class PostStatusBloc extends PostMessageBloc
    implements IPostStatusBloc {
  final IPleromaStatusService pleromaStatusService;
  final IStatusRepository statusRepository;

  final String conversationRemoteId;
  @override
  final IStatus originInReplyToStatus;

  String get inReplyToStatusRemoteId => originInReplyToStatus?.remoteId;

  @override
  IPostStatusPollBloc pollBloc = PostStatusPollBloc();

  String idempotencyKey;

  @override
  IStatus get notCanceledOriginInReplyToStatus =>
      (originInReplyToStatus != null && !originInReplyToStatusCanceled)
          ? originInReplyToStatus
          : null;

  @override
  Stream<IStatus> get notCanceledOriginInReplyToStatusStream =>
      originInReplyToStatusCanceledStream.map((originInReplyToStatusCanceled) =>
          (originInReplyToStatus != null && !originInReplyToStatusCanceled)
              ? originInReplyToStatus
              : null);

  @override
  bool get originInReplyToStatusCanceled =>
      originInReplyToStatusCanceledSubject.value;

  @override
  Stream<bool> get originInReplyToStatusCanceledStream =>
      originInReplyToStatusCanceledSubject.stream;

  @override
  void cancelOriginInReplyToStatus() {
    originInReplyToStatusCanceledSubject.add(true);
  }

  BehaviorSubject<bool> originInReplyToStatusCanceledSubject =
      BehaviorSubject.seeded(false);

  final PleromaVisibility initialVisibility;

  PostStatusBloc({
    @required this.pleromaStatusService,
    @required this.statusRepository,
    @required IPleromaMediaAttachmentService pleromaMediaAttachmentService,
    this.conversationRemoteId,
    this.originInReplyToStatus,
    int maximumMediaAttachmentCount = 8,
    this.initialVisibility = PleromaVisibility.PUBLIC,
    List<IAccount> initialAccountsToMention = const [],
  }) : super(
            pleromaMediaAttachmentService: pleromaMediaAttachmentService,
            maximumMediaAttachmentCount: maximumMediaAttachmentCount) {
    visibilitySubject = BehaviorSubject.seeded(initialVisibility);
    nsfwSensitiveSubject = BehaviorSubject.seeded(false);

    addDisposable(streamSubscription:
        mediaAttachmentsBloc.mediaAttachmentBlocsStream.listen((_) {
      _regenerateIdempotencyKey();
    }));

    addDisposable(subject: originInReplyToStatusCanceledSubject);
    addDisposable(subject: selectedActionSubject);
    addDisposable(subject: mentionedAcctsSubject);
    addDisposable(subject: visibilitySubject);
    addDisposable(subject: scheduledAtSubject);

    addDisposable(disposable: pollBloc);

    var focusListener = () {
      onFocusChange(inputFocusNode.hasFocus);
    };

    inputFocusNode.addListener(focusListener);

    addDisposable(disposable: CustomDisposable(() {
      inputFocusNode.removeListener(focusListener);
    }));

    addDisposable(focusNode: subjectFocusNode);
    addDisposable(textEditingController: subjectTextController);
    addDisposable(subject: subjectTextSubject);

    var editTextListener = () {
      onSubjectTextChanged();
    };
    subjectTextController.addListener(editTextListener);

    addDisposable(disposable: CustomDisposable(() {
      subjectTextController.removeListener(editTextListener);
    }));
  }

  void onFocusChange(bool hasFocus) {
    // nothing by default
  }

  @override
  bool get isHaveMentionedAccts => mentionedAccts?.isNotEmpty == true;

  @override
  Stream<bool> get isHaveMentionedAcctsStream => mentionedAcctsStream
      .map((mentionedAccts) => mentionedAccts?.isNotEmpty == true);

  void _regenerateIdempotencyKey() {
    idempotencyKey = DateTime.now().millisecondsSinceEpoch.toString();
  }

  // ignore: close_sinks
  BehaviorSubject<List<String>> mentionedAcctsSubject =
      BehaviorSubject.seeded([]);

  @override
  List<String> get mentionedAccts => mentionedAcctsSubject.value;

  @override
  Stream<List<String>> get mentionedAcctsStream => mentionedAcctsSubject.stream;

  // ignore: close_sinks
  BehaviorSubject<DateTime> scheduledAtSubject = BehaviorSubject();

  @override
  bool get isScheduled => scheduledAt != null;

  @override
  Stream<bool> get isScheduledStream =>
      scheduledAtStream.map((scheduledAt) => scheduledAt != null);

  @override
  DateTime get scheduledAt => scheduledAtSubject.value;

  @override
  Stream<DateTime> get scheduledAtStream => scheduledAtSubject.stream;

  // ignore: close_sinks
  BehaviorSubject<PleromaVisibility> visibilitySubject;

  @override
  PleromaVisibility get visibility => visibilitySubject.value;

  @override
  Stream<PleromaVisibility> get visibilityStream => visibilitySubject.stream;

  // ignore: close_sinks
  BehaviorSubject<bool> nsfwSensitiveSubject;

  @override
  bool get isNsfwSensitiveEnabled => nsfwSensitiveSubject.value;

  @override
  Stream<bool> get isNsfwSensitiveEnabledStream => nsfwSensitiveSubject.stream;

  @override
  bool get isReadyToPost => calculateStatusBlocIsReadyToPost(
        inputText: inputWithoutMentionedAcctsText,
        mediaAttachmentBlocs: mediaAttachmentsBloc.mediaAttachmentBlocs,
        isAllAttachedMediaUploaded:
            mediaAttachmentsBloc.isAllAttachedMediaUploaded,
        isPollBlocHaveErrors: pollBloc.isHaveAtLeastOneError,
        isPollBlocChanged: pollBloc.isSomethingChanged,
      );

  @override
  Stream<bool> get isReadyToPostStream => Rx.combineLatest5(
        inputWithoutMentionedAcctsTextStream,
        mediaAttachmentsBloc.mediaAttachmentBlocsStream,
        mediaAttachmentsBloc.isAllAttachedMediaUploadedStream,
        pollBloc.isHaveAtLeastOneErrorStream,
        pollBloc.isSomethingChangedStream,
        (
          inputWithoutMentionedAcctsText,
          mediaAttachmentBlocs,
          isAllAttachedMediaUploaded,
          isHaveAtLeastOneError,
          isPollBlocChanged,
        ) =>
            calculateStatusBlocIsReadyToPost(
          inputText: inputWithoutMentionedAcctsText,
          mediaAttachmentBlocs: mediaAttachmentBlocs,
          isAllAttachedMediaUploaded: isAllAttachedMediaUploaded,
          isPollBlocHaveErrors: isHaveAtLeastOneError,
          isPollBlocChanged: isPollBlocChanged,
        ),
      );

  bool calculateStatusBlocIsReadyToPost({
    @required String inputText,
    @required List<IUploadMediaAttachmentBloc> mediaAttachmentBlocs,
    @required bool isAllAttachedMediaUploaded,
    @required bool isPollBlocHaveErrors,
    @required bool isPollBlocChanged,
  }) {
    var isReady = super.calculateIsReadyToPost(
      inputText: inputText,
      mediaAttachmentBlocs: mediaAttachmentBlocs,
      isAllAttachedMediaUploaded: isAllAttachedMediaUploaded,
    );

    return isReady && (!isPollBlocChanged || !isPollBlocHaveErrors);
  }

  @override
  String get inputWithoutMentionedAcctsText =>
      removeAcctsFromText(inputText, mentionedAccts);

  @override
  Stream<String> get inputWithoutMentionedAcctsTextStream => Rx.combineLatest2(
      inputTextStream,
      mentionedAcctsStream,
      (inputText, mentionedAccts) =>
          removeAcctsFromText(inputText, mentionedAccts));

  void onMentionedAccountsChanged() {
    var mentionedAccts = this.mentionedAccts;
    mentionedAcctsSubject.add(mentionedAccts);
    _logger.finest(() => "onMentionedAccountsChanged $mentionedAccts");
    var text = inputTextController.text;
    var textAccts = findAcctMentionsInText(text);

    var acctsToAdd =
        mentionedAccts.where((acct) => !textAccts.contains(acct)).toList();
    var acctsToRemove =
        textAccts.where((acct) => !mentionedAccts.contains(acct)).toList();
    if (acctsToAdd.isNotEmpty || acctsToRemove.isNotEmpty) {
      var newText = prependAccts(text, acctsToAdd);
      newText = removeAcctsFromText(newText, acctsToRemove);
      _logger.finest(() => "onMentionedAccountsChanged newText $newText");
      inputTextController.text = newText;
      inputTextSubject.add(newText);
    }
  }

  @override
  void onInputTextChanged() {
    var oldInputText = inputText;
    super.onInputTextChanged();
    var text = inputTextController.text;

    if (oldInputText != text) {
      var textAccts = findAcctMentionsInText(text);

      var mentionedAccts = this.mentionedAccts;
      var acctsToAdd =
          textAccts.where((acct) => !mentionedAccts.contains(acct)).toList();
      var acctsToRemove =
          mentionedAccts.where((acct) => !textAccts.contains(acct)).toList();
      if (acctsToAdd.isNotEmpty || acctsToRemove.isNotEmpty) {
        _logger.finest(() => "onInputTextChanged \n"
            "\t acctsToAdd=$acctsToAdd"
            "\t acctsToRemove=$acctsToRemove");
        mentionedAccts.addAll(acctsToAdd);
        acctsToRemove.forEach((acct) => mentionedAccts.remove(acct));
        mentionedAcctsSubject.add(mentionedAccts);
      }
      _regenerateIdempotencyKey();
    }
  }

  static List<String> findAcctMentionsInText(String text) {
    var matches = findAcctsRegex.allMatches(text);

    return matches.map((match) => // group(0) is all match
        // group(1) is acct without first @
        match.group(1)).toList();
  }

  static String prependAccts(String text, List<String> accts) {
    if (accts.isNotEmpty) {
      var acctsString = accts.map((acct) => "@$acct").join(", ");

      return "$acctsString $text";
    } else {
      return text;
    }
  }

  @override
  void addMentionByAccount(IAccount account) {
    var acct = account.acct;
    if (!mentionedAccts.contains(acct)) {
      mentionedAccts.add(acct);
      onMentionedAccountsChanged();
    }
  }

  @override
  void removeMentionByAccount(IAccount account) {
    removeMentionByAcct(account.acct);
  }

  @override
  void removeMentionByAcct(String acct) {
    if (mentionedAccts.contains(acct)) {
      mentionedAccts.remove(acct);
      onMentionedAccountsChanged();
    }
  }

  @override
  void changeVisibility(PleromaVisibility visibility) {
    visibilitySubject.add(visibility);
  }

  @override
  void changeNsfwSensitive(bool nsfwSensitive) {
    nsfwSensitiveSubject.add(nsfwSensitive);
  }

  bool isMaximumAttachmentReached(
      {@required List<IUploadMediaAttachmentBloc> mediaAttachmentBlocs,
      @required int maximumMediaAttachmentCount}) {
    return mediaAttachmentBlocs.length >= maximumMediaAttachmentCount;
  }

  @override
  Future<bool> post() async {
    bool success;
    if (isScheduled) {
      success = await _scheduleStatus();
    } else {
      success = await _postStatus();
    }

    if (success) {
      clear();
    }
    return success;
  }

  Future<bool> _postStatus() async {
    var remoteStatus = await pleromaStatusService.postStatus(
        data: PleromaPostStatus(
      mediaIds: _calculateMediaIdsField(),
      status: calculateStatusTextField(),
      sensitive: isNsfwSensitiveEnabled,
      visibility: calculateVisibilityField(),
      inReplyToId: calculateInReplyToStatusRemoteId(),
      inReplyToConversationId: conversationRemoteId,
      idempotencyKey: idempotencyKey,
      to: _calculateToField(),
      poll: _calculatePollField(),
      spoilerText: _calculateSpoilerTextField(),
    ));

    var success;
    if (remoteStatus != null) {
      await statusRepository.upsertRemoteStatus(remoteStatus,
          listRemoteId: null, conversationRemoteId: conversationRemoteId);
      await onStatusPosted(remoteStatus);
      if (inReplyToStatusRemoteId != null) {}
      success = true;
    } else {
      success = false;
    }
    if (success) {
      try {
        await statusRepository.incrementRepliesCount(
            remoteId: inReplyToStatusRemoteId);
      } catch (e, stackTrace) {
        _logger.warning(
            () => "failed to incrementRepliesCount $inReplyToStatusRemoteId",
            e,
            stackTrace);
      }
    }
    return success;
  }

  String calculateVisibilityField() =>
      pleromaVisibilityValues.reverse[visibility];

  List<String> _calculateMediaIdsField() {
    var mediaIds = mediaAttachmentsBloc.mediaAttachmentBlocs
        ?.where(
            (bloc) => bloc.uploadState == UploadMediaAttachmentState.uploaded)
        ?.map((bloc) => bloc.pleromaMediaAttachment.id)
        ?.toList();
    // media ids shouldn't be empty (should be null in this case)
    if (mediaIds?.isNotEmpty != true) {
      mediaIds = null;
    }
    return mediaIds;
  }

  Future<bool> _scheduleStatus() async {
    var scheduledStatus = await pleromaStatusService.scheduleStatus(
        data: PleromaScheduleStatus(
      mediaIds: _calculateMediaIdsField(),
      status: calculateStatusTextField(),
      sensitive: isNsfwSensitiveEnabled,
      visibility: calculateVisibilityField(),
      inReplyToId: calculateInReplyToStatusRemoteId(),
      inReplyToConversationId: conversationRemoteId,
      idempotencyKey: idempotencyKey,
      scheduledAt: scheduledAt,
      to: _calculateToField(),
      poll: _calculatePollField(),
      spoilerText: _calculateSpoilerTextField(),
    ));
    var success = scheduledStatus != null;
    return success;
  }

  @override
  void clear() {
    super.clear();

    visibilitySubject.add(initialVisibility);

    nsfwSensitiveSubject.add(false);
    _regenerateIdempotencyKey();
    clearSchedule();

    pollBloc.clear();

    subjectTextController.clear();
    subjectFocusNode.unfocus();
  }

  String removeAcctsFromText(String inputText, List<String> mentionedAccts) {
    var newText = inputText;
    // todo: better performance via Regex
    mentionedAccts?.forEach((acctToRemove) {
      newText = newText.replaceAll("@$acctToRemove, ", "");
      newText = newText.replaceAll("@$acctToRemove,", "");
      newText = newText.replaceAll(" @$acctToRemove ", "");
      newText = newText.replaceAll("@$acctToRemove", "");
    });

    return newText;
  }

  @override
  void schedule(DateTime dateTime) {
    scheduledAtSubject.add(dateTime);
  }

  @override
  void clearSchedule() {
    schedule(null);
  }

  Future onStatusPosted(IPleromaStatus remoteStatus) async {
    // nothing by default
  }

  List<String> _calculateToField() {
    if (pleromaStatusService.isPleromaInstance) {
      if (originInReplyToStatus != null && !originInReplyToStatusCanceled) {
        var inReplyToStatusAcct = originInReplyToStatus.account.acct;

        var toField = [...mentionedAccts];

        if (!toField.contains(inReplyToStatusAcct)) {
          toField.add(inReplyToStatusAcct);
        }
        return toField;
      } else {
        return mentionedAccts;
      }
    } else {
      return null;
    }
  }

  String calculateStatusTextField() {
    if (pleromaStatusService.isPleromaInstance) {
      return inputText;
    } else {
      if (originInReplyToStatus != null) {
        var inReplyToStatusAcct = originInReplyToStatus.account.acct;

        return "@${inReplyToStatusAcct} $inputText";
      } else {
        return inputText;
      }
    }
  }

  String calculateInReplyToStatusRemoteId() {
    return inReplyToStatusRemoteId;
  }

  PleromaPostStatusPoll _calculatePollField() {
    var poll;
    if (pollBloc.isSomethingChanged) {
      var expiresAt = pollBloc.expiresAtFieldBloc.currentValue;
      var expiresInSeconds =
          DateTime.now().difference(expiresAt).abs().inSeconds;

      poll = PleromaPostStatusPoll(
        expiresInSeconds: expiresInSeconds,
        multiple: pollBloc.multiplyFieldBloc.currentValue,
        options: pollBloc.pollOptionsGroupBloc.items
            .map((item) => item.currentValue)
            .toList(),
      );
    }
    return poll;
  }

  String _calculateSpoilerTextField() {
    String spoiler;

    if (subjectText?.trim()?.isNotEmpty == true) {
      spoiler = subjectText;
    }

    return spoiler;
  }

  @override
  final FocusNode subjectFocusNode = FocusNode();

  @override
  String get subjectText => subjectTextSubject.value;

  @override
  Stream<String> get subjectTextStream => subjectTextSubject.stream;

  @override
  final TextEditingController subjectTextController = TextEditingController();

  final BehaviorSubject<String> subjectTextSubject = BehaviorSubject();

  void onSubjectTextChanged() {
    var text = subjectTextController.text;

    if (subjectText != text) {
      subjectTextSubject.add(text);
    }
  }
}
