import 'dart:io';

import 'package:fedi/app/media/camera/camera_media_service.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:image_picker/image_picker.dart';

class CameraMediaService extends DisposableOwner
    implements ICameraMediaService {
  final ImagePicker imagePicker = ImagePicker();

  @override
  Future<File?> pickImageFromCamera() async {
    var pickerImage = await imagePicker.getImage(source: ImageSource.camera);
    var file = fileFromImage(pickerImage);

    return file;
  }

  @override
  Future<File?> pickVideoFromCamera() async {
    var pickerImage = await imagePicker.getVideo(source: ImageSource.camera);
    var file = fileFromImage(pickerImage);

    return file;
  }

  File? fileFromImage(PickedFile? imageFile) {
    var path = imageFile?.path;
    File? file;
    if (path != null) {
      file = File(path);
    }

    return file;
  }


}
