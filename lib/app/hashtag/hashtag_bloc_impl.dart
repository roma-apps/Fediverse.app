import 'package:collection/collection.dart';
import 'package:fedi/app/account/my/featured_hashtag/my_account_featured_hashtag_model.dart';
import 'package:fedi/app/account/my/featured_hashtag/my_account_featured_hashtag_model_adapter.dart';
import 'package:fedi/app/auth/instance/auth_instance_model.dart';
import 'package:fedi/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/app/hashtag/hashtag_bloc.dart';
import 'package:fedi/app/hashtag/hashtag_model.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:fedi/pleroma/api/featured_tags/pleroma_api_featured_tags_service.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class HashtagBloc extends DisposableOwner implements IHashtagBloc {
  @override
  final IHashtag hashtag;
  final IPleromaApiFeaturedTagsService pleromaApiFeaturedTagsService;
  final bool needLoadFeaturedState;

  final AuthInstance authInstance;

  @override
  bool get isInstanceSupportFeaturedTags => authInstance.isFeaturedTagsSupported;

  HashtagBloc({
    required this.hashtag,
    required this.pleromaApiFeaturedTagsService,
    required this.needLoadFeaturedState,
    required this.authInstance,
    required IMyAccountFeaturedHashtag? featuredHashtag,
  }) : featuredHashtagSubject = BehaviorSubject.seeded(featuredHashtag) {
    featuredHashtagSubject.disposeWith(this);
    isLoadingFeaturedHashtagStateSubject.disposeWith(this);

    if (needLoadFeaturedState && featuredHashtag == null) {
      loadFeaturedState();
    }
  }

  final BehaviorSubject<bool> isLoadingFeaturedHashtagStateSubject =
      BehaviorSubject.seeded(false);

  @override
  Stream<bool> get isLoadingFeaturedHashtagStateStream =>
      isLoadingFeaturedHashtagStateSubject.stream;

  @override
  bool get isLoadingFeaturedHashtagState =>
      isLoadingFeaturedHashtagStateSubject.value;

  final BehaviorSubject<IMyAccountFeaturedHashtag?> featuredHashtagSubject;

  @override
  bool get featured => featuredHashtag != null;

  @override
  Stream<bool> get featuredStream => featuredHashtagSubject.stream.map(
        (featuredHashtag) => featuredHashtag != null,
      );

  @override
  IMyAccountFeaturedHashtag? get featuredHashtag =>
      featuredHashtagSubject.value;

  @override
  Stream<IMyAccountFeaturedHashtag?> get featuredHashtagStream =>
      featuredHashtagSubject.stream;

  @override
  Future feature() async {
    assert(!featured);

    var pleromaApiFeatureTag = await pleromaApiFeaturedTagsService.featureTag(
      name: hashtag.name,
    );

    featuredHashtagSubject
        .add(pleromaApiFeatureTag.toMyAccountFeaturedHashtag());
  }

  @override
  Future unFeature() async {
    assert(featured);

    await pleromaApiFeaturedTagsService.unFeatureTag(
      id: featuredHashtag!.remoteId,
    );

    featuredHashtagSubject.add(null);
  }

  static HashtagBloc createFromContext(
    BuildContext context, {
    required IHashtag hashtag,
    required IMyAccountFeaturedHashtag? myAccountFeaturedHashtag,
    required bool needLoadFeaturedState,
  }) {
    var pleromaApiFeaturedTagsService =
        IPleromaApiFeaturedTagsService.of(context, listen: false);

    return HashtagBloc(
      pleromaApiFeaturedTagsService: pleromaApiFeaturedTagsService,
      hashtag: hashtag,
      authInstance:
          ICurrentAuthInstanceBloc.of(context, listen: false).currentInstance!,
      featuredHashtag: myAccountFeaturedHashtag,
      needLoadFeaturedState: needLoadFeaturedState,
    );
  }

  static Widget provideToContext(
    BuildContext context, {
    required Widget child,
    required IHashtag hashtag,
    required IMyAccountFeaturedHashtag? myAccountFeaturedHashtag,
    required bool needLoadFeaturedState,
  }) {
    return DisposableProvider<IHashtagBloc>(
      create: (context) => HashtagBloc.createFromContext(
        context,
        hashtag: hashtag,
        myAccountFeaturedHashtag: myAccountFeaturedHashtag,
        needLoadFeaturedState: needLoadFeaturedState,
      ),
      child: child,
    );
  }

  Future loadFeaturedState() async {
    if (!isInstanceSupportFeaturedTags) {
      return;
    }

    isLoadingFeaturedHashtagStateSubject.add(true);
    var pleromaApiFeaturedTags =
        await pleromaApiFeaturedTagsService.getFeaturedTags();

    var found = pleromaApiFeaturedTags
        .map(
          (pleromaApiFeaturedTag) =>
              pleromaApiFeaturedTag.toMyAccountFeaturedHashtag(),
        )
        .firstWhereOrNull(
          (featuredTag) => featuredTag.name == hashtag.name,
        );

    featuredHashtagSubject.add(found);

    isLoadingFeaturedHashtagStateSubject.add(false);
  }
}
