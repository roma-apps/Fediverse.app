import 'package:fedi/app/push/settings/push_settings_model.dart';
import 'package:fedi/app/settings/global_or_instance/global_or_instance_settings_bloc.dart';
import 'package:fedi/app/toast/handling_type/toast_handling_type_model.dart';
import 'package:fedi/app/toast/settings/toast_settings_model.dart';
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IToastSettingsBloc
    implements IGlobalOrInstanceSettingsBloc<ToastSettings> {
  static IToastSettingsBloc of(BuildContext context, {bool listen = true}) =>
      Provider.of<IToastSettingsBloc>(context, listen: listen);

  PushSettings get pushSettings;

  Stream<PushSettings> get pushSettingsStream;

  Future changePushSettings(PushSettings pushSettings);

  bool get favourite;

  Stream<bool> get favouriteStream;

  Future changeFavourite(bool value);

  ToastHandlingType get handlingType;

  Stream<ToastHandlingType> get handlingTypeStream;

  Future changeHandlingType(ToastHandlingType value);

  bool get follow;

  Stream<bool> get followStream;

  Future changeFollow(bool value);

  bool get mention;

  Stream<bool> get mentionStream;

  Future changeMention(bool value);

  bool get reblog;

  Stream<bool> get reblogStream;

  Future changeReblog(bool value);

  bool get poll;

  Stream<bool> get pollStream;

  Future changePoll(bool value);

  bool get pleromaChatMention;

  Stream<bool> get pleromaChatMentionStream;

  Future changePleromaChatMention(bool value);

  bool get pleromaEmojiReaction;

  Stream<bool> get pleromaEmojiReactionStream;

  Future changePleromaEmojiReaction(bool value);

  bool isNotificationTypeEnabled(
    PleromaApiNotificationType pleromaNotificationType,
  );
}
