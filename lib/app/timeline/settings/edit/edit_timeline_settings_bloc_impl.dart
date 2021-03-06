import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/settings/instance/edit/edit_instance_settings_bloc_impl.dart';
import 'package:fedi/app/status/visibility/form/multi_from_list/status_visibility_multi_select_from_list_form_field_bloc.dart';
import 'package:fedi/app/status/visibility/form/multi_from_list/status_visibility_multi_select_from_list_form_field_bloc_impl.dart';
import 'package:fedi/app/timeline/reply_visibility_filter/timeline_reply_visibility_single_select_from_list_value_form_field_bloc.dart';
import 'package:fedi/app/timeline/reply_visibility_filter/timeline_reply_visibility_single_select_from_list_value_form_field_bloc_impl.dart';
import 'package:fedi/app/timeline/settings/edit/edit_timeline_settings_bloc.dart';
import 'package:fedi/app/timeline/settings/only_from_account/timeline_settings_only_from_account_form_field_bloc.dart';
import 'package:fedi/app/timeline/settings/only_from_account/timeline_settings_only_from_account_form_field_bloc_impl.dart';
import 'package:fedi/app/timeline/settings/only_in_custom_list/timeline_settings_only_in_custom_list_form_field_bloc.dart';
import 'package:fedi/app/timeline/settings/only_in_custom_list/timeline_settings_only_in_custom_list_form_field_bloc_impl.dart';
import 'package:fedi/app/timeline/settings/timeline_settings_bloc.dart';
import 'package:fedi/app/timeline/settings/timeline_settings_filter_support_extension.dart';
import 'package:fedi/app/timeline/settings/timeline_settings_model.dart';
import 'package:fedi/app/timeline/type/timeline_type_model.dart';
import 'package:fedi/app/web_sockets/settings/web_sockets_settings_bloc.dart';
import 'package:fedi/form/field/value/bool/bool_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/bool/bool_value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/string/string_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/string/string_value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/validation/value_form_field_non_null_validation.dart';
import 'package:fedi/form/form_item_bloc.dart';
import 'package:fedi/pleroma/api/account/pleroma_api_account_model.dart';
import 'package:fedi/pleroma/api/instance/pleroma_api_instance_model.dart';
import 'package:fedi/pleroma/api/list/pleroma_api_list_model.dart';
import 'package:fedi/pleroma/api/timeline/pleroma_api_timeline_model.dart';
import 'package:fedi/pleroma/api/visibility/pleroma_api_visibility_model.dart';
import 'package:fedi/web_sockets/handling_type/web_sockets_handling_type_model.dart';

class EditTimelineSettingsBloc
    extends EditInstanceSettingsBloc<TimelineSettings?>
    implements IEditTimelineSettingsBloc {
  final IPleromaApiInstance pleromaApiInstance;
  @override
  final TimelineType timelineType;
  @override
  final bool isNullableValuesPossible;

  @override
  final IBoolValueFormFieldBloc onlyWithMediaFieldBloc;
  @override
  final IBoolValueFormFieldBloc excludeRepliesFieldBloc;
  @override
  final IBoolValueFormFieldBloc excludeNsfwSensitiveFieldBloc;

  @override
  final IBoolValueFormFieldBloc onlyRemoteFieldBloc;

  @override
  final IBoolValueFormFieldBloc onlyLocalFieldBloc;
  @override
  final IBoolValueFormFieldBloc onlyPinnedFieldBloc;

  @override
  final IBoolValueFormFieldBloc withMutedFieldBloc;

  @override
  final IBoolValueFormFieldBloc excludeReblogsFieldBloc;

  @override
  final ITimelineSettingsOnlyFromAccountFormFieldBloc onlyFromAccountFieldBloc;

  @override
  final IStringValueFormFieldBloc withRemoteHashtagFieldBloc;

  @override
  final ITimelineSettingsOnlyInCustomListFormFieldBloc
      onlyInCustomListFieldBloc;

  @override
  final ITimelineReplyVisibilityFilterSelectSingleFromListValueFormFieldBloc
      replyVisibilityFilterFieldBloc;

  @override
  IStatusVisibilityMultiSelectFromListFormFieldBloc
      excludeVisibilitiesFieldBloc;

  @override
  final IBoolValueFormFieldBloc webSocketsUpdatesFieldBloc;


  final IWebSocketsSettingsBloc webSocketsSettingsBloc;

  @override
  final IStringValueFormFieldBloc onlyFromInstanceFieldBloc;

  @override
  final InstanceLocation instanceLocation;

  EditTimelineSettingsBloc({
    required ITimelineSettingsBloc settingsBloc,
    required this.timelineType,
    required this.pleromaApiInstance,
    required this.isNullableValuesPossible,
    required this.instanceLocation,
    required bool isEnabled,
    required this.webSocketsSettingsBloc,
  })  : excludeRepliesFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.excludeReplies ?? false,
          isEnabled: timelineType
              .isExcludeRepliesFilterSupportedOnInstance(pleromaApiInstance),
        ),
        onlyWithMediaFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyWithMedia ?? false,
          isEnabled: timelineType
              .isOnlyWithMediaFilterSupportedOnInstance(pleromaApiInstance),
        ),
        excludeNsfwSensitiveFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.excludeNsfwSensitive ?? false,
          isEnabled:
              timelineType.isExcludeNsfwSensitiveFilterSupportedOnInstance(
            pleromaApiInstance,
          ),
        ),
        onlyRemoteFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyRemote ?? false,
          isEnabled: timelineType
              .isOnlyRemoteFilterSupportedOnInstance(pleromaApiInstance),
        ),
        onlyLocalFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyLocal ?? false,
          isEnabled: timelineType
              .isOnlyLocalFilterSupportedOnInstance(pleromaApiInstance),
        ),
        onlyPinnedFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyPinned ?? false,
          isEnabled: timelineType
              .isOnlyPinnedFilterSupportedOnInstance(pleromaApiInstance),
        ),
        excludeReblogsFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.excludeReblogs ?? false,
          isEnabled: timelineType
              .isExcludeReblogsSupportedOnInstance(pleromaApiInstance),
        ),
        withMutedFieldBloc = BoolValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.withMuted ?? false,
          isEnabled: timelineType
              .isWithMutedFilterSupportedOnInstance(pleromaApiInstance),
        ),
        onlyFromAccountFieldBloc = TimelineSettingsOnlyFromAccountFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyFromRemoteAccount,
          isNullValuePossible:
              isNullableValuesPossible || timelineType != TimelineType.account,
          isEnabled: timelineType
              .isOnlyFromAccountWithRemoteIdFilterSupportedOnInstance(
            pleromaApiInstance,
          ),
          validators: [
            if (timelineType == TimelineType.account)
              ValueFormFieldNonNullValidationError.createValidator(),
          ],
        ),
        onlyInCustomListFieldBloc =
            TimelineSettingsOnlyInCustomListFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyInRemoteList,
          isNullValuePossible: isNullableValuesPossible,
          isEnabled:
              timelineType.isOnlyInListWithRemoteIdFilterSupportedOnInstance(
            pleromaApiInstance,
          ),
          validators: [
            if (timelineType == TimelineType.customList)
              ValueFormFieldNonNullValidationError.createValidator(),
          ],
        ),
        withRemoteHashtagFieldBloc = StringValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.withRemoteHashtag ?? '',
          // ignore: no-magic-number
          maxLength: 50,
          isEnabled: timelineType
              .isWithHashtagFilterSupportedOnInstance(pleromaApiInstance),
          validators: [
            if (timelineType == TimelineType.hashtag)
              ValueFormFieldNonNullValidationError.createValidator(),
          ],
        ),
        replyVisibilityFilterFieldBloc =
            TimelineReplyVisibilityFilterSelectSingleFromListValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.replyVisibilityFilter,
          isEnabled: timelineType
              .isReplyVisibilityFilterSupportedOnInstance(pleromaApiInstance),
          validators: [],
          isNullValuePossible: true,
        ),
        excludeVisibilitiesFieldBloc =
            StatusVisibilityMultiSelectFromListFormFieldBloc(
          originValue: settingsBloc.settingsData?.excludeVisibilities ?? [],
          isEnabled:
              timelineType.isExcludeVisibilitiesFilterSupportedOnInstance(
            pleromaApiInstance,
          ),
          validators: [],
          isNullValuePossible: true,
        ),
        webSocketsUpdatesFieldBloc = BoolValueFormFieldBloc(
          originValue: (settingsBloc.settingsData?.webSocketsUpdates ?? true) &&
              webSocketsSettingsBloc.handlingType.isEnabled,
          isEnabled: timelineType.isWebSocketsUpdatesFilterSupportedOnInstance(
                pleromaApiInstance,
              ) &&
              webSocketsSettingsBloc.handlingType.isEnabled &&
              instanceLocation == InstanceLocation.local,
        ),
        onlyFromInstanceFieldBloc = StringValueFormFieldBloc(
          originValue: settingsBloc.settingsData?.onlyFromInstance ?? '',
          // ignore: no-magic-number
          maxLength: 50,
          isEnabled: timelineType
              .isOnlyFromInstanceFilterSupportedOnInstance(pleromaApiInstance),
          validators: [],
        ),
        super(
          isEnabled: isEnabled,
          settingsBloc: settingsBloc,
          isAllItemsInitialized: true,
        ) {
    addDisposable(excludeRepliesFieldBloc);
    addDisposable(onlyWithMediaFieldBloc);
    addDisposable(excludeNsfwSensitiveFieldBloc);
    addDisposable(onlyRemoteFieldBloc);
    addDisposable(onlyLocalFieldBloc);
    addDisposable(excludeReblogsFieldBloc);
    addDisposable(withMutedFieldBloc);

    addDisposable(onlyFromAccountFieldBloc);
    addDisposable(withRemoteHashtagFieldBloc);
    addDisposable(onlyInCustomListFieldBloc);
    addDisposable(replyVisibilityFilterFieldBloc);
    addDisposable(excludeVisibilitiesFieldBloc);
    addDisposable(onlyFromInstanceFieldBloc);
  }

  @override
  List<IFormItemBloc> get currentItems => [
        onlyWithMediaFieldBloc,
        excludeNsfwSensitiveFieldBloc,
        excludeRepliesFieldBloc,
        onlyRemoteFieldBloc,
        onlyLocalFieldBloc,
        withMutedFieldBloc,
        excludeReblogsFieldBloc,
        onlyPinnedFieldBloc,
        onlyFromAccountFieldBloc,
        withRemoteHashtagFieldBloc,
        onlyInCustomListFieldBloc,
        replyVisibilityFilterFieldBloc,
        excludeVisibilitiesFieldBloc,
        onlyFromInstanceFieldBloc,
      ];

  @override
  TimelineSettings calculateCurrentFormFieldsSettings() {
    var oldPreferences = settingsBloc.settingsData;

    var onlyFromInstanceExist =
        onlyFromInstanceFieldBloc.currentValue.isNotEmpty;

    var oldOnlyRemote = oldPreferences?.onlyRemote;
    var oldOnlyLocal = oldPreferences?.onlyLocal;

    var newOnlyRemote = onlyRemoteFieldBloc.currentValue;
    var newOnlyLocal = onlyLocalFieldBloc.currentValue;

    if (newOnlyLocal == true && oldOnlyLocal == false) {
      onlyFromInstanceExist = false;
      onlyFromInstanceFieldBloc.textEditingController.text = '';
      newOnlyRemote = false;
      onlyRemoteFieldBloc.changeCurrentValue(newOnlyRemote);
    }
    if (newOnlyRemote != true) {
      if (onlyFromInstanceExist) {
        newOnlyRemote = true;
        onlyRemoteFieldBloc.changeCurrentValue(newOnlyRemote);
      }
    }

    if (newOnlyRemote == true && oldOnlyRemote == false) {
      newOnlyLocal = false;
      onlyLocalFieldBloc.changeCurrentValue(newOnlyLocal);
    }

    return TimelineSettings(
      onlyWithMedia: onlyWithMediaFieldBloc.currentValue,
      excludeNsfwSensitive: excludeNsfwSensitiveFieldBloc.currentValue,
      excludeReplies: excludeRepliesFieldBloc.currentValue,
      onlyRemote: newOnlyRemote,
      onlyLocal: newOnlyLocal,
      withMuted: withMutedFieldBloc.currentValue,
      excludeVisibilitiesStrings: excludeVisibilitiesFieldBloc.currentValue
          .toPleromaApiVisibilityStrings(),
      onlyInRemoteList:
          onlyInCustomListFieldBloc.currentValue?.toPleromaApiList(),
      withRemoteHashtag: withRemoteHashtagFieldBloc.currentValue,
      replyVisibilityFilterString:
          replyVisibilityFilterFieldBloc.currentValue?.toJsonValue(),
      onlyFromRemoteAccount:
          onlyFromAccountFieldBloc.currentValue?.toPleromaApiAccount(),
      excludeReblogs: excludeReblogsFieldBloc.currentValue,
      onlyPinned: onlyPinnedFieldBloc.currentValue,
      webSocketsUpdates: webSocketsUpdatesFieldBloc.currentValue,
      onlyFromInstance: onlyFromInstanceFieldBloc.currentValue,
    );
  }

  @override
  Future fillSettingsToFormFields(TimelineSettings? settings) async {
    if (settings == null) {
      return;
    }
    onlyWithMediaFieldBloc.changeCurrentValue(settings.onlyWithMedia);
    excludeNsfwSensitiveFieldBloc
        .changeCurrentValue(settings.excludeNsfwSensitive);
    excludeRepliesFieldBloc.changeCurrentValue(settings.excludeReplies);
    onlyRemoteFieldBloc.changeCurrentValue(settings.onlyRemote);
    onlyLocalFieldBloc.changeCurrentValue(settings.onlyLocal);
    withMutedFieldBloc.changeCurrentValue(settings.withMuted);
    excludeReblogsFieldBloc.changeCurrentValue(settings.excludeReblogs);
    onlyPinnedFieldBloc.changeCurrentValue(settings.onlyPinned);

    onlyFromAccountFieldBloc.changeCurrentValue(settings.onlyFromRemoteAccount);
    onlyFromAccountFieldBloc.changeCurrentValue(settings.onlyFromRemoteAccount);
    withRemoteHashtagFieldBloc
        .changeCurrentValue(settings.withRemoteHashtag ?? '');
    onlyInCustomListFieldBloc.changeCurrentValue(settings.onlyInRemoteList);
    replyVisibilityFilterFieldBloc
        .changeCurrentValue(settings.replyVisibilityFilter);
    excludeVisibilitiesFieldBloc
        .changeCurrentValue(settings.excludeVisibilities ?? []);
  }
}
