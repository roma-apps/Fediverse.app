import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_flutter/easy_dispose_flutter.dart';
import 'package:fedi/app/media/attachment/upload/list/upload_media_attachment_list_bloc.dart';
import 'package:fedi/app/media/attachment/upload/list/upload_media_attachment_list_bloc_impl.dart';
import 'package:fedi/app/media/attachment/upload/upload_media_attachment_bloc.dart';
import 'package:fedi/app/message/post_message_bloc.dart';
import 'package:fedi/app/message/post_message_model.dart';
import 'package:fedi/form/form_item_validation.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_service.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostMessageBloc extends DisposableOwner
    implements IPostMessageBloc {
  @override
  final IUploadMediaAttachmentsCollectionBloc mediaAttachmentsBloc;

  final bool unfocusOnClear;
  @override
  final int? maximumMessageLength;

  @override
  List<FormItemValidationError>? get inputTextErrors =>
      inputTextErrorsSubject.valueOrNull;

  @override
  Stream<List<FormItemValidationError>> get inputTextErrorsStream =>
      inputTextErrorsSubject.stream;

  final BehaviorSubject<List<FormItemValidationError>> inputTextErrorsSubject =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<bool> isInputFocusedSubject =
      BehaviorSubject.seeded(false);

  @override
  bool get isInputFocused => isInputFocusedSubject.value;

  @override
  Stream<bool> get isInputFocusedStream => isInputFocusedSubject.stream;

  void regenerateIdempotencyKey() {
    idempotencyKey = DateTime.now().millisecondsSinceEpoch.toString();
  }

  String? idempotencyKey;

  PostMessageBloc({
    required IPleromaApiMediaAttachmentService pleromaMediaAttachmentService,
    required int maximumMediaAttachmentCount,
    required this.maximumMessageLength,
    required int? maximumFileSizeInBytes,
    required this.unfocusOnClear,
  }) : mediaAttachmentsBloc = UploadMediaAttachmentsCollectionBloc(
          maximumMediaAttachmentCount: maximumMediaAttachmentCount,
          pleromaMediaAttachmentService: pleromaMediaAttachmentService,
          maximumFileSizeInBytes: maximumFileSizeInBytes,
        ) {
    inputTextErrorsSubject.disposeWith(this);
    mediaAttachmentsBloc.disposeWith(this);
    inputTextSubject.disposeWith(this);
    isInputFocusedSubject.disposeWith(this);
    inputFocusNode.disposeWith(this);

    isInputFocusedSubject.add(inputFocusNode.hasFocus);

    addDisposable(
      ChangeNotifierListenerDisposable(
        inputFocusNode,
        () {
          var hasFocus = inputFocusNode.hasFocus;
          isInputFocusedSubject.add(hasFocus);
        },
      ),
    );

    selectedActionSubject.disposeWith(this);
    inputTextController.disposeWith(this);

    mediaAttachmentsBloc.mediaAttachmentBlocsStream.listen(
      (_) {
        regenerateIdempotencyKey();
      },
    ).disposeWith(this);

    addDisposable(
      ChangeNotifierListenerDisposable(
        inputTextController,
        () async {
          onInputTextChanged();
        },
      ),
    );

    regenerateIdempotencyKey();
  }

  @override
  bool get isReadyToPost => calculateIsReadyToPost(
        inputText: inputText,
        mediaAttachmentBlocs: mediaAttachmentsBloc.mediaAttachmentBlocs,
        isAllAttachedMediaUploaded:
            mediaAttachmentsBloc.isAllAttachedMediaUploaded,
      );

  @override
  Stream<bool> get isReadyToPostStream => Rx.combineLatest3(
        inputTextStream,
        mediaAttachmentsBloc.mediaAttachmentBlocsStream,
        mediaAttachmentsBloc.isAllAttachedMediaUploadedStream,
        (
          dynamic inputWithoutMentionedAcctsText,
          dynamic mediaAttachmentBlocs,
          dynamic isAllAttachedMediaUploaded,
        ) =>
            calculateIsReadyToPost(
          inputText: inputWithoutMentionedAcctsText,
          mediaAttachmentBlocs: mediaAttachmentBlocs,
          isAllAttachedMediaUploaded: isAllAttachedMediaUploaded,
        ),
      );

  // ignore: close_sinks
  BehaviorSubject<String?> inputTextSubject = BehaviorSubject.seeded('');

  @override
  String? get inputText => inputTextSubject.valueOrNull;

  @override
  Stream<String?> get inputTextStream => inputTextSubject.stream;

  @override
  TextEditingController inputTextController = TextEditingController();
  @override
  FocusNode inputFocusNode = FocusNode();

  void onInputTextChanged() {
    var text = inputTextController.text;

    if (inputText != text) {
      inputTextSubject.add(text);
    }

    regenerateIdempotencyKey();
  }

  void clear() {
    inputTextController.clear();
    mediaAttachmentsBloc.clear();
    if (unfocusOnClear) {
      inputFocusNode.unfocus();
    }
    clearSelectedAction();
    isExpandedSubject.add(false);
    regenerateIdempotencyKey();
  }

  bool calculateIsReadyToPost({
    required String? inputText,
    required List<IUploadMediaAttachmentBloc>? mediaAttachmentBlocs,
    required bool? isAllAttachedMediaUploaded,
  }) {
    var textIsNotEmpty = inputText?.trim().isEmpty != true;
    var mediaAttached = mediaAttachmentBlocs?.isEmpty != true;

    return (textIsNotEmpty || mediaAttached) && isAllAttachedMediaUploaded!;
  }

  @override
  void appendText(String? textToAppend, {bool requestFocus = true}) {
    var newText = '$inputText$textToAppend';
    inputTextController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
    inputFocusNode.requestFocus();
  }

  @override
  PostMessageSelectedAction? get selectedAction => selectedActionSubject.valueOrNull;

  @override
  Stream<PostMessageSelectedAction?> get selectedActionStream =>
      selectedActionSubject.stream;

  BehaviorSubject<PostMessageSelectedAction?> selectedActionSubject =
      BehaviorSubject();

  bool get isAttachActionSelected =>
      selectedAction == PostMessageSelectedAction.attach;

  Stream<bool> get isAttachActionSelectedStream => selectedActionStream.map(
        (selectedAction) => selectedAction == PostMessageSelectedAction.attach,
      );

  bool get isEmojiActionSelected =>
      selectedAction == PostMessageSelectedAction.emoji;

  bool get isPollActionSelected =>
      selectedAction == PostMessageSelectedAction.poll;

  Stream<bool> get isEmojiActionSelectedStream => selectedActionStream.map(
        (selectedAction) => selectedAction == PostMessageSelectedAction.emoji,
      );

  @override
  void toggleAttachActionSelection() {
    if (isAttachActionSelected) {
      selectedActionSubject.add(null);
    } else {
      selectedActionSubject.add(PostMessageSelectedAction.attach);
    }
  }

  @override
  void toggleEmojiActionSelection() {
    if (isEmojiActionSelected) {
      selectedActionSubject.add(null);
    } else {
      selectedActionSubject.add(PostMessageSelectedAction.emoji);
    }
  }

  @override
  void togglePollActionSelection() {
    if (isPollActionSelected) {
      selectedActionSubject.add(null);
    } else {
      selectedActionSubject.add(PostMessageSelectedAction.poll);
    }
  }

  @override
  Stream<bool> get isAnySelectedActionVisibleStream =>
      selectedActionStream.map((selectedAction) => selectedAction != null);

  @override
  bool get isAnySelectedActionVisible => selectedAction != null;

  @override
  void clearSelectedAction() {
    selectedActionSubject.add(null);
  }

  @override
  void onFileSelected() {
    toggleAttachActionSelection();
  }

  BehaviorSubject<bool> isExpandedSubject = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get isExpandedStream => isExpandedSubject.stream;

  @override
  bool get isExpanded => isExpandedSubject.value;

  @override
  void toggleExpanded() {
    var newValue = !isExpanded;
    isExpandedSubject.add(newValue);
  }
}
