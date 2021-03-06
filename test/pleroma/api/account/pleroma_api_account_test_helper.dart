import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';

import '../emoji/pleroma_api_emoji_test_helper.dart';
import '../field/pleroma_api_field_test_helper.dart';
import '../status/pleroma_api_status_test_helper.dart';
import '../tag/pleroma_api_tag_test_helper.dart';

// ignore_for_file: no-magic-number, no-equal-arguments
class PleromaApiAccountTestHelper {
  static PleromaApiAccountRelationship createTestPleromaApiAccountRelationship({
    required String seed,
  }) =>
      PleromaApiAccountRelationship(
        blocking: seed.hashCode % 2 == 1,
        domainBlocking: seed.hashCode % 2 == 0,
        endorsed: seed.hashCode % 2 == 1,
        followedBy: seed.hashCode % 2 == 0,
        following: seed.hashCode % 2 == 1,
        id: seed + 'id',
        muting: seed.hashCode % 2 == 0,
        mutingNotifications: seed.hashCode % 2 == 1,
        requested: seed.hashCode % 2 == 0,
        showingReblogs: seed.hashCode % 2 == 1,
        subscribing: seed.hashCode % 2 == 0,
        blockedBy: seed.hashCode % 2 == 1,
        notifying: seed.hashCode % 5 == 1,
        note: seed + 'note',
      );

  static PleromaApiAccountReport createTestPleromaApiAccountReport({
    required String seed,
  }) =>
      PleromaApiAccountReport(
        account: createTestPleromaApiAccount(seed: seed + 'account'),
        statuses: [
          PleromaApiStatusTestHelper.createTestPleromaApiStatus(seed: seed + '1'),
          PleromaApiStatusTestHelper.createTestPleromaApiStatus(seed: seed + '2'),
        ],
        user: createTestPleromaApiAccount(seed: seed + 'user'),
      );

  static PleromaApiAccountPleromaPart createTestPleromaApiAccountPleromaPart({
    required String seed,
  }) =>
      PleromaApiAccountPleromaPart(
        backgroundImage: seed + 'backgroundImage',
        tags: [
          PleromaApiTagTestHelper.createTestPleromaApiTag(seed: seed + '1'),
          PleromaApiTagTestHelper.createTestPleromaApiTag(seed: seed + '2'),
        ],
        relationship: createTestPleromaApiAccountRelationship(
          seed: seed,
        ),
        isAdmin: seed.hashCode % 2 == 1,
        isModerator: seed.hashCode % 2 == 0,
        confirmationPending: seed.hashCode % 2 == 1,
        hideFavorites: seed.hashCode % 2 == 0,
        hideFollowers: seed.hashCode % 2 == 1,
        hideFollows: seed.hashCode % 2 == 0,
        hideFollowersCount: seed.hashCode % 2 == 1,
        hideFollowsCount: seed.hashCode % 2 == 0,
        deactivated: seed.hashCode % 2 == 1,
        allowFollowingMove: seed.hashCode % 2 == 0,
        skipThreadContainment: seed.hashCode % 2 == 1,
        acceptsChatMessages: seed.hashCode % 2 == 0,
        isConfirmed: seed.hashCode % 2 == 1,
        favicon: seed + 'favicon',
        apId: seed + 'apId',
        alsoKnownAs: [
          seed + 'known1',
          seed + 'known2',
        ],
      );

  static PleromaApiAccount createTestPleromaApiAccount({
    required String seed,
  }) =>
      PleromaApiAccount(
        username: seed + 'username',
        url: seed + 'url',
        statusesCount: seed.hashCode + 1,
        note: seed + 'note',
        locked: seed.hashCode % 2 == 0,
        id: seed + 'id',
        headerStatic: seed + 'headerStatic',
        header: seed + 'header',
        followingCount: seed.hashCode + 2,
        followersCount: seed.hashCode + 3,
        fields: [
          PleromaApiFieldTestHelper.createTestPleromaApiField(seed: seed + '1'),
          PleromaApiFieldTestHelper.createTestPleromaApiField(seed: seed + '2'),
        ],
        emojis: [
          PleromaApiEmojiTestHelper.createTestPleromaApiEmoji(seed: seed + '1'),
          PleromaApiEmojiTestHelper.createTestPleromaApiEmoji(seed: seed + '2'),
        ],
        displayName: seed + 'displayName',
        createdAt: DateTime(seed.hashCode % 2000),
        bot: seed.hashCode % 2 == 1,
        avatarStatic: seed + 'avatarStatic',
        avatar: seed + 'avatar',
        acct: seed + 'acct',
        pleroma: createTestPleromaApiAccountPleromaPart(
          seed: seed,
        ),
        lastStatusAt: DateTime(seed.hashCode % 2000 + 1),
        fqn: seed + 'fqn',
      );
}
