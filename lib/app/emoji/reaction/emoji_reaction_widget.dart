import 'package:fedi/app/emoji/reaction/emoji_reaction_model.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/spacer/fedi_small_horizontal_spacer.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmojiReactionWidget extends StatelessWidget {
  const EmojiReactionWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: FediSizes.smallPadding),
      child: const _StatusEmojiReactionListItemContentWidget(),
    );
  }
}

class _StatusEmojiReactionListItemContentWidget extends StatelessWidget {
  const _StatusEmojiReactionListItemContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emojiReaction = Provider.of<IEmojiReaction>(context);
    var color = emojiReaction.me
        ? IFediUiColorTheme.of(context).primary
        : IFediUiColorTheme.of(context).lightGrey;

    return Container(
      // todo: refactor
      // ignore: no-magic-number
      height: 36.0,
      decoration: BoxDecoration(
        // todo: refactor
        // ignore: no-magic-number
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          color: color,
          // todo: refactor
          // ignore: no-magic-number
          width: 1.5,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: FediSizes.mediumPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              emojiReaction.name,
              // todo: refactor
              // ignore: no-magic-number
              style: TextStyle(fontSize: 16, height: 14 / 16),
            ),
            const FediSmallHorizontalSpacer(),
            Text(
              '${emojiReaction.count}',
              style: IFediUiTextTheme.of(context)
                  .mediumShortDarkGrey
                  .copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
