import 'dart:io';

import 'package:fedi/app/file/image/crop/file_image_crop_helper.dart';
import 'package:fedi/app/profile/edit/profile_edit_select_image_page.dart';
import 'package:fedi/file/picker/file_picker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileEditSelectAvatarPage extends ProfileEditSelectImagePage {
  ProfileEditSelectAvatarPage(
      {@required ImageFileSelectedCallback selectedCallback})
      : super(selectedCallback: selectedCallback);

  @override
  Widget createAppBarTitle(BuildContext context) {
    return Text("Select avatar");
  }

  @override
  onFileSelected(BuildContext context, FilePickerFile filePickerFile) {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Confirm selection?"),
          content: Image.file(filePickerFile.file),
          actions: <Widget>[
            FlatButton(
                onPressed: () async {
                  File croppedFile =
                      await cropImageToSquare(filePickerFile.file, context);

                  dismissDialog(context);
                  if (croppedFile != null) {
                    if (filePickerFile.isNeedDeleteAfterUsage) {
                      filePickerFile.file.delete();
                    }

                    selectedCallback(FilePickerFile(
                        file: croppedFile,
                        type: filePickerFile.type,
                        isNeedDeleteAfterUsage: true));
                  } else {
                    selectedCallback(filePickerFile);
                  }
                },
                child: Text("Select & Crop")),
            FlatButton(
                onPressed: () {
                  dismissDialog(context);
                },
                child: Text("Cancel")),
          ],
        ));
  }

  void dismissDialog(BuildContext context) {
        Navigator.pop(context);
  }
}
