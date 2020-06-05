import 'package:carousel_pro/carousel_pro.dart';
import 'package:fedi/app/media/attachment/media_attachment_image_widget.dart';
import 'package:fedi/app/media/attachment/media_attachment_video_widget.dart';
import 'package:fedi/mastodon/media/attachment/mastodon_media_attachment_model.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

var _logger = Logger("status_media_attachments_widget.dart");

var _maxHeight = 350.0;

class MediaAttachmentsWidget extends StatelessWidget {
  final List<IPleromaMediaAttachment> mediaAttachments;

  const MediaAttachmentsWidget({@required this.mediaAttachments});

  @override
  Widget build(BuildContext context) {
    if (mediaAttachments?.isNotEmpty == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: SizedBox(
          width: double.infinity,
          child: buildChildren(context, mediaAttachments),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildChildren(
      BuildContext context, List<IPleromaMediaAttachment> mediaAttachments) {
    _logger.finest(() => "buildChildren ${mediaAttachments?.length}");

    List<Widget> children =
        mediaAttachments.map((IPleromaMediaAttachment attachment) {
      switch (attachment.typeMastodon) {
        case MastodonMediaAttachmentType.image:
          return MediaAttachmentImageWidget(
            attachment,
            maxHeight: _maxHeight,
          );
          break;

        case MastodonMediaAttachmentType.video:
        case MastodonMediaAttachmentType.audio:
          return MediaAttachmentVideoWidget(attachment);
          break;

        case MastodonMediaAttachmentType.unknown:
        case MastodonMediaAttachmentType.gifv:
        default:
          _logger.severe(() => "Can't display attachment = $attachment");
          return SizedBox.shrink();
          break;
      }
    }).toList();
    if (children.length == 1) {
      return children.first;
    } else {
      return buildCarousel(context, children);
    }
  }

  Widget buildCarousel(BuildContext context, List<Widget> children) =>
      LimitedBox(
        maxHeight: _maxHeight,
        child: Carousel(
          animationDuration: Duration(seconds: 0),
          overlayShadowColors: Colors.transparent,
          overlayShadowSize: 0.0,
          images: children,
          dotIncreasedColor:
              children.length == 1 ? Colors.transparent : Colors.blue,
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: children.length == 1
              ? Colors.transparent
              : Colors.blue.withOpacity(0.5),
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.transparent,
          borderRadius: true,
          autoplay: false,
        ),
      );
}
