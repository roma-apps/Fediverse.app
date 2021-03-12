import 'package:fedi/app/auth/instance/auth_instance_model.dart';
import 'package:fedi/app/timeline/type/timeline_type_model.dart';

extension TimelineRemoteTypeFilterSupportExtension on TimelineType {
  bool isOnlyWithMediaFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return true;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return true;
        break;
      case TimelineType.account:
        return true;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isExcludeRepliesFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return false;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return true;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isExcludeNsfwSensitiveFilterSupportedOnInstance(
      AuthInstance authInstance) {
    // actually we can filter on client-side but this will
    // require additional pagination handling
    return false;
  }

  bool isWebSocketsUpdatesFilterSupportedOnInstance(AuthInstance authInstance) {
    // actually we can filter on client-side but this will
    // require additional pagination handling
    return true;
  }

  bool isOnlyRemoteFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return true;
        break;
      case TimelineType.customList:
        return authInstance.isPleroma;
        break;
      case TimelineType.home:
        return authInstance.isPleroma;
        break;
      case TimelineType.hashtag:
        return authInstance.isPleroma;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isOnlyLocalFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return true;
        break;
      case TimelineType.customList:
        return authInstance.isPleroma;
        break;
      case TimelineType.home:
        return true;
        break;
      case TimelineType.hashtag:
        return authInstance.isPleroma;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isWithMutedFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return authInstance.isPleroma;
        break;
      case TimelineType.home:
        return authInstance.isPleroma;
        break;
      case TimelineType.customList:
        return authInstance.isPleroma;
        break;
      case TimelineType.hashtag:
        return authInstance.isPleroma;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isExcludeVisibilitiesFilterSupportedOnInstance(
      AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return authInstance.isPleroma;
        break;
      case TimelineType.home:
        return authInstance.isPleroma;
        break;
      case TimelineType.customList:
        return authInstance.isPleroma;
        break;
      case TimelineType.hashtag:
        return authInstance.isPleroma;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isOnlyInListWithRemoteIdFilterSupportedOnInstance(
      AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return false;
        break;
      case TimelineType.customList:
        return true;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isOnlyFromAccountWithRemoteIdFilterSupportedOnInstance(
      AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return false;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return true;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isWithHashtagFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return false;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return true;
        break;
      case TimelineType.account:
        return true;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }
  bool isOnlyFromInstanceFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return authInstance.isPleroma;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isReplyVisibilityFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return authInstance.isPleroma;
        break;
      case TimelineType.home:
        return authInstance.isPleroma;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return false;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isOnlyPinnedFilterSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return false;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return true;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }

  bool isExcludeReblogsSupportedOnInstance(AuthInstance authInstance) {
    switch (this) {
      case TimelineType.public:
        return false;
        break;
      case TimelineType.customList:
        return false;
        break;
      case TimelineType.home:
        return false;
        break;
      case TimelineType.hashtag:
        return false;
        break;
      case TimelineType.account:
        return true;
        break;
    }

    throw Exception("Invalid TimelineType $this");
  }
}
