import 'package:fedi/app/account/avatar/account_avatar_widget.dart';
import 'package:fedi/app/account/header/account_header_bloc.dart';
import 'package:fedi/app/account/header/account_header_bloc_impl.dart';
import 'package:fedi/app/account/header/account_header_followers_count_widget.dart';
import 'package:fedi/app/account/header/account_header_following_count_widget.dart';
import 'package:fedi/app/account/header/account_header_statuses_count_widget.dart';
import 'package:fedi/app/account/info/account_info_bloc.dart';
import 'package:fedi/app/account/info/account_info_bloc_impl.dart';
import 'package:fedi/app/ui/fedi_padding.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/spacer/fedi_small_horizontal_spacer.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/ui/callback/on_click_ui_callback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAccountInfoWidget extends StatelessWidget {
  final OnClickUiCallback? onStatusesTapCallback;
  final Brightness brightness;

  MyAccountInfoWidget({
    required this.onStatusesTapCallback,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: FediPadding.allBigPadding,
        child: Row(
          children: [
            const AccountAvatarWidget(
              imageSize: FediSizes.accountAvatarBigSize,
              progressSize: FediSizes.accountAvatarProgressBigSize,
            ),
            const FediSmallHorizontalSpacer(),
            DisposableProvider<IAccountInfoBloc>(
              create: (context) => AccountInfoBloc(
                brightness: brightness,
                onStatusesTapCallback: onStatusesTapCallback,
              ),
              child:
                  DisposableProxyProvider<IAccountInfoBloc, IAccountHeaderBloc>(
                update: (context, value, _) => AccountHeaderBloc(
                  brightness: value.brightness,
                ),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const AccountHeaderStatusesCountWidget(
                        onStatusesTapCallback: _onStatusesTapCallback,
                      ),
                      const AccountHeaderFollowingCountWidget(),
                      const AccountHeaderFollowersCountWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

void _onStatusesTapCallback(BuildContext context) =>
    IAccountInfoBloc.of(context, listen: false).onStatusesTapCallback!(context);
