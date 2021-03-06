import 'package:fedi/app/emoji/reaction/emoji_reaction_model.dart';
import 'package:fedi/pleroma/api/announcement/pleroma_api_announcement_model.dart';

class InstanceAnnouncementEmojiReactionAdapter implements IEmojiReaction {
  final IPleromaApiAnnouncementReaction pleromaApiAnnouncementReaction;

  InstanceAnnouncementEmojiReactionAdapter({
    required this.pleromaApiAnnouncementReaction,
  });

  @override
  int get count => pleromaApiAnnouncementReaction.count;

  @override
  bool get me => pleromaApiAnnouncementReaction.me;

  @override
  String get name => pleromaApiAnnouncementReaction.name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstanceAnnouncementEmojiReactionAdapter &&
          runtimeType == other.runtimeType &&
          pleromaApiAnnouncementReaction ==
              other.pleromaApiAnnouncementReaction;

  @override
  int get hashCode => pleromaApiAnnouncementReaction.hashCode;

  @override
  String toString() => 'InstanceAnnouncementEmojiReactionAdapter{'
      'pleromaApiAnnouncementReaction: $pleromaApiAnnouncementReaction'
      '}';
}
