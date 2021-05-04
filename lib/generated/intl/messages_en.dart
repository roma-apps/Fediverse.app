// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(domain) => "Block domain ${domain}";

  static String m1(instanceDomain) => "Instance: ${instanceDomain}";

  static String m2(remoteInstanceDomain) => "Open on ${remoteInstanceDomain}";

  static String m3(domain) => "Unblock domain ${domain}";

  static String m4(accountAcct) => "${accountAcct} followers";

  static String m5(accountAcct) => "${accountAcct} followings";

  static String m6(userAtHost) => "Settings: ${userAtHost}";

  static String m7(number) => "Link field #${number}";

  static String m8(host) => "Forward to ${host}";

  static String m9(userAtHost) => "Report ${userAtHost}";

  static String m10(message) => "Message: ${message}";

  static String m11(content) => "${content}";

  static String m12(userAtHost) =>
      "Can\'t load ${userAtHost} instance.\nApp error or session expired";

  static String m13(userAtHost) => "${userAtHost}";

  static String m14(error) => "Details: ${error}";

  static String m15(userAtHost) => "Log out of ${userAtHost}";

  static String m16(errorDescription) =>
      "Error during login: ${errorDescription}";

  static String m17(domain) => "${domain}";

  static String m18(count) => "${count}";

  static String m19(dateTime) => "${dateTime}";

  static String m20(userAtHost) => "Clear whole cache (${userAtHost})";

  static String m21(userAtHost) => "Clear cache by limits (${userAtHost})";

  static String m22(count) =>
      "${Intl.plural(count, one: '1 new conversation. Tap to load.', other: '${count} new conversations. Tap to load.')}";

  static String m23(count) =>
      "${Intl.plural(count, one: '1 new chat. Tap to load.', other: '${count} new chats. Tap to load.')}";

  static String m24(message) => "You: ${message}";

  static String m25(count) => "Selected (${count})";

  static String m26(localDomain) => "Open on ${localDomain} inside app";

  static String m27(remoteDomain) => "Open on ${remoteDomain} in browser";

  static String m28(hashtag) => "#${hashtag}";

  static String m29(sizeInMb) => "${sizeInMb} MB";

  static String m30(instanceDomain) => "Instance: ${instanceDomain}";

  static String m31(mediaType) => "Not supported type ${mediaType}";

  static String m32(formattedFileSize, formattedMaxFileSize) =>
      "File size is ${formattedFileSize} MB, but max is ${formattedMaxFileSize} MB";

  static String m33(status) => "${status}.";

  static String m34(status) => "${status}.";

  static String m35(emoji) => "${emoji} for your post.";

  static String m36(acct) => "Report from ${acct}";

  static String m37(status) => "Unknown: ${status}";

  static String m38(count) =>
      "${Intl.plural(count, one: '1 new notification. Tap to load.', other: '${count} new notifications. Tap to load.')}";

  static String m39(dayCount) => " ${dayCount} left";

  static String m40(count) =>
      "${Intl.plural(count, zero: 'No votes', one: '1 vote', other: '${count} votes')}";

  static String m41(userAtHost) => "Настройки: ${userAtHost}";

  static String m42(remoteInstanceDomain) => "Open on ${remoteInstanceDomain}";

  static String m43(errorMessage) => "Error: ${errorMessage}";

  static String m44(count) =>
      "${Intl.plural(count, one: '1 new post. Tap to load.', other: '${count} new posts. Tap to load.')}";

  static String m45(errorMessage) => "Error: ${errorMessage}";

  static String m46(optionNumber) => "Option ${optionNumber}";

  static String m47(accountAcct) => "Replying to ${accountAcct}";

  static String m48(accountAcct) => "Reply to @${accountAcct}";

  static String m49(timeline) => "${timeline} Timeline";

  static String m50(timeline) =>
      "Are you sure you want to delete ${timeline} Timeline?";

  static String m51(errorMessage) => "Failed to init ${errorMessage}";

  static String m52(errorMessage) => "An error has occurred. \n${errorMessage}";

  static String m53(count) =>
      "${Intl.plural(count, one: '1 day', other: '${count} days')}";

  static String m54(count) =>
      "${Intl.plural(count, one: '1 hour', other: '${count} hours')}";

  static String m55(count) =>
      "${Intl.plural(count, one: '1 minute', other: '${count} minutes')}";

  static String m56(selectionCountLimit) => "Maximum ${selectionCountLimit}";

  static String m57(selectionCount) => "${selectionCount} media selected";

  static String m58(max) => "Should be not more than ${max}";

  static String m59(min, max) => "Should be between ${min} and ${max}";

  static String m60(min) => "Should be at least ${min}";

  static String m61(maxCharactersCount) =>
      "Must be less than ${maxCharactersCount} characters";

  static String m62(minCharactersCount, maxCharactersCount) =>
      "Must be between ${minCharactersCount} and ${maxCharactersCount} characters";

  static String m63(minCharactersCount) =>
      "Must be at least ${minCharactersCount} characters";

  static String m64(url) => "URL ${url} have invalid format";

  static String m65(days) =>
      "${Intl.plural(days, one: '1 d', other: '${days} d')}";

  static String m66(hours) =>
      "${Intl.plural(hours, one: '1 h', other: '${hours} h')}";

  static String m67(minutes) =>
      "${Intl.plural(minutes, one: '1 min', other: '${minutes} min')}";

  static String m68(months) =>
      "${Intl.plural(months, one: '1 mo', other: '${months} mo')}";

  static String m69(years) =>
      "${Intl.plural(years, one: '1 y', other: '${years} y')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_acccount_my_customList_edit_account_action_add":
            MessageLookupByLibrary.simpleMessage("Add"),
        "app_acccount_my_customList_edit_account_action_remove":
            MessageLookupByLibrary.simpleMessage("Remove"),
        "app_acccount_my_customList_edit_action_delete_list":
            MessageLookupByLibrary.simpleMessage("Delete list"),
        "app_acccount_my_customList_edit_action_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "app_acccount_my_customList_edit_added_header":
            MessageLookupByLibrary.simpleMessage("Added accounts"),
        "app_acccount_my_customList_edit_description":
            MessageLookupByLibrary.simpleMessage(
                "Statuses in the list are cached on the server.\nAdding or Removing accounts will affect only new posts.\n All old posts will remain on the list forever. It is only possible to add account which you follow."),
        "app_acccount_my_customList_edit_search_header":
            MessageLookupByLibrary.simpleMessage("Add to your List"),
        "app_acccount_my_customList_edit_search_hint":
            MessageLookupByLibrary.simpleMessage(
                "Search for people you follow"),
        "app_acccount_my_customList_list_action_add":
            MessageLookupByLibrary.simpleMessage("Create a list"),
        "app_acccount_my_customList_list_action_edit":
            MessageLookupByLibrary.simpleMessage("Edit list"),
        "app_acccount_my_customList_list_empty_subtitle":
            MessageLookupByLibrary.simpleMessage("Create one now."),
        "app_acccount_my_customList_list_empty_title":
            MessageLookupByLibrary.simpleMessage(
                "You haven’t created any Lists yet."),
        "app_acccount_select_suggestion_header":
            MessageLookupByLibrary.simpleMessage("Suggestion"),
        "app_account_action_block":
            MessageLookupByLibrary.simpleMessage("Block"),
        "app_account_action_blockDomain": m0,
        "app_account_action_follow":
            MessageLookupByLibrary.simpleMessage("Follow"),
        "app_account_action_followRequested":
            MessageLookupByLibrary.simpleMessage("Requested"),
        "app_account_action_instanceDetails": m1,
        "app_account_action_message":
            MessageLookupByLibrary.simpleMessage("Message"),
        "app_account_action_mute": MessageLookupByLibrary.simpleMessage("Mute"),
        "app_account_action_openInBrowser":
            MessageLookupByLibrary.simpleMessage("Open in browser"),
        "app_account_action_openOnRemoteInstance": m2,
        "app_account_action_popup_title":
            MessageLookupByLibrary.simpleMessage("More actions for:"),
        "app_account_action_report_label":
            MessageLookupByLibrary.simpleMessage("Report"),
        "app_account_action_subscribe":
            MessageLookupByLibrary.simpleMessage("Subscribe"),
        "app_account_action_unblock":
            MessageLookupByLibrary.simpleMessage("Unblock"),
        "app_account_action_unblockDomain": m3,
        "app_account_action_unfollow":
            MessageLookupByLibrary.simpleMessage("Unfollow"),
        "app_account_action_unmute":
            MessageLookupByLibrary.simpleMessage("Unmute"),
        "app_account_action_unsubscribe":
            MessageLookupByLibrary.simpleMessage("Unsubscribe"),
        "app_account_block_description": MessageLookupByLibrary.simpleMessage(
            "Blocking hides a user from your view: notifications, home and public feeds, boosting or mentioning the user. \n User can\'t follow you, user won’t see your posts in public timelines and boosts. \n If you and the blocked user are on the same server, the blocked user will not be able to view your posts on your profile while logged in."),
        "app_account_domainBlock_description": MessageLookupByLibrary.simpleMessage(
            "You won’t see notifications, boosts, posts, from that server on the public and home feeds.\n You will lose any followers that you might have had on that server.\n Usually, it is better to setup few account blocks or mutes instead of global instance block."),
        "app_account_follower_title": m4,
        "app_account_following_title": m5,
        "app_account_home_tab_menu_action_account":
            MessageLookupByLibrary.simpleMessage("Account"),
        "app_account_home_tab_menu_action_bookmarks":
            MessageLookupByLibrary.simpleMessage("Bookmarks"),
        "app_account_home_tab_menu_action_global_settings":
            MessageLookupByLibrary.simpleMessage("Settings: global"),
        "app_account_home_tab_menu_action_instance_settings": m6,
        "app_account_home_tab_menu_action_lists":
            MessageLookupByLibrary.simpleMessage("Lists"),
        "app_account_home_tab_menu_action_rateApp":
            MessageLookupByLibrary.simpleMessage("Rate app"),
        "app_account_info_followers":
            MessageLookupByLibrary.simpleMessage("Followers"),
        "app_account_info_following":
            MessageLookupByLibrary.simpleMessage("Following"),
        "app_account_info_statuses":
            MessageLookupByLibrary.simpleMessage("Statuses"),
        "app_account_info_value_hidden":
            MessageLookupByLibrary.simpleMessage("Hidden"),
        "app_account_list_privacy": MessageLookupByLibrary.simpleMessage(
            "Some information may be missed due to privacy settings"),
        "app_account_mute_description": MessageLookupByLibrary.simpleMessage(
            "Muting hides the user from your view: public and home feeds, boosting and mentioning the user.\n The user has no way of knowing they have been muted."),
        "app_account_mute_dialog_action_clearDate":
            MessageLookupByLibrary.simpleMessage("Clear date"),
        "app_account_mute_dialog_action_mute":
            MessageLookupByLibrary.simpleMessage("Mute"),
        "app_account_mute_dialog_field_expire_label":
            MessageLookupByLibrary.simpleMessage("Expire"),
        "app_account_mute_dialog_field_notifications_description":
            MessageLookupByLibrary.simpleMessage(
                "Additionally mute notifications"),
        "app_account_mute_dialog_field_notifications_label":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "app_account_mute_dialog_title":
            MessageLookupByLibrary.simpleMessage("Snooze User"),
        "app_account_mute_toast_mute_with_notifications":
            MessageLookupByLibrary.simpleMessage("Notifications muted"),
        "app_account_mute_toast_mute_without_notifications":
            MessageLookupByLibrary.simpleMessage("Notifications unmuted"),
        "app_account_my_accountBlock_action_add":
            MessageLookupByLibrary.simpleMessage("Add to blocked list"),
        "app_account_my_accountBlock_action_block":
            MessageLookupByLibrary.simpleMessage("Block"),
        "app_account_my_accountBlock_action_unblock":
            MessageLookupByLibrary.simpleMessage("Unblock"),
        "app_account_my_accountBlock_title":
            MessageLookupByLibrary.simpleMessage("Account blocks"),
        "app_account_my_accountMute_action_add":
            MessageLookupByLibrary.simpleMessage("Add to muted list"),
        "app_account_my_accountMute_action_mute":
            MessageLookupByLibrary.simpleMessage("Mute"),
        "app_account_my_accountMute_action_unmute":
            MessageLookupByLibrary.simpleMessage("Unmute"),
        "app_account_my_accountMute_title":
            MessageLookupByLibrary.simpleMessage("Account mutes"),
        "app_account_my_action_accountBlocks":
            MessageLookupByLibrary.simpleMessage("Account blocks"),
        "app_account_my_action_accountMutes":
            MessageLookupByLibrary.simpleMessage("Account mutes"),
        "app_account_my_action_bookmarked":
            MessageLookupByLibrary.simpleMessage("Bookmarks"),
        "app_account_my_action_domainBlocks":
            MessageLookupByLibrary.simpleMessage("Domain blocks"),
        "app_account_my_action_draftPosts":
            MessageLookupByLibrary.simpleMessage("Draft posts"),
        "app_account_my_action_edit":
            MessageLookupByLibrary.simpleMessage("Edit profile"),
        "app_account_my_action_favourited":
            MessageLookupByLibrary.simpleMessage("Favourites"),
        "app_account_my_action_filters":
            MessageLookupByLibrary.simpleMessage("Filters"),
        "app_account_my_action_followRequests":
            MessageLookupByLibrary.simpleMessage("Follow requests"),
        "app_account_my_action_lists":
            MessageLookupByLibrary.simpleMessage("Lists"),
        "app_account_my_action_scheduledPosts":
            MessageLookupByLibrary.simpleMessage("Scheduled posts"),
        "app_account_my_customList_list_title":
            MessageLookupByLibrary.simpleMessage("Lists"),
        "app_account_my_domainBlock_action_add":
            MessageLookupByLibrary.simpleMessage("Add to blocked list"),
        "app_account_my_domainBlock_action_block":
            MessageLookupByLibrary.simpleMessage("Block"),
        "app_account_my_domainBlock_action_unblock":
            MessageLookupByLibrary.simpleMessage("Unblock"),
        "app_account_my_domainBlock_add_dialog_field_domain_hint":
            MessageLookupByLibrary.simpleMessage("mastodon.social"),
        "app_account_my_domainBlock_add_dialog_title":
            MessageLookupByLibrary.simpleMessage("Add domain block"),
        "app_account_my_domainBlock_title":
            MessageLookupByLibrary.simpleMessage("Domain blocks"),
        "app_account_my_edit_action_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "app_account_my_edit_field_avatar_dialog_action_selectAndCrop":
            MessageLookupByLibrary.simpleMessage("Select & crop"),
        "app_account_my_edit_field_avatar_dialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm selection?"),
        "app_account_my_edit_field_backgroundImage_action_add":
            MessageLookupByLibrary.simpleMessage("Add"),
        "app_account_my_edit_field_backgroundImage_label":
            MessageLookupByLibrary.simpleMessage("Background image"),
        "app_account_my_edit_field_bot_description":
            MessageLookupByLibrary.simpleMessage(
                "Mark if current account is bot"),
        "app_account_my_edit_field_bot_label":
            MessageLookupByLibrary.simpleMessage("Bot"),
        "app_account_my_edit_field_customField_action_addNew":
            MessageLookupByLibrary.simpleMessage("Add link field"),
        "app_account_my_edit_field_customField_label": m7,
        "app_account_my_edit_field_customField_name_label":
            MessageLookupByLibrary.simpleMessage("Name*"),
        "app_account_my_edit_field_customField_value_label":
            MessageLookupByLibrary.simpleMessage("URL*"),
        "app_account_my_edit_field_discoverable_description":
            MessageLookupByLibrary.simpleMessage(
                "Search engines & Profile directory"),
        "app_account_my_edit_field_discoverable_label":
            MessageLookupByLibrary.simpleMessage("Discoverable"),
        "app_account_my_edit_field_displayName_hint":
            MessageLookupByLibrary.simpleMessage("John Smith"),
        "app_account_my_edit_field_displayName_label":
            MessageLookupByLibrary.simpleMessage("Display name*"),
        "app_account_my_edit_field_header_dialog_action_crop":
            MessageLookupByLibrary.simpleMessage("Crop"),
        "app_account_my_edit_field_header_dialog_action_select":
            MessageLookupByLibrary.simpleMessage("Select"),
        "app_account_my_edit_field_header_dialog_title":
            MessageLookupByLibrary.simpleMessage("Confirm selection?"),
        "app_account_my_edit_field_locked_description":
            MessageLookupByLibrary.simpleMessage(
                "You should manually approve follow requests"),
        "app_account_my_edit_field_locked_label":
            MessageLookupByLibrary.simpleMessage("Locked to followers only"),
        "app_account_my_edit_field_note_hint":
            MessageLookupByLibrary.simpleMessage(
                "Your bio and links to your pages"),
        "app_account_my_edit_field_note_label":
            MessageLookupByLibrary.simpleMessage("Note"),
        "app_account_my_edit_field_pleroma_acceptsChatMessages_description":
            MessageLookupByLibrary.simpleMessage(
                "Disable to reject all messages"),
        "app_account_my_edit_field_pleroma_acceptsChatMessages_label":
            MessageLookupByLibrary.simpleMessage("Accepts chat messages"),
        "app_account_my_edit_field_pleroma_allowFollowingMove_description":
            MessageLookupByLibrary.simpleMessage(
                "Automatically follow moved accounts"),
        "app_account_my_edit_field_pleroma_allowFollowingMove_label":
            MessageLookupByLibrary.simpleMessage("Allow following move"),
        "app_account_my_edit_field_pleroma_background_dialog_action_crop":
            MessageLookupByLibrary.simpleMessage("Crop"),
        "app_account_my_edit_field_pleroma_background_dialog_action_select":
            MessageLookupByLibrary.simpleMessage("Select"),
        "app_account_my_edit_field_pleroma_background_dialog_title":
            MessageLookupByLibrary.simpleMessage("Pleroma background"),
        "app_account_my_edit_field_pleroma_hideFavourites_description":
            MessageLookupByLibrary.simpleMessage(
                "Only private access to favourites list"),
        "app_account_my_edit_field_pleroma_hideFavourites_label":
            MessageLookupByLibrary.simpleMessage("Hide favourites"),
        "app_account_my_edit_field_pleroma_hideFollowersCount_description":
            MessageLookupByLibrary.simpleMessage(
                "Display \'0\' as followers count"),
        "app_account_my_edit_field_pleroma_hideFollowersCount_label":
            MessageLookupByLibrary.simpleMessage("Hide followers count"),
        "app_account_my_edit_field_pleroma_hideFollowers_description":
            MessageLookupByLibrary.simpleMessage(
                "Only private access to followers list"),
        "app_account_my_edit_field_pleroma_hideFollowers_label":
            MessageLookupByLibrary.simpleMessage("Hide followers"),
        "app_account_my_edit_field_pleroma_hideFollowsCount_description":
            MessageLookupByLibrary.simpleMessage(
                "Display \'0\' as follows count"),
        "app_account_my_edit_field_pleroma_hideFollowsCount_label":
            MessageLookupByLibrary.simpleMessage("Hide follows count"),
        "app_account_my_edit_field_pleroma_hideFollows_description":
            MessageLookupByLibrary.simpleMessage(
                "Only private access to follows list"),
        "app_account_my_edit_field_pleroma_hideFollows_label":
            MessageLookupByLibrary.simpleMessage("Hide follows"),
        "app_account_my_edit_field_pleroma_noRichText_description":
            MessageLookupByLibrary.simpleMessage("Strip html tags"),
        "app_account_my_edit_field_pleroma_noRichText_label":
            MessageLookupByLibrary.simpleMessage("Ignore rich text"),
        "app_account_my_edit_field_pleroma_showRole_description":
            MessageLookupByLibrary.simpleMessage("e.g. Admin, Moderator"),
        "app_account_my_edit_field_pleroma_showRole_label":
            MessageLookupByLibrary.simpleMessage("Show role"),
        "app_account_my_edit_field_pleroma_skipThreadContainment_description":
            MessageLookupByLibrary.simpleMessage("Ignore broken threads"),
        "app_account_my_edit_field_pleroma_skipThreadContainment_label":
            MessageLookupByLibrary.simpleMessage("Skip thread containment"),
        "app_account_my_edit_title":
            MessageLookupByLibrary.simpleMessage("Edit account"),
        "app_account_my_edit_unsaved_dialog_action_discard":
            MessageLookupByLibrary.simpleMessage("Discard"),
        "app_account_my_edit_unsaved_dialog_title":
            MessageLookupByLibrary.simpleMessage("You have unsaved changes"),
        "app_account_my_followRequest_action_add":
            MessageLookupByLibrary.simpleMessage("Add"),
        "app_account_my_followRequest_action_ignore":
            MessageLookupByLibrary.simpleMessage("Ignore"),
        "app_account_my_followRequest_empty_title":
            MessageLookupByLibrary.simpleMessage(
                "You don’t have any pending requests."),
        "app_account_my_followRequest_title":
            MessageLookupByLibrary.simpleMessage("Follow requests"),
        "app_account_my_menu_account_subpage_title":
            MessageLookupByLibrary.simpleMessage("Account"),
        "app_account_my_statuses_bookmarked_empty_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "When you do, they will show up here."),
        "app_account_my_statuses_bookmarked_empty_title":
            MessageLookupByLibrary.simpleMessage(
                "You haven’t bookmarked any posts yet."),
        "app_account_my_statuses_bookmarked_title":
            MessageLookupByLibrary.simpleMessage("Bookmarks"),
        "app_account_my_statuses_draft_empty_title":
            MessageLookupByLibrary.simpleMessage(
                "You haven’t drafted any posts yet."),
        "app_account_my_statuses_draft_status_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_account_my_statuses_draft_status_action_edit":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "app_account_my_statuses_draft_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "When you do, they will show up here."),
        "app_account_my_statuses_draft_title":
            MessageLookupByLibrary.simpleMessage("Drafts"),
        "app_account_my_statuses_favourited_empty_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "When you do, they will show up here."),
        "app_account_my_statuses_favourited_empty_title":
            MessageLookupByLibrary.simpleMessage(
                "You haven’t liked any posts yet."),
        "app_account_my_statuses_favourited_title":
            MessageLookupByLibrary.simpleMessage("Favourites"),
        "app_account_my_statuses_scheduled_empty_title":
            MessageLookupByLibrary.simpleMessage(
                "You haven’t scheduled any posts yet."),
        "app_account_my_statuses_scheduled_status_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_account_my_statuses_scheduled_status_action_edit":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "app_account_my_statuses_scheduled_subtitle":
            MessageLookupByLibrary.simpleMessage(
                "When you do, they will show up here."),
        "app_account_my_statuses_scheduled_title":
            MessageLookupByLibrary.simpleMessage("Queue"),
        "app_account_report_action_send":
            MessageLookupByLibrary.simpleMessage("Send"),
        "app_account_report_description": MessageLookupByLibrary.simpleMessage(
            "Report will be send to server moderators"),
        "app_account_report_forward_label": m8,
        "app_account_report_message_hint":
            MessageLookupByLibrary.simpleMessage("Additional comments"),
        "app_account_report_message_label":
            MessageLookupByLibrary.simpleMessage("Message"),
        "app_account_report_title": m9,
        "app_account_report_toast_fail":
            MessageLookupByLibrary.simpleMessage("Failed to report"),
        "app_account_report_toast_success":
            MessageLookupByLibrary.simpleMessage("Successfully reported"),
        "app_account_select_recent_empty": MessageLookupByLibrary.simpleMessage(
            "You don’t have recent accounts selection"),
        "app_account_select_recent_header":
            MessageLookupByLibrary.simpleMessage("Recent"),
        "app_account_statuses_tab_favourites":
            MessageLookupByLibrary.simpleMessage("Favourites"),
        "app_account_statuses_tab_favourites_accessRestricted":
            MessageLookupByLibrary.simpleMessage(
                "User restricted access to it\'s favourites"),
        "app_account_statuses_tab_media":
            MessageLookupByLibrary.simpleMessage("Media"),
        "app_account_statuses_tab_pinned":
            MessageLookupByLibrary.simpleMessage("Pinned"),
        "app_account_statuses_tab_withReplies":
            MessageLookupByLibrary.simpleMessage("Including replies"),
        "app_account_statuses_tab_withoutReplies":
            MessageLookupByLibrary.simpleMessage("Posts"),
        "app_appStore_description": MessageLookupByLibrary.simpleMessage(
            "A beautiful and lightweight Pleroma and Mastodon client: - push notifications support; - emoji reactions on Pleroma instances; - Direct Messages support on Mastodon and Chats on Pleroma instances; - uploading any media files; - offline access to cached data and images; - multi-accounts and multi instances support.  You can connect any Pleroma or Mastodon instance or create account on fedi.app."),
        "app_appStore_promotionalText": MessageLookupByLibrary.simpleMessage(
            "A client for Pleroma and Mastodon social network instances"),
        "app_appStore_subtitle": MessageLookupByLibrary.simpleMessage(
            "A client for Pleroma and Mastodon social network instances"),
        "app_appStore_title": MessageLookupByLibrary.simpleMessage(
            "Fedi for Pleroma and Mastodon"),
        "app_async_pleroma_error_common_dialog_content": m10,
        "app_async_pleroma_error_common_dialog_title":
            MessageLookupByLibrary.simpleMessage("Pleroma API error"),
        "app_async_pleroma_error_forbidden_dialog_content": m11,
        "app_async_pleroma_error_forbidden_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Forbidden. Invalid action or session expired"),
        "app_async_pleroma_error_throttled_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Too much operations per minute. Please wait before do something again."),
        "app_async_pleroma_error_throttled_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Throttled. Server blocked action."),
        "app_async_socket_error_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "No network or remote server unavailable"),
        "app_async_socket_error_dialog_title":
            MessageLookupByLibrary.simpleMessage("Check your connection"),
        "app_async_timeout_error_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "No network or remote server unavailable"),
        "app_async_timeout_error_dialog_title":
            MessageLookupByLibrary.simpleMessage("Timeout reached"),
        "app_auth_instance_chooser_action_addInstance":
            MessageLookupByLibrary.simpleMessage("Add account"),
        "app_auth_instance_current_context_loading_cantLoad_action_chooseDifferentAccount":
            MessageLookupByLibrary.simpleMessage("Choose different account"),
        "app_auth_instance_current_context_loading_cantLoad_action_logout":
            MessageLookupByLibrary.simpleMessage("Logout"),
        "app_auth_instance_current_context_loading_cantLoad_action_refresh":
            MessageLookupByLibrary.simpleMessage("Refresh"),
        "app_auth_instance_current_context_loading_cantLoad_content": m12,
        "app_auth_instance_current_context_loading_loading_content": m13,
        "app_auth_instance_current_context_loading_loading_title":
            MessageLookupByLibrary.simpleMessage("Loading Instance"),
        "app_auth_instance_join_action_login":
            MessageLookupByLibrary.simpleMessage("Login"),
        "app_auth_instance_join_action_signUp":
            MessageLookupByLibrary.simpleMessage("Sign up"),
        "app_auth_instance_join_action_tos_postfix":
            MessageLookupByLibrary.simpleMessage("."),
        "app_auth_instance_join_action_tos_prefix":
            MessageLookupByLibrary.simpleMessage(
                "By using Fedi, you agree to our"),
        "app_auth_instance_join_action_tos_terms":
            MessageLookupByLibrary.simpleMessage("Terms"),
        "app_auth_instance_join_fail_dialog_content": m14,
        "app_auth_instance_join_fail_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Fail to connect to instance. You can try verified fedi.app or pleroma.com"),
        "app_auth_instance_join_field_host_helper":
            MessageLookupByLibrary.simpleMessage(
                "Pleroma or Mastodon Instance"),
        "app_auth_instance_join_field_host_hint":
            MessageLookupByLibrary.simpleMessage("Fedi.app"),
        "app_auth_instance_join_invitesOnly_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Try any other instance, or register by invite link in your browser"),
        "app_auth_instance_join_invitesOnly_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Instance owner limit registration to invites-only"),
        "app_auth_instance_join_new_title":
            MessageLookupByLibrary.simpleMessage("Join new instance"),
        "app_auth_instance_join_progress_dialog_content":
            MessageLookupByLibrary.simpleMessage("Checking instance"),
        "app_auth_instance_join_registrationDisabled_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Try any other instance, like fedi.app"),
        "app_auth_instance_join_registrationDisabled_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Instance owner disabled registration"),
        "app_auth_instance_logout_dialog_content": m15,
        "app_auth_instance_logout_dialog_title":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "app_auth_instance_register_action_createAccount":
            MessageLookupByLibrary.simpleMessage("Sign up"),
        "app_auth_instance_register_approvalRequired_notification_content":
            MessageLookupByLibrary.simpleMessage(
                "You can login once moderators will approve your account"),
        "app_auth_instance_register_approvalRequired_notification_title":
            MessageLookupByLibrary.simpleMessage("Success registration"),
        "app_auth_instance_register_cantLogin_notification_content": m16,
        "app_auth_instance_register_cantLogin_notification_title":
            MessageLookupByLibrary.simpleMessage("Success registration"),
        "app_auth_instance_register_emailConfirmationRequired_notification_content":
            MessageLookupByLibrary.simpleMessage(
                "Please confirm email before login"),
        "app_auth_instance_register_emailConfirmationRequired_notification_title":
            MessageLookupByLibrary.simpleMessage("Success registration"),
        "app_auth_instance_register_field_acceptTermsOfService_description":
            m17,
        "app_auth_instance_register_field_acceptTermsOfService_label":
            MessageLookupByLibrary.simpleMessage("Accept Terms of Service"),
        "app_auth_instance_register_field_captcha_hint":
            MessageLookupByLibrary.simpleMessage("Characters from picture"),
        "app_auth_instance_register_field_captcha_label":
            MessageLookupByLibrary.simpleMessage("Captcha*"),
        "app_auth_instance_register_field_confirmPassword_hint":
            MessageLookupByLibrary.simpleMessage("Password"),
        "app_auth_instance_register_field_confirmPassword_label":
            MessageLookupByLibrary.simpleMessage("Password confirmation*"),
        "app_auth_instance_register_field_email_hint":
            MessageLookupByLibrary.simpleMessage("you@example.com"),
        "app_auth_instance_register_field_email_label":
            MessageLookupByLibrary.simpleMessage("Email Address*"),
        "app_auth_instance_register_field_locale_description":
            MessageLookupByLibrary.simpleMessage(
                "Default language for your statuses and confirmation email"),
        "app_auth_instance_register_field_locale_label":
            MessageLookupByLibrary.simpleMessage("Locale"),
        "app_auth_instance_register_field_password_hint":
            MessageLookupByLibrary.simpleMessage("Password"),
        "app_auth_instance_register_field_password_label":
            MessageLookupByLibrary.simpleMessage("Password*"),
        "app_auth_instance_register_field_reason_hint":
            MessageLookupByLibrary.simpleMessage(
                "Will be reviewed by moderators"),
        "app_auth_instance_register_field_reason_label":
            MessageLookupByLibrary.simpleMessage("Reason (optional)"),
        "app_auth_instance_register_field_username_hint":
            MessageLookupByLibrary.simpleMessage("lain"),
        "app_auth_instance_register_field_username_label":
            MessageLookupByLibrary.simpleMessage("Username*"),
        "app_auth_instance_register_title":
            MessageLookupByLibrary.simpleMessage("Create account"),
        "app_cache_database_settings_currentEntriesCountByType_label":
            MessageLookupByLibrary.simpleMessage(
                "Current max entries count by type"),
        "app_cache_database_settings_currentEntriesCountByType_value": m18,
        "app_cache_database_settings_currentMaxAge_label":
            MessageLookupByLibrary.simpleMessage("Current max age"),
        "app_cache_database_settings_currentMaxAge_value": m19,
        "app_cache_database_settings_description":
            MessageLookupByLibrary.simpleMessage(
                "Accounts, statuses, conversation, notifications and chats. Huge limits may cause bad performance due to complex calculations for big amount of data.\n Exceed limits data will be deleted on each app start."),
        "app_cache_database_settings_limitAge_label":
            MessageLookupByLibrary.simpleMessage("Age limit"),
        "app_cache_database_settings_limitAge_value_days180":
            MessageLookupByLibrary.simpleMessage("180 days"),
        "app_cache_database_settings_limitAge_value_days30":
            MessageLookupByLibrary.simpleMessage("30 days"),
        "app_cache_database_settings_limitAge_value_days365":
            MessageLookupByLibrary.simpleMessage("1 year"),
        "app_cache_database_settings_limitAge_value_days7":
            MessageLookupByLibrary.simpleMessage("7 days"),
        "app_cache_database_settings_limitAge_value_days90":
            MessageLookupByLibrary.simpleMessage("90 days"),
        "app_cache_database_settings_limitAge_value_notSet":
            MessageLookupByLibrary.simpleMessage("No"),
        "app_cache_database_settings_limitEntriesCountByType_label":
            MessageLookupByLibrary.simpleMessage(
                "Entries count per type limit"),
        "app_cache_database_settings_limitEntriesCountByType_value_limit1000":
            MessageLookupByLibrary.simpleMessage("1000 entries"),
        "app_cache_database_settings_limitEntriesCountByType_value_limit10000":
            MessageLookupByLibrary.simpleMessage("10000 entries"),
        "app_cache_database_settings_limitEntriesCountByType_value_limit100000":
            MessageLookupByLibrary.simpleMessage("100000 entries"),
        "app_cache_database_settings_limitEntriesCountByType_value_limit5000":
            MessageLookupByLibrary.simpleMessage("5000 entries"),
        "app_cache_database_settings_limitEntriesCountByType_value_notSet":
            MessageLookupByLibrary.simpleMessage("No"),
        "app_cache_database_settings_title":
            MessageLookupByLibrary.simpleMessage("Databаse cache"),
        "app_cache_files_settings_description":
            MessageLookupByLibrary.simpleMessage(
                "Exceed limits data will be deleted on each app start."),
        "app_cache_files_settings_limitAge_label":
            MessageLookupByLibrary.simpleMessage("Age limit"),
        "app_cache_files_settings_limitAge_value_days180":
            MessageLookupByLibrary.simpleMessage("180 days"),
        "app_cache_files_settings_limitAge_value_days30":
            MessageLookupByLibrary.simpleMessage("30 days"),
        "app_cache_files_settings_limitAge_value_days365":
            MessageLookupByLibrary.simpleMessage("1 year"),
        "app_cache_files_settings_limitAge_value_days7":
            MessageLookupByLibrary.simpleMessage("7 days"),
        "app_cache_files_settings_limitAge_value_days90":
            MessageLookupByLibrary.simpleMessage("90 days"),
        "app_cache_files_settings_limitAge_value_notSet":
            MessageLookupByLibrary.simpleMessage("No"),
        "app_cache_files_settings_sizeLimit_label":
            MessageLookupByLibrary.simpleMessage("Objects count limit"),
        "app_cache_files_settings_sizeLimit_value_notSet":
            MessageLookupByLibrary.simpleMessage("No"),
        "app_cache_files_settings_sizeLimit_value_size100":
            MessageLookupByLibrary.simpleMessage("100"),
        "app_cache_files_settings_sizeLimit_value_size1000":
            MessageLookupByLibrary.simpleMessage("1000"),
        "app_cache_files_settings_sizeLimit_value_size10000":
            MessageLookupByLibrary.simpleMessage("10000"),
        "app_cache_files_settings_sizeLimit_value_size200":
            MessageLookupByLibrary.simpleMessage("200"),
        "app_cache_files_settings_sizeLimit_value_size50":
            MessageLookupByLibrary.simpleMessage("50"),
        "app_cache_files_settings_sizeLimit_value_size500":
            MessageLookupByLibrary.simpleMessage("500"),
        "app_cache_files_settings_title":
            MessageLookupByLibrary.simpleMessage("Files cache"),
        "app_cache_settings_action_clear_all_now": m20,
        "app_cache_settings_action_clear_by_limits_now": m21,
        "app_chat_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_chat_action_delete_dialog_content":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "app_chat_action_delete_dialog_title":
            MessageLookupByLibrary.simpleMessage("Delete conversation"),
        "app_chat_conversation_accounts_title":
            MessageLookupByLibrary.simpleMessage("Conversation accounts"),
        "app_chat_conversation_list_newItems_action_tapToLoadNew": m22,
        "app_chat_conversation_share_title":
            MessageLookupByLibrary.simpleMessage("Share to conversations"),
        "app_chat_conversation_start_title":
            MessageLookupByLibrary.simpleMessage("Start conversation"),
        "app_chat_list_newItems_action_tapToLoadNew": m23,
        "app_chat_message_deleted_desc":
            MessageLookupByLibrary.simpleMessage("Message deleted"),
        "app_chat_message_pending_actions_dialog_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete message"),
        "app_chat_message_pending_actions_dialog_action_resend":
            MessageLookupByLibrary.simpleMessage("Send again"),
        "app_chat_message_pending_actions_dialog_title":
            MessageLookupByLibrary.simpleMessage("Pending message"),
        "app_chat_message_pending_desc":
            MessageLookupByLibrary.simpleMessage("Message pending."),
        "app_chat_message_pending_failed_desc":
            MessageLookupByLibrary.simpleMessage("Message failed to send."),
        "app_chat_message_pending_tapToViewOptions":
            MessageLookupByLibrary.simpleMessage("Tap to view options."),
        "app_chat_pleroma_account_notAcceptsChatMessages_toast":
            MessageLookupByLibrary.simpleMessage("User disabled chat feature"),
        "app_chat_pleroma_accounts_title":
            MessageLookupByLibrary.simpleMessage("Chat accounts"),
        "app_chat_pleroma_share_title":
            MessageLookupByLibrary.simpleMessage("Share to chats"),
        "app_chat_post_error_empty_dialog_title":
            MessageLookupByLibrary.simpleMessage("Can\'t send empty message"),
        "app_chat_post_field_content_hint":
            MessageLookupByLibrary.simpleMessage("Start a message"),
        "app_chat_preview_you": m24,
        "app_chat_selection_action_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "app_chat_selection_action_copyAsRawText_toast_success":
            MessageLookupByLibrary.simpleMessage("Copied in clipboard"),
        "app_chat_selection_action_delete_confirm_dialog_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_chat_selection_action_delete_confirm_dialog_content":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "app_chat_selection_action_delete_confirm_dialog_title":
            MessageLookupByLibrary.simpleMessage("Delete messages"),
        "app_chat_selection_count": m25,
        "app_chat_settings_field_countConversationsInChatsUnreadBadges_label":
            MessageLookupByLibrary.simpleMessage(
                "Count conversations in unread badges"),
        "app_chat_settings_field_replaceConversationsWithPleromaChats_label":
            MessageLookupByLibrary.simpleMessage(
                "Replace \"Conversations\" with \"Chats\""),
        "app_chat_settings_title": MessageLookupByLibrary.simpleMessage("Chat"),
        "app_customList_create_title":
            MessageLookupByLibrary.simpleMessage("Create a list"),
        "app_customList_edit_title":
            MessageLookupByLibrary.simpleMessage("Edit list"),
        "app_customList_form_field_title_hint":
            MessageLookupByLibrary.simpleMessage("Give your list a title"),
        "app_customList_form_field_title_label":
            MessageLookupByLibrary.simpleMessage("Title*"),
        "app_datetime_picker_action_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "app_datetime_picker_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_datetime_picker_action_done":
            MessageLookupByLibrary.simpleMessage("Done"),
        "app_datetime_picker_action_ok":
            MessageLookupByLibrary.simpleMessage("Set time"),
        "app_datetime_title":
            MessageLookupByLibrary.simpleMessage("Select date"),
        "app_duration_picker_action_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "app_duration_picker_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_duration_picker_action_done":
            MessageLookupByLibrary.simpleMessage("Done"),
        "app_duration_value_null":
            MessageLookupByLibrary.simpleMessage("Never"),
        "app_emoji_category_empty": MessageLookupByLibrary.simpleMessage(
            "This category don\'t have suitable emojis"),
        "app_emoji_custom_empty": MessageLookupByLibrary.simpleMessage(
            "This instance don\'t have custom emojis"),
        "app_emoji_recent_empty":
            MessageLookupByLibrary.simpleMessage("No recent emojis"),
        "app_file_image_crop_title":
            MessageLookupByLibrary.simpleMessage("Crop as"),
        "app_filter_context_empty":
            MessageLookupByLibrary.simpleMessage("Nothing selected"),
        "app_filter_context_type_account":
            MessageLookupByLibrary.simpleMessage("Account"),
        "app_filter_context_type_home_and_lists":
            MessageLookupByLibrary.simpleMessage("Home and Lists"),
        "app_filter_context_type_notifications":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "app_filter_context_type_public":
            MessageLookupByLibrary.simpleMessage("Public"),
        "app_filter_context_type_threads":
            MessageLookupByLibrary.simpleMessage("Conversations"),
        "app_filter_context_type_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "app_filter_create_title":
            MessageLookupByLibrary.simpleMessage("Create filter"),
        "app_filter_edit_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_filter_edit_action_save":
            MessageLookupByLibrary.simpleMessage("Save"),
        "app_filter_edit_description": MessageLookupByLibrary.simpleMessage(
            "Remove statuses which contains phrase in text or content warning"),
        "app_filter_edit_field_context_description":
            MessageLookupByLibrary.simpleMessage(
                "One or multiply contexts where the filter should apply"),
        "app_filter_edit_field_context_label":
            MessageLookupByLibrary.simpleMessage("Contexts"),
        "app_filter_edit_field_expiresIn_description":
            MessageLookupByLibrary.simpleMessage(
                "Expired filters are not automatically deleted, but can be reactivated"),
        "app_filter_edit_field_expiresIn_label":
            MessageLookupByLibrary.simpleMessage("Expires in"),
        "app_filter_edit_field_irreversible_description":
            MessageLookupByLibrary.simpleMessage(
                "Filter statuses on server-side (irreversible)"),
        "app_filter_edit_field_irreversible_label":
            MessageLookupByLibrary.simpleMessage("Drop instead of hide"),
        "app_filter_edit_field_phrase_hint":
            MessageLookupByLibrary.simpleMessage("Not sensitive to case"),
        "app_filter_edit_field_phrase_label":
            MessageLookupByLibrary.simpleMessage("Phrase"),
        "app_filter_edit_field_wholeWord_description":
            MessageLookupByLibrary.simpleMessage(
                "Apply only if phrase exactly matched"),
        "app_filter_edit_field_wholeWord_error_invalid_phrase":
            MessageLookupByLibrary.simpleMessage(
                "Phrase should be alphanumeric only"),
        "app_filter_edit_field_wholeWord_label":
            MessageLookupByLibrary.simpleMessage("Whole word"),
        "app_filter_edit_title":
            MessageLookupByLibrary.simpleMessage("Edit filter"),
        "app_filter_expired": MessageLookupByLibrary.simpleMessage("Expired"),
        "app_filter_list_action_add":
            MessageLookupByLibrary.simpleMessage("Add Filter"),
        "app_filter_list_empty": MessageLookupByLibrary.simpleMessage(
            "You haven’t created any Filters yet."),
        "app_filter_list_title":
            MessageLookupByLibrary.simpleMessage("Filters"),
        "app_googlePlay_appName": MessageLookupByLibrary.simpleMessage(
            "Fedi for Pleroma and Mastodon"),
        "app_googlePlay_fullDescription": MessageLookupByLibrary.simpleMessage(
            "A client for Pleroma and Mastodon social network instances"),
        "app_googlePlay_shortDescription": MessageLookupByLibrary.simpleMessage(
            "A client for Pleroma and Mastodon social network instances"),
        "app_hashtag_remoteInstance_dialog_action_openOnLocal": m26,
        "app_hashtag_remoteInstance_dialog_action_openOnRemoteInBrowser": m27,
        "app_hashtag_remoteInstance_dialog_title": m28,
        "app_home_tab_chat_conversation_action_switchToChats":
            MessageLookupByLibrary.simpleMessage("To Chats"),
        "app_home_tab_chat_conversation_title":
            MessageLookupByLibrary.simpleMessage("Conversations"),
        "app_home_tab_chat_pleroma_action_switch_to_dms":
            MessageLookupByLibrary.simpleMessage("To Conversations"),
        "app_home_tab_chat_pleroma_notSupported_mastodon":
            MessageLookupByLibrary.simpleMessage(
                "Chats not supported on Mastodon instances"),
        "app_home_tab_chat_pleroma_notSupported_pleroma":
            MessageLookupByLibrary.simpleMessage(
                "This instance don\'t support chats"),
        "app_home_tab_chat_pleroma_title":
            MessageLookupByLibrary.simpleMessage("Chats"),
        "app_init_fail": MessageLookupByLibrary.simpleMessage(
            "Failed to start app.\nTry restart or re-install app."),
        "app_instance_details_field_approvalRequired_label":
            MessageLookupByLibrary.simpleMessage("Approval required"),
        "app_instance_details_field_chatLimit_label":
            MessageLookupByLibrary.simpleMessage("Max chat message length"),
        "app_instance_details_field_contactAccount_label":
            MessageLookupByLibrary.simpleMessage("Contact"),
        "app_instance_details_field_details_title":
            MessageLookupByLibrary.simpleMessage("Details"),
        "app_instance_details_field_email_label":
            MessageLookupByLibrary.simpleMessage("Email"),
        "app_instance_details_field_federation_enabled_label":
            MessageLookupByLibrary.simpleMessage("Enabled"),
        "app_instance_details_field_federation_exclusions_label":
            MessageLookupByLibrary.simpleMessage("Exclusions"),
        "app_instance_details_field_federation_mrfObjectAge_actions_label":
            MessageLookupByLibrary.simpleMessage("MFR Object Age Actions"),
        "app_instance_details_field_federation_mrfObjectAge_threshold_label":
            MessageLookupByLibrary.simpleMessage("MFR Object Age Threshold"),
        "app_instance_details_field_federation_mrfPolicies_label":
            MessageLookupByLibrary.simpleMessage("MFR Policies"),
        "app_instance_details_field_federation_quarantinedInstances_label":
            MessageLookupByLibrary.simpleMessage("Quarantined Instances"),
        "app_instance_details_field_federation_title":
            MessageLookupByLibrary.simpleMessage("Federation"),
        "app_instance_details_field_imageDescriptionLimit_label":
            MessageLookupByLibrary.simpleMessage(
                "Max media description length"),
        "app_instance_details_field_invitesEnabled_label":
            MessageLookupByLibrary.simpleMessage("Invites Enabled"),
        "app_instance_details_field_languages_label":
            MessageLookupByLibrary.simpleMessage("Languages"),
        "app_instance_details_field_maxTootChars_label":
            MessageLookupByLibrary.simpleMessage("Max status length"),
        "app_instance_details_field_messagesLimits_title":
            MessageLookupByLibrary.simpleMessage("Messages limits"),
        "app_instance_details_field_metadata_title":
            MessageLookupByLibrary.simpleMessage("Metadata"),
        "app_instance_details_field_pleroma_metadata_features_label":
            MessageLookupByLibrary.simpleMessage("Features"),
        "app_instance_details_field_pleroma_metadata_fields_maxFields_label":
            MessageLookupByLibrary.simpleMessage("Max fields count"),
        "app_instance_details_field_pleroma_metadata_fields_maxRemoteFields_label":
            MessageLookupByLibrary.simpleMessage("Max remote fields count"),
        "app_instance_details_field_pleroma_metadata_fields_nameLength_label":
            MessageLookupByLibrary.simpleMessage("Max name length"),
        "app_instance_details_field_pleroma_metadata_fields_postFormats_label":
            MessageLookupByLibrary.simpleMessage("Post formats"),
        "app_instance_details_field_pleroma_metadata_fields_title":
            MessageLookupByLibrary.simpleMessage("Fields limit"),
        "app_instance_details_field_pleroma_metadata_fields_valueLength_label":
            MessageLookupByLibrary.simpleMessage("Max value length"),
        "app_instance_details_field_pleroma_metadata_fields_verstionType_value_mastodon":
            MessageLookupByLibrary.simpleMessage("Mastodon"),
        "app_instance_details_field_pleroma_metadata_fields_verstionType_value_pleroma":
            MessageLookupByLibrary.simpleMessage("Pleroma"),
        "app_instance_details_field_pleroma_metadata_fields_verstionType_value_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "app_instance_details_field_pollLimit_maxExpiration_label":
            MessageLookupByLibrary.simpleMessage("Max expiration"),
        "app_instance_details_field_pollLimit_maxOptionsChars_label":
            MessageLookupByLibrary.simpleMessage("Max options length"),
        "app_instance_details_field_pollLimit_maxOptions_label":
            MessageLookupByLibrary.simpleMessage("Max options count"),
        "app_instance_details_field_pollLimit_minExpiration_label":
            MessageLookupByLibrary.simpleMessage("Min expiration"),
        "app_instance_details_field_pollLimit_title":
            MessageLookupByLibrary.simpleMessage("Poll limits"),
        "app_instance_details_field_registrationsLimits_title":
            MessageLookupByLibrary.simpleMessage("Registration limits"),
        "app_instance_details_field_registrations_label":
            MessageLookupByLibrary.simpleMessage("Registrations enabled"),
        "app_instance_details_field_stats_domainCount_label":
            MessageLookupByLibrary.simpleMessage("Federation domains"),
        "app_instance_details_field_stats_statusCount_label":
            MessageLookupByLibrary.simpleMessage("Statuses"),
        "app_instance_details_field_stats_title":
            MessageLookupByLibrary.simpleMessage("Statistic"),
        "app_instance_details_field_stats_userCount_label":
            MessageLookupByLibrary.simpleMessage("Users"),
        "app_instance_details_field_uploadAvatar_label":
            MessageLookupByLibrary.simpleMessage("Upload avatar limit"),
        "app_instance_details_field_uploadBackground_label":
            MessageLookupByLibrary.simpleMessage("Upload background limit"),
        "app_instance_details_field_uploadBanner_label":
            MessageLookupByLibrary.simpleMessage("Upload banner limit"),
        "app_instance_details_field_uploadLimits_title":
            MessageLookupByLibrary.simpleMessage("Upload limits"),
        "app_instance_details_field_uploadMedia_label":
            MessageLookupByLibrary.simpleMessage("Upload media limit"),
        "app_instance_details_field_vapidPublicKey_label":
            MessageLookupByLibrary.simpleMessage("Vapid public key"),
        "app_instance_details_field_version_label":
            MessageLookupByLibrary.simpleMessage("Version"),
        "app_instance_details_value_bool_false":
            MessageLookupByLibrary.simpleMessage("False"),
        "app_instance_details_value_bool_true":
            MessageLookupByLibrary.simpleMessage("True"),
        "app_instance_details_value_sizeInMb": m29,
        "app_instance_detials_title": m30,
        "app_instance_remote_error_failed_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Remote host don\'t support this feature or network error"),
        "app_instance_remote_error_failed_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Failed to load data from remote host"),
        "app_list_cantUpdateFromNetwork":
            MessageLookupByLibrary.simpleMessage("Can\'t update from network"),
        "app_list_empty":
            MessageLookupByLibrary.simpleMessage("Items not found"),
        "app_list_loading_state_canLoadMore":
            MessageLookupByLibrary.simpleMessage("Can load more"),
        "app_list_loading_state_failed":
            MessageLookupByLibrary.simpleMessage("Failed to load more"),
        "app_list_loading_state_noMoreData":
            MessageLookupByLibrary.simpleMessage("No more data"),
        "app_list_refresh_unableToFetch":
            MessageLookupByLibrary.simpleMessage("Unable to refresh"),
        "app_localization_dialog_title":
            MessageLookupByLibrary.simpleMessage("Language"),
        "app_localization_form_field_label":
            MessageLookupByLibrary.simpleMessage("Language"),
        "app_localization_settings_field_localizationLocale_label":
            MessageLookupByLibrary.simpleMessage("Language"),
        "app_localization_settings_title":
            MessageLookupByLibrary.simpleMessage("Localization"),
        "app_media_attachment_addToGallery_error_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Media type is not supported, network not available or permission not granted"),
        "app_media_attachment_addToGallery_error_dialog_title":
            MessageLookupByLibrary.simpleMessage("Can\'t save media"),
        "app_media_attachment_addToGallery_progress_content":
            MessageLookupByLibrary.simpleMessage("Saving..."),
        "app_media_attachment_details_notSupported_type": m31,
        "app_media_attachment_details_title":
            MessageLookupByLibrary.simpleMessage("Media attachment"),
        "app_media_attachment_type_audio":
            MessageLookupByLibrary.simpleMessage("Audio"),
        "app_media_attachment_type_file":
            MessageLookupByLibrary.simpleMessage("File"),
        "app_media_attachment_type_gallery":
            MessageLookupByLibrary.simpleMessage("Gallery"),
        "app_media_attachment_type_photo":
            MessageLookupByLibrary.simpleMessage("Photo"),
        "app_media_attachment_type_video":
            MessageLookupByLibrary.simpleMessage("Video"),
        "app_media_attachment_upload_remove_dialog_action_remove":
            MessageLookupByLibrary.simpleMessage("Remove"),
        "app_media_attachment_upload_remove_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to remove the attachment?"),
        "app_media_player_error_action_moreDetails":
            MessageLookupByLibrary.simpleMessage("More details"),
        "app_media_player_error_action_reload":
            MessageLookupByLibrary.simpleMessage("Reload"),
        "app_media_player_error_desc":
            MessageLookupByLibrary.simpleMessage("Something wrong"),
        "app_media_settings_field_autoInit_label":
            MessageLookupByLibrary.simpleMessage("Auto-load"),
        "app_media_settings_field_autoPlay_label":
            MessageLookupByLibrary.simpleMessage("Auto-play"),
        "app_media_settings_title":
            MessageLookupByLibrary.simpleMessage("Media"),
        "app_media_upload_failed_notification_exceedSize_content": m32,
        "app_media_upload_failed_notification_title":
            MessageLookupByLibrary.simpleMessage("Failed to upload"),
        "app_notification_action_dismiss":
            MessageLookupByLibrary.simpleMessage("Dismiss"),
        "app_notification_action_markAsRead":
            MessageLookupByLibrary.simpleMessage("Mark as read"),
        "app_notification_action_popup_title":
            MessageLookupByLibrary.simpleMessage("Notification actions"),
        "app_notification_all_dialog_action_dismissAll":
            MessageLookupByLibrary.simpleMessage("Dismiss ALL"),
        "app_notification_all_dialog_action_markAllAsRead":
            MessageLookupByLibrary.simpleMessage("Mark ALL as read"),
        "app_notification_all_dialog_action_pushNotifications":
            MessageLookupByLibrary.simpleMessage("Push notifications settings"),
        "app_notification_all_dialog_title":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "app_notification_dismissed":
            MessageLookupByLibrary.simpleMessage("Dismissed"),
        "app_notification_header_favourite":
            MessageLookupByLibrary.simpleMessage("Liked your post."),
        "app_notification_header_follow":
            MessageLookupByLibrary.simpleMessage("Followed you."),
        "app_notification_header_followRequest":
            MessageLookupByLibrary.simpleMessage("Follow request."),
        "app_notification_header_mention_postfix": m33,
        "app_notification_header_mention_prefix":
            MessageLookupByLibrary.simpleMessage("Mentioned you: "),
        "app_notification_header_move":
            MessageLookupByLibrary.simpleMessage("Moved."),
        "app_notification_header_pleromaChatMention_postfix": m34,
        "app_notification_header_pleromaChatMention_prefix":
            MessageLookupByLibrary.simpleMessage("Chat: "),
        "app_notification_header_pleromaEmojiReaction": m35,
        "app_notification_header_poll":
            MessageLookupByLibrary.simpleMessage("Voted poll ended."),
        "app_notification_header_reblog":
            MessageLookupByLibrary.simpleMessage("Shared your post."),
        "app_notification_header_report": m36,
        "app_notification_header_unknown": m37,
        "app_notification_list_newItems_action_tapToLoadNew": m38,
        "app_pagination_settings_pageSize_label":
            MessageLookupByLibrary.simpleMessage("Page size"),
        "app_pagination_settings_title":
            MessageLookupByLibrary.simpleMessage("Pagination"),
        "app_poll_metadata_expires_expired":
            MessageLookupByLibrary.simpleMessage("Poll ended"),
        "app_poll_metadata_expires_notExpired": m39,
        "app_poll_metadata_hideResults":
            MessageLookupByLibrary.simpleMessage("Hide results"),
        "app_poll_metadata_showResults":
            MessageLookupByLibrary.simpleMessage("View results"),
        "app_poll_metadata_totalVotes": m40,
        "app_poll_vote": MessageLookupByLibrary.simpleMessage("Vote"),
        "app_push_permission_ask_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Do you want to enable push notifications?\nThey will be forwarded through Fedi push proxy server"),
        "app_push_permission_ask_dialog_title":
            MessageLookupByLibrary.simpleMessage("Push notifications"),
        "app_push_permission_declined_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Please enable push notification in app settings to receive updates"),
        "app_push_permission_declined_dialog_title":
            MessageLookupByLibrary.simpleMessage("Permission required"),
        "app_push_settings_desc": MessageLookupByLibrary.simpleMessage(
            "All messages will be forwarded through Fedi proxy server"),
        "app_push_settings_field_favourites_label":
            MessageLookupByLibrary.simpleMessage("Favourites"),
        "app_push_settings_field_follows_label":
            MessageLookupByLibrary.simpleMessage("Follows"),
        "app_push_settings_field_mentions_label":
            MessageLookupByLibrary.simpleMessage("Mentions"),
        "app_push_settings_field_pleroma_chat_label":
            MessageLookupByLibrary.simpleMessage("Chats"),
        "app_push_settings_field_pleroma_emojiReaction_label":
            MessageLookupByLibrary.simpleMessage("Emoji reactions"),
        "app_push_settings_field_polls_label":
            MessageLookupByLibrary.simpleMessage("Polls"),
        "app_push_settings_field_reblogs_label":
            MessageLookupByLibrary.simpleMessage("Reblogs"),
        "app_push_settings_title":
            MessageLookupByLibrary.simpleMessage("Push notifications"),
        "app_push_settings_update_fail_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Failed to change subscription settings"),
        "app_search_field_input_hint":
            MessageLookupByLibrary.simpleMessage("Search"),
        "app_search_recent_empty":
            MessageLookupByLibrary.simpleMessage("No recent searches"),
        "app_search_recent_title":
            MessageLookupByLibrary.simpleMessage("Recent"),
        "app_search_tab_accounts":
            MessageLookupByLibrary.simpleMessage("Users"),
        "app_search_tab_all": MessageLookupByLibrary.simpleMessage("All"),
        "app_search_tab_hashtags":
            MessageLookupByLibrary.simpleMessage("Hashtags"),
        "app_search_tab_statuses":
            MessageLookupByLibrary.simpleMessage("Posts"),
        "app_search_title": MessageLookupByLibrary.simpleMessage("Search"),
        "app_settings_global_or_instance_use_global_label":
            MessageLookupByLibrary.simpleMessage("Global settings"),
        "app_settings_global_title":
            MessageLookupByLibrary.simpleMessage("Settings: global"),
        "app_settings_instance_title": m41,
        "app_settings_warning_notSupportedOnThisInstance_desc":
            MessageLookupByLibrary.simpleMessage(
                "Not supported on this instance"),
        "app_share_action_send": MessageLookupByLibrary.simpleMessage("Send"),
        "app_share_action_sent": MessageLookupByLibrary.simpleMessage("Sent"),
        "app_share_action_share": MessageLookupByLibrary.simpleMessage("Share"),
        "app_share_action_shareToChats":
            MessageLookupByLibrary.simpleMessage("Share to Chats"),
        "app_share_action_shareToConversations":
            MessageLookupByLibrary.simpleMessage("Share to Conversations"),
        "app_share_action_shareToExternal":
            MessageLookupByLibrary.simpleMessage("Share to external app"),
        "app_share_action_shareToNewStatus":
            MessageLookupByLibrary.simpleMessage("Share as new status"),
        "app_share_external_field_shareAsLink":
            MessageLookupByLibrary.simpleMessage("Share as link"),
        "app_share_external_title":
            MessageLookupByLibrary.simpleMessage("Share to external app"),
        "app_share_title": MessageLookupByLibrary.simpleMessage("Share"),
        "app_share_toast_success":
            MessageLookupByLibrary.simpleMessage("Shared successfully"),
        "app_share_with_message_field_message_hint":
            MessageLookupByLibrary.simpleMessage("Describe content (optional)"),
        "app_share_with_message_field_message_label":
            MessageLookupByLibrary.simpleMessage("Message"),
        "app_status_action_bookmark":
            MessageLookupByLibrary.simpleMessage("Bookmark"),
        "app_status_action_copyLink":
            MessageLookupByLibrary.simpleMessage("Copy link"),
        "app_status_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_status_action_mute":
            MessageLookupByLibrary.simpleMessage("Mute conversation"),
        "app_status_action_openInBrowser":
            MessageLookupByLibrary.simpleMessage("Open in browser"),
        "app_status_action_openOnRemoteInstance": m42,
        "app_status_action_pin": MessageLookupByLibrary.simpleMessage("Pin"),
        "app_status_action_popup_title":
            MessageLookupByLibrary.simpleMessage("Status Actions"),
        "app_status_action_showThisThread":
            MessageLookupByLibrary.simpleMessage("Show this thread"),
        "app_status_action_unbookmark":
            MessageLookupByLibrary.simpleMessage("Unbookmark"),
        "app_status_action_unmute":
            MessageLookupByLibrary.simpleMessage("Unmute conversation"),
        "app_status_action_unpin":
            MessageLookupByLibrary.simpleMessage("Unpin"),
        "app_status_collapsible_action_collapse":
            MessageLookupByLibrary.simpleMessage("Collapse"),
        "app_status_collapsible_action_expand":
            MessageLookupByLibrary.simpleMessage("Expand"),
        "app_status_copyLink_toast":
            MessageLookupByLibrary.simpleMessage("Copied in clipboard"),
        "app_status_delete_dialog_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_status_delete_dialog_action_deleteAndSaveToDrafts":
            MessageLookupByLibrary.simpleMessage("Delete and save to drafts"),
        "app_status_delete_dialog_action_deleteAndStartNew":
            MessageLookupByLibrary.simpleMessage("Delete and start new status"),
        "app_status_delete_dialog_title":
            MessageLookupByLibrary.simpleMessage("Delete actions"),
        "app_status_deleted_desc":
            MessageLookupByLibrary.simpleMessage("Status deleted"),
        "app_status_draft_edit_title":
            MessageLookupByLibrary.simpleMessage("Edit Draft"),
        "app_status_draft_state_alreadyPosted":
            MessageLookupByLibrary.simpleMessage("Already posted"),
        "app_status_draft_state_canceled":
            MessageLookupByLibrary.simpleMessage("Canceled"),
        "app_status_emoji_error_cantAdd_dialog_content": m43,
        "app_status_emoji_error_cantAdd_dialog_title":
            MessageLookupByLibrary.simpleMessage("Can\'t add emoji"),
        "app_status_expire_datetime_picker_title":
            MessageLookupByLibrary.simpleMessage("Expire at"),
        "app_status_favouritedBy_title":
            MessageLookupByLibrary.simpleMessage("Favourited by"),
        "app_status_list_newItems_action_tapToLoadNew": m44,
        "app_status_mute_dialog_action_clearDate":
            MessageLookupByLibrary.simpleMessage("Clear date"),
        "app_status_mute_dialog_action_mute":
            MessageLookupByLibrary.simpleMessage("Mute"),
        "app_status_mute_dialog_field_expire_label":
            MessageLookupByLibrary.simpleMessage("Expire"),
        "app_status_mute_dialog_title":
            MessageLookupByLibrary.simpleMessage("Muting conversation"),
        "app_status_nsfw_action_view":
            MessageLookupByLibrary.simpleMessage("Tap to view"),
        "app_status_nsfw_chip": MessageLookupByLibrary.simpleMessage("NSFW!"),
        "app_status_post_action_post":
            MessageLookupByLibrary.simpleMessage("Post"),
        "app_status_post_dialog_async_content":
            MessageLookupByLibrary.simpleMessage("Posting..."),
        "app_status_post_dialog_error_content": m45,
        "app_status_post_dialog_error_title_post":
            MessageLookupByLibrary.simpleMessage("Failed to post status"),
        "app_status_post_dialog_error_title_schedule":
            MessageLookupByLibrary.simpleMessage("Failed to schedule status"),
        "app_status_post_error_empty_dialog_title":
            MessageLookupByLibrary.simpleMessage("Can\'t send empty message"),
        "app_status_post_error_pollBodyIsEmpty_desc":
            MessageLookupByLibrary.simpleMessage(
                "Poll body shouldn\'t be empty"),
        "app_status_post_error_poll_dialog_title":
            MessageLookupByLibrary.simpleMessage(
                "Enter at least two poll options"),
        "app_status_post_field_message_hint":
            MessageLookupByLibrary.simpleMessage("What’s going on today?"),
        "app_status_post_field_subject":
            MessageLookupByLibrary.simpleMessage("Subject (optional)"),
        "app_status_post_new_title":
            MessageLookupByLibrary.simpleMessage("New status"),
        "app_status_post_new_unsaved_dialog_action_discard":
            MessageLookupByLibrary.simpleMessage("Discard Post"),
        "app_status_post_new_unsaved_dialog_action_keep_editing":
            MessageLookupByLibrary.simpleMessage("Keep editing"),
        "app_status_post_new_unsaved_dialog_action_saveAsDraft":
            MessageLookupByLibrary.simpleMessage("Save Draft"),
        "app_status_post_new_unsaved_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "If you discard now, you’ll lose this post."),
        "app_status_post_new_unsaved_dialog_title":
            MessageLookupByLibrary.simpleMessage("Save this post as draft?"),
        "app_status_post_poll_field_length_label":
            MessageLookupByLibrary.simpleMessage("Poll length"),
        "app_status_post_poll_field_multiply_label":
            MessageLookupByLibrary.simpleMessage("Multiple selection"),
        "app_status_post_poll_field_option_hint": m46,
        "app_status_post_schedule_error_notInFuture_dialog_content":
            MessageLookupByLibrary.simpleMessage(
                "Schedule time must be at least 5 minutes in the future"),
        "app_status_post_schedule_error_notInFuture_dialog_title":
            MessageLookupByLibrary.simpleMessage("Invalid date or time"),
        "app_status_post_settings_field_defaultVisibility_label":
            MessageLookupByLibrary.simpleMessage("Default visibility"),
        "app_status_post_settings_field_markMediaAsNsfwOnAttach_label":
            MessageLookupByLibrary.simpleMessage("Mark media as NSFW"),
        "app_status_post_settings_title":
            MessageLookupByLibrary.simpleMessage("Posting"),
        "app_status_post_toast_success_post":
            MessageLookupByLibrary.simpleMessage("Status posted"),
        "app_status_post_toast_success_schedule":
            MessageLookupByLibrary.simpleMessage("Status scheduled"),
        "app_status_post_visibility_state_direct":
            MessageLookupByLibrary.simpleMessage("Direct"),
        "app_status_post_visibility_state_list":
            MessageLookupByLibrary.simpleMessage("List"),
        "app_status_post_visibility_state_local":
            MessageLookupByLibrary.simpleMessage("Local"),
        "app_status_post_visibility_state_private":
            MessageLookupByLibrary.simpleMessage("Private"),
        "app_status_post_visibility_state_public":
            MessageLookupByLibrary.simpleMessage("Public"),
        "app_status_post_visibility_state_unlisted":
            MessageLookupByLibrary.simpleMessage("Unlisted"),
        "app_status_post_visibility_title":
            MessageLookupByLibrary.simpleMessage("Visibility"),
        "app_status_reblog_header":
            MessageLookupByLibrary.simpleMessage("reposted"),
        "app_status_rebloggedBy_title":
            MessageLookupByLibrary.simpleMessage("Reblogged by"),
        "app_status_reply_header":
            MessageLookupByLibrary.simpleMessage("reply to"),
        "app_status_reply_loading_failed":
            MessageLookupByLibrary.simpleMessage("Failed to load first status"),
        "app_status_reply_loading_progress":
            MessageLookupByLibrary.simpleMessage("Loading first status"),
        "app_status_reply_replyingTo": m47,
        "app_status_scheduled_datetime_picker_title":
            MessageLookupByLibrary.simpleMessage("Schedule at"),
        "app_status_scheduled_edit_title":
            MessageLookupByLibrary.simpleMessage("Scheduled post"),
        "app_status_scheduled_state_alreadyPosted":
            MessageLookupByLibrary.simpleMessage("Already posted"),
        "app_status_scheduled_state_canceled":
            MessageLookupByLibrary.simpleMessage("Canceled"),
        "app_status_sensitive_settings_field_isAlwaysShowNsfw_label":
            MessageLookupByLibrary.simpleMessage("Always show NSFW"),
        "app_status_sensitive_settings_field_isAlwaysShowSpoiler_label":
            MessageLookupByLibrary.simpleMessage("Always show spoilers"),
        "app_status_sensitive_settings_field_nsfwDisplayDelayDuration_label":
            MessageLookupByLibrary.simpleMessage("Remember \"Tap to view\""),
        "app_status_sensitive_settings_title":
            MessageLookupByLibrary.simpleMessage("NSFW & Spoilers"),
        "app_status_spoiler_action_view":
            MessageLookupByLibrary.simpleMessage("Tap to view"),
        "app_status_spoiler_chip":
            MessageLookupByLibrary.simpleMessage("Spoilers!"),
        "app_status_thread_post_hint": m48,
        "app_status_thread_start_loading":
            MessageLookupByLibrary.simpleMessage("Loading start status"),
        "app_theme_chooser_label":
            MessageLookupByLibrary.simpleMessage("Color scheme"),
        "app_theme_type_dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "app_theme_type_light": MessageLookupByLibrary.simpleMessage("Light"),
        "app_theme_type_system": MessageLookupByLibrary.simpleMessage("Auto"),
        "app_timeline_create_field_id_label":
            MessageLookupByLibrary.simpleMessage("Unique id"),
        "app_timeline_create_field_title_hint":
            MessageLookupByLibrary.simpleMessage("Timeline name"),
        "app_timeline_create_field_title_label":
            MessageLookupByLibrary.simpleMessage("Title"),
        "app_timeline_create_title":
            MessageLookupByLibrary.simpleMessage("Create new timeline"),
        "app_timeline_loading":
            MessageLookupByLibrary.simpleMessage("Loading timelines"),
        "app_timeline_settings_content": m49,
        "app_timeline_settings_field_enableWebSockets_description":
            MessageLookupByLibrary.simpleMessage(
                "Disable to reduce battery usage"),
        "app_timeline_settings_field_enableWebSockets_description_instance_disabled":
            MessageLookupByLibrary.simpleMessage(
                "Disabled in account settings"),
        "app_timeline_settings_field_enableWebSockets_label":
            MessageLookupByLibrary.simpleMessage("WebSockets updates"),
        "app_timeline_settings_field_excludeNsfw_label":
            MessageLookupByLibrary.simpleMessage("Exclude NSFW"),
        "app_timeline_settings_field_excludeReblogs_label":
            MessageLookupByLibrary.simpleMessage("Exclude reblogs"),
        "app_timeline_settings_field_excludeReplies_label":
            MessageLookupByLibrary.simpleMessage("Exclude replies"),
        "app_timeline_settings_field_excludeVisibilites_label":
            MessageLookupByLibrary.simpleMessage("Exclude visibilities"),
        "app_timeline_settings_field_onlyLocal_label":
            MessageLookupByLibrary.simpleMessage("Only local"),
        "app_timeline_settings_field_onlyPinned_label":
            MessageLookupByLibrary.simpleMessage("Only pinned"),
        "app_timeline_settings_field_onlyRemote_label":
            MessageLookupByLibrary.simpleMessage("Only remote"),
        "app_timeline_settings_field_onlyWithMedia_label":
            MessageLookupByLibrary.simpleMessage("Only with media"),
        "app_timeline_settings_field_withMuted_label":
            MessageLookupByLibrary.simpleMessage("With muted"),
        "app_timeline_settings_onlyFromInstance_field_hint":
            MessageLookupByLibrary.simpleMessage("pleroma.com"),
        "app_timeline_settings_onlyFromInstance_field_label":
            MessageLookupByLibrary.simpleMessage("Only from instance"),
        "app_timeline_settings_onlyFromRemoteAccount_field_label":
            MessageLookupByLibrary.simpleMessage("Only from account"),
        "app_timeline_settings_onlyFromRemoteAccount_field_null":
            MessageLookupByLibrary.simpleMessage("Not selected"),
        "app_timeline_settings_onlyInRemoteList_field_chooser_dialog_title":
            MessageLookupByLibrary.simpleMessage("Choose list"),
        "app_timeline_settings_onlyInRemoteList_field_label":
            MessageLookupByLibrary.simpleMessage("Only in list"),
        "app_timeline_settings_onlyInRemoteList_field_null":
            MessageLookupByLibrary.simpleMessage("Not selected"),
        "app_timeline_settings_replyVisibilityFilter_field_label":
            MessageLookupByLibrary.simpleMessage("Reply visibility filter"),
        "app_timeline_settings_replyVisibilityFilter_field_null":
            MessageLookupByLibrary.simpleMessage("Not selected"),
        "app_timeline_settings_replyVisibilityFilter_following":
            MessageLookupByLibrary.simpleMessage("Following & Self"),
        "app_timeline_settings_replyVisibilityFilter_self":
            MessageLookupByLibrary.simpleMessage("Self"),
        "app_timeline_settings_title":
            MessageLookupByLibrary.simpleMessage("Settings:"),
        "app_timeline_settings_withRemoteHashtag_field_hint":
            MessageLookupByLibrary.simpleMessage("pleroma"),
        "app_timeline_settings_withRemoteHashtag_field_label":
            MessageLookupByLibrary.simpleMessage("With hashtag"),
        "app_timeline_storage_action_add":
            MessageLookupByLibrary.simpleMessage("Add Timelines.."),
        "app_timeline_storage_appBar_action_done":
            MessageLookupByLibrary.simpleMessage("Done"),
        "app_timeline_storage_appBar_action_edit":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "app_timeline_storage_delete_dialog_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_timeline_storage_delete_dialog_content": m50,
        "app_timeline_storage_delete_dialog_title":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "app_timeline_storage_empty":
            MessageLookupByLibrary.simpleMessage("Nothing found"),
        "app_timeline_storage_title":
            MessageLookupByLibrary.simpleMessage("Timelines"),
        "app_timeline_type_account":
            MessageLookupByLibrary.simpleMessage("Account"),
        "app_timeline_type_customList":
            MessageLookupByLibrary.simpleMessage("List"),
        "app_timeline_type_field_chooser_dialog_title":
            MessageLookupByLibrary.simpleMessage("Choose timeline type"),
        "app_timeline_type_field_label":
            MessageLookupByLibrary.simpleMessage("Type"),
        "app_timeline_type_field_null":
            MessageLookupByLibrary.simpleMessage("Not selected"),
        "app_timeline_type_hashtag":
            MessageLookupByLibrary.simpleMessage("Hashtag"),
        "app_timeline_type_home": MessageLookupByLibrary.simpleMessage("Home"),
        "app_timeline_type_public":
            MessageLookupByLibrary.simpleMessage("Public"),
        "app_timeline_type_public_all":
            MessageLookupByLibrary.simpleMessage("All"),
        "app_timeline_type_public_local":
            MessageLookupByLibrary.simpleMessage("Local"),
        "app_toast_handling_type_always":
            MessageLookupByLibrary.simpleMessage("Always"),
        "app_toast_handling_type_never":
            MessageLookupByLibrary.simpleMessage("Never"),
        "app_toast_handling_type_onlyWhenInstanceNotSelected":
            MessageLookupByLibrary.simpleMessage(
                "When app with account in foreground"),
        "app_toast_handling_type_onlyWhenInstanceSelected":
            MessageLookupByLibrary.simpleMessage(
                "When app or account in background"),
        "app_toast_settings_field_handling_type_label":
            MessageLookupByLibrary.simpleMessage("When"),
        "app_toast_settings_title":
            MessageLookupByLibrary.simpleMessage("In-app notifications"),
        "app_tos_title":
            MessageLookupByLibrary.simpleMessage("Terms of service"),
        "app_ui_fontSize_type_large":
            MessageLookupByLibrary.simpleMessage("Large"),
        "app_ui_fontSize_type_largest":
            MessageLookupByLibrary.simpleMessage("Largest"),
        "app_ui_fontSize_type_medium":
            MessageLookupByLibrary.simpleMessage("Medium"),
        "app_ui_fontSize_type_small":
            MessageLookupByLibrary.simpleMessage("Small"),
        "app_ui_fontSize_type_smallest":
            MessageLookupByLibrary.simpleMessage("Smallest"),
        "app_ui_settings_title": MessageLookupByLibrary.simpleMessage("UI"),
        "app_ui_statusFontSize":
            MessageLookupByLibrary.simpleMessage("Status font size"),
        "app_web_sockets_settings_field_type_description":
            MessageLookupByLibrary.simpleMessage(
                "Disable to reduce battery usage"),
        "app_web_sockets_settings_field_type_label":
            MessageLookupByLibrary.simpleMessage("Real-time updates"),
        "app_web_sockets_settings_title":
            MessageLookupByLibrary.simpleMessage("Data update (WebSockets)"),
        "app_web_sockets_settings_type_disabled":
            MessageLookupByLibrary.simpleMessage("Disabled"),
        "app_web_sockets_settings_type_foregroundAndBackground":
            MessageLookupByLibrary.simpleMessage(
                "Current screen & in background"),
        "app_web_sockets_settings_type_onlyForeground":
            MessageLookupByLibrary.simpleMessage("Only for current screen"),
        "async_init_state_failed": m51,
        "async_init_state_notStarted":
            MessageLookupByLibrary.simpleMessage("Async init not started"),
        "dialog_action_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "dialog_action_no": MessageLookupByLibrary.simpleMessage("No"),
        "dialog_action_ok": MessageLookupByLibrary.simpleMessage("OK"),
        "dialog_action_yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "dialog_error_content": m52,
        "dialog_error_title":
            MessageLookupByLibrary.simpleMessage("Something wrong"),
        "dialog_progress_action_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "dialog_progress_content":
            MessageLookupByLibrary.simpleMessage("Loading..."),
        "duration_day": m53,
        "duration_hour": m54,
        "duration_minute": m55,
        "file_picker_empty":
            MessageLookupByLibrary.simpleMessage("You don\'t have any media"),
        "file_picker_multi_selectionCountLimitReached_notification_content":
            m56,
        "file_picker_multi_selectionCountLimitReached_notification_title":
            MessageLookupByLibrary.simpleMessage(
                "Selection count limit reached"),
        "file_picker_multi_selectionCount_selected": m57,
        "file_picker_multi_title":
            MessageLookupByLibrary.simpleMessage("Choose media files"),
        "file_picker_selectionFolder_title":
            MessageLookupByLibrary.simpleMessage("Selection"),
        "file_picker_single_title":
            MessageLookupByLibrary.simpleMessage("Choose media"),
        "form_field_bool_onlyTrue_error_desc":
            MessageLookupByLibrary.simpleMessage("Should be enabled"),
        "form_field_int_error_length_maxOnlyValue_desc": m58,
        "form_field_int_error_length_minAndMax_desc": m59,
        "form_field_int_error_length_minOnlyValue_desc": m60,
        "form_field_text_email_error_invalid_desc":
            MessageLookupByLibrary.simpleMessage("Invalid email"),
        "form_field_text_error_empty_desc":
            MessageLookupByLibrary.simpleMessage("Must be not empty"),
        "form_field_text_error_length_maxOnly_desc": m61,
        "form_field_text_error_length_minAndMax_desc": m62,
        "form_field_text_error_length_minOnly_desc": m63,
        "form_field_text_password_error_notMatch_desc":
            MessageLookupByLibrary.simpleMessage(
                "Password and confirm password must match"),
        "form_field_text_url_error_invalid_desc":
            MessageLookupByLibrary.simpleMessage("Invalid URL"),
        "form_field_value_error_null_desc":
            MessageLookupByLibrary.simpleMessage("Required"),
        "link_error_dialog_content": m64,
        "link_error_dialog_title":
            MessageLookupByLibrary.simpleMessage("Can\'t launch URL"),
        "localization_locale_default":
            MessageLookupByLibrary.simpleMessage("Default"),
        "localization_locale_en":
            MessageLookupByLibrary.simpleMessage("English"),
        "localization_locale_ru":
            MessageLookupByLibrary.simpleMessage("Русский"),
        "pagination_list_empty":
            MessageLookupByLibrary.simpleMessage("Nothing found"),
        "permission_grant_action_grant":
            MessageLookupByLibrary.simpleMessage("Grant permission"),
        "timeago_aDay": MessageLookupByLibrary.simpleMessage("~1 d"),
        "timeago_aboutAMinute": MessageLookupByLibrary.simpleMessage("1 min"),
        "timeago_aboutAMonth": MessageLookupByLibrary.simpleMessage("~1 mo"),
        "timeago_aboutAYear": MessageLookupByLibrary.simpleMessage("~1 y"),
        "timeago_aboutAnHour": MessageLookupByLibrary.simpleMessage("~1 h"),
        "timeago_days": m65,
        "timeago_hours": m66,
        "timeago_lessThanOneMinute":
            MessageLookupByLibrary.simpleMessage("now"),
        "timeago_minutes": m67,
        "timeago_months": m68,
        "timeago_prefixAgo": MessageLookupByLibrary.simpleMessage(""),
        "timeago_prefixFromNow": MessageLookupByLibrary.simpleMessage(""),
        "timeago_suffixAgo": MessageLookupByLibrary.simpleMessage(""),
        "timeago_suffixFromNow": MessageLookupByLibrary.simpleMessage(""),
        "timeago_wordSeparator": MessageLookupByLibrary.simpleMessage(" "),
        "timeago_years": m69
      };
}
