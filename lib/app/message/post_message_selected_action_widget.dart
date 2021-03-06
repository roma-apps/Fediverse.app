import 'package:fedi/app/emoji/picker/emoji_picker_widget.dart';
import 'package:fedi/app/message/post_message_bloc.dart';
import 'package:fedi/app/message/post_message_model.dart';
import 'package:fedi/app/message/post_message_select_media_attachment_type_to_pick_widget.dart';
import 'package:fedi/app/status/post/poll/post_status_poll_widget.dart';
import 'package:fedi/app/ui/divider/fedi_ultra_light_grey_divider.dart';
import 'package:fedi/app/ui/fedi_padding.dart';
import 'package:flutter/widgets.dart';

class PostMessageSelectedActionWidget extends StatelessWidget {
  const PostMessageSelectedActionWidget();

  @override
  Widget build(BuildContext context) {
    var postMessageBloc = IPostMessageBloc.of(context);

    return StreamBuilder<PostMessageSelectedAction?>(
      stream: postMessageBloc.selectedActionStream,
      builder: (context, snapshot) {
        var selectedAction = snapshot.data;

        switch (selectedAction) {
          case PostMessageSelectedAction.attach:
            return const _PostMessageSelectedActionAttachWidget();
          case PostMessageSelectedAction.emoji:
            return const _PostMessageSelectedActionEmojiWidget();
          case PostMessageSelectedAction.poll:
            return const _PostMessageSelectedActionPollWidget();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _PostMessageSelectedActionPollWidget extends StatelessWidget {
  const _PostMessageSelectedActionPollWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: FediPadding.verticalBigPadding,
          child: FediUltraLightGreyDivider(),
        ),
        const Padding(
          padding: FediPadding.horizontalSmallPadding,
          child: PostStatusPollWidget(),
        ),
      ],
    );
  }
}

class _PostMessageSelectedActionEmojiWidget extends StatelessWidget {
  const _PostMessageSelectedActionEmojiWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postMessageBloc = IPostMessageBloc.of(context);

    return Column(
      children: <Widget>[
        const Padding(
          padding: FediPadding.verticalBigPadding,
          child: FediUltraLightGreyDivider(),
        ),
        EmojiPickerWidget(
          onEmojiSelected: (emoji) {
            postMessageBloc.appendText(emoji.code);
            postMessageBloc.clearSelectedAction();
          },
          useImageEmoji: true,
        ),
      ],
    );
  }
}

class _PostMessageSelectedActionAttachWidget extends StatelessWidget {
  const _PostMessageSelectedActionAttachWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: FediPadding.verticalBigPadding,
          child: FediUltraLightGreyDivider(),
        ),
        const PostMessageSelectMediaAttachmentTypeToPickWidget(),
      ],
    );
  }
}
