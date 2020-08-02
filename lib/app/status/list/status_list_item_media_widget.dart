import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedi/app/status/nsfw/status_nsfw_warning_overlay_widget.dart';
import 'package:fedi/app/status/status_bloc.dart';
import 'package:fedi/app/ui/progress/fedi_circular_progress_indicator.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

var _logger = Logger("status_list_item_media_widget.dart");

class StatusListItemMediaWidget extends StatelessWidget {
  StatusListItemMediaWidget() : super();

  Container mediaAttachmentPreviewUrlWidget(
      String previewUrl, BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.2),
      child: SizedBox.expand(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: previewUrl,
          placeholder: (context, url) => const Center(
            child: FediCircularProgressIndicator(),
          ),
          width: MediaQuery.of(context).size.width,
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var statusBloc = IStatusBloc.of(context, listen: true);

    _logger.finest(() =>
        "build ${statusBloc.remoteId} media ${statusBloc.mediaAttachments?.length}");

    var mediaAttachment = Provider.of<IPleromaMediaAttachment>(context);
    var previewUrl = mediaAttachment.previewUrl;
    return StreamBuilder<bool>(
        stream: statusBloc.nsfwSensitiveAndDisplayNsfwContentEnabledStream,
        initialData: statusBloc.nsfwSensitiveAndDisplayNsfwContentEnabled,
        builder: (context, snapshot) {
          var nsfwSensitiveAndDisplayNsfwContentEnabled = snapshot.data;

          var child = mediaAttachmentPreviewUrlWidget(previewUrl, context);
          if (nsfwSensitiveAndDisplayNsfwContentEnabled) {
            // todo: display all medias in list
            return child;
          } else {
            return StatusNsfwWarningOverlayWidget(
              child: child,
            );
          }
        });
  }
}
