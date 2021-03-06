import 'package:fedi/app/media/attachment/upload/upload_media_attachment_bloc.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/media/device/file/media_device_file_model.dart';
import 'package:fedi/pleroma/api/media/attachment/pleroma_api_media_attachment_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IUploadMediaAttachmentsCollectionBloc extends IDisposable {
  static IUploadMediaAttachmentsCollectionBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IUploadMediaAttachmentsCollectionBloc>(
        context,
        listen: listen,
      );

  List<IUploadMediaAttachmentBloc> get onlyMediaAttachmentBlocs;

  Stream<List<IUploadMediaAttachmentBloc>> get onlyMediaAttachmentBlocsStream;

  List<IUploadMediaAttachmentBloc> get onlyNonMediaAttachmentBlocs;

  Stream<List<IUploadMediaAttachmentBloc>>
      get onlyNonMediaAttachmentBlocsStream;

  bool get isMaximumMediaAttachmentCountReached;

  Stream<bool> get isMaximumMediaAttachmentCountReachedStream;

  int? get maximumMediaAttachmentCountLeft;

  Stream<int?> get maximumMediaAttachmentCountLeftStream;

  bool get isAllAttachedMediaUploaded;

  Stream<bool> get isAllAttachedMediaUploadedStream;

  int get maximumMediaAttachmentCount;

  int? get maximumFileSizeInBytes;

  bool get isPossibleToAttachMedia;

  Stream<bool> get isPossibleToAttachMediaStream;

  List<IUploadMediaAttachmentBloc> get mediaAttachmentBlocs;

  Stream<List<IUploadMediaAttachmentBloc>> get mediaAttachmentBlocsStream;

  Future attachMedia(IMediaDeviceFile mediaDeviceFile);

  Future attachMedias(List<IMediaDeviceFile> mediaDeviceFiles);

  void detachMediaAttachmentBloc(
    IUploadMediaAttachmentBloc mediaAttachmentBloc,
  );

  Future clear();

  void addUploadedAttachment(IPleromaApiMediaAttachment attachment);
}
