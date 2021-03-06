import 'package:fedi/app/async/async_operation_button_builder_widget.dart';
import 'package:fedi/app/ui/button/icon/fedi_icon_button.dart';
import 'package:fedi/app/ui/fedi_icons.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/media/player/media_player_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FediPlayerControlToggleMuteButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaPlayerBloc = IMediaPlayerBloc.of(context);

    return StreamBuilder<bool>(
      stream: mediaPlayerBloc.isInitializedStream,
      builder: (context, snapshot) {
        var isInitialized = snapshot.data ?? false;

        if (isInitialized) {
          return const _FediPlayerControlToggleMuteButtonInitializedWidget();
        } else {
          return const _FediPlayerControlToggleMuteButtonNotInitializedWidget();
        }
      },
    );
  }

  const FediPlayerControlToggleMuteButtonWidget();
}

class _FediPlayerControlToggleMuteButtonInitializedWidget
    extends StatelessWidget {
  const _FediPlayerControlToggleMuteButtonInitializedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaPlayerBloc = IMediaPlayerBloc.of(context);

    return StreamBuilder<bool>(
      stream: mediaPlayerBloc.isMutedStream,
      builder: (context, snapshot) {
        var isMuted = snapshot.data ?? false;

        return AsyncOperationButtonBuilderWidget(
          builder: (BuildContext context, void Function()? onPressed) {
            return FediIconButton(
              icon: Icon(isMuted ? FediIcons.sound_off : FediIcons.sound_on),
              color: IFediUiColorTheme.of(context).white,
              // ignore: no-magic-number
              iconSize: 16.0,
              onPressed: onPressed,
            );
          },
          asyncButtonAction: () => mediaPlayerBloc.toggleMute(),
        );
      },
    );
  }
}

class _FediPlayerControlToggleMuteButtonNotInitializedWidget
    extends StatelessWidget {
  const _FediPlayerControlToggleMuteButtonNotInitializedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FediIconButton(
      icon: Icon(FediIcons.sound_on),
      color: IFediUiColorTheme.of(context).grey,
      // todo: refactor
      // ignore: no-magic-number
      iconSize: 16.0,
      onPressed: null,
    );
  }
}
