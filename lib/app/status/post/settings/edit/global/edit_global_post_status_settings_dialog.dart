import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/settings/global/edit/edit_global_settings_dialog.dart';
import 'package:fedi/app/settings/global_or_instance/global_or_instance_settings_model.dart';
import 'package:fedi/app/status/post/settings/edit/edit_post_status_settings_bloc.dart';
import 'package:fedi/app/status/post/settings/edit/edit_post_status_settings_bloc_impl.dart';
import 'package:fedi/app/status/post/settings/edit/edit_post_status_settings_widget.dart';
import 'package:fedi/app/status/post/settings/local_preferences/global/global_post_status_settings_local_preferences_bloc.dart';
import 'package:fedi/app/status/post/settings/local_preferences/instance/instance_post_status_settings_local_preferences_bloc.dart';
import 'package:fedi/app/status/post/settings/post_status_settings_bloc.dart';
import 'package:fedi/app/status/post/settings/post_status_settings_bloc_impl.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:fedi/pleroma/visibility/pleroma_visibility_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showEditGlobalPostStatusSettingsDialog({
  required BuildContext context,
}) {
  var isPleromaInstance = ICurrentAuthInstanceBloc.of(
    context,
    listen: false,
  ).currentInstance!.isPleroma;

  showEditGlobalSettingsDialog(
    context: context,
    subTitle: S.of(context).app_status_post_settings_title,
    child: DisposableProvider<IPostStatusSettingsBloc>(
      create: (context) => PostStatusSettingsBloc(
        instanceLocalPreferencesBloc:
            IInstancePostStatusSettingsLocalPreferencesBloc.of(context,
                listen: false),
        globalLocalPreferencesBloc:
            IGlobalPostStatusSettingsLocalPreferencesBloc.of(context,
                listen: false),
      ),
      child: DisposableProxyProvider<IPostStatusSettingsBloc,
          IEditPostStatusSettingsBloc>(
        update: (context, value, previous) => EditPostStatusSettingsBloc(
          isGlobalForced: true,
          postStatusSettingsBloc: value,
          globalOrInstanceSettingsType: GlobalOrInstanceSettingsType.global,
          isEnabled: true,
          pleromaVisibilityPossibleValues: isPleromaInstance!
              ? [
                  PleromaVisibility.public,
                  PleromaVisibility.unlisted,
                  PleromaVisibility.direct,
                  PleromaVisibility.private,
                  // don't support pleroma-only visibility for global settings
                  // PleromaVisibility.list,
                  // PleromaVisibility.local,
                ]
              : [
                  PleromaVisibility.public,
                  PleromaVisibility.unlisted,
                  PleromaVisibility.direct,
                  PleromaVisibility.private,
                ],
        ),
        child: const EditPostStatusSettingsWidget(
          shrinkWrap: true,
        ),
      ),
    ),
  );
}
