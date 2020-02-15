// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pleroma_media_attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAttachment _$MediaAttachmentFromJson(Map<String, dynamic> json) {
  return MediaAttachment(
    description: json['description'] as String,
    id: json['id'] as String,
    previewUrl: json['preview_url'] as String,
    remoteUrl: json['remote_url'] as String,
    textUrl: json['text_url'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
    pleroma: json['pleroma'] == null
        ? null
        : MediaAttachmentPleromaPart.fromJson(
            json['pleroma'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MediaAttachmentToJson(MediaAttachment instance) =>
    <String, dynamic>{
      'description': instance.description,
      'id': instance.id,
      'preview_url': instance.previewUrl,
      'remote_url': instance.remoteUrl,
      'text_url': instance.textUrl,
      'type': instance.type,
      'url': instance.url,
      'pleroma': instance.pleroma,
    };

MediaAttachmentPleromaPart _$MediaAttachmentPleromaPartFromJson(
    Map<String, dynamic> json) {
  return MediaAttachmentPleromaPart(
    mimeType: json['mime_type'] as String,
  );
}

Map<String, dynamic> _$MediaAttachmentPleromaPartToJson(
        MediaAttachmentPleromaPart instance) =>
    <String, dynamic>{
      'mime_type': instance.mimeType,
    };
