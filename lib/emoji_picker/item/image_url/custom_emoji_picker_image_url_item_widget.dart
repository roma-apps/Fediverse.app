import 'package:fedi/app/cache/files/files_cache_service.dart';
import 'package:fedi/emoji_picker/item/image_url/custom_emoji_picker_image_url_item_model.dart';
import 'package:flutter/cupertino.dart';

class CustomEmojiPickerImageUrlItemWidget extends StatelessWidget {
  final CustomEmojiPickerImageUrlItem? item;

  const CustomEmojiPickerImageUrlItemWidget({Key? key, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: IFilesCacheService.of(context).createCachedNetworkImageWidget(
        imageUrl: item!.imageUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}
