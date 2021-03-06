import 'package:fedi/pleroma/api/tag/history/pleroma_api_tag_history_model.dart';

abstract class IHashtag {
  String get name;

  String get url;

  List<IPleromaApiTagHistory>? get history;
}

class Hashtag extends IHashtag {
  @override
  final String name;

  @override
  final List<IPleromaApiTagHistory>? history;

  @override
  final String url;

  Hashtag({
    required this.name,
    required this.url,
    required this.history,
  });

  @override
  String toString() {
    return 'Hashtag{name: $name, history: $history, url: $url}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hashtag &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          history == other.history &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ history.hashCode ^ url.hashCode;
}
