import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/file/image/crop/file_image_crop_helper.dart';
import 'package:fedi/refactored/file/picker/file_picker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showEditMyAccountAvatarDialog(BuildContext context, FilePickerFile
filePickerFile, FilePickerSelectedFileCallback selectedCallback) {
  showDialog(
      context: context,
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)
            .tr("app.account.my.edit.field.header.dialog.title")),
        content: Image.file(filePickerFile.file),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                dismissDialog(context);
                selectedCallback(filePickerFile);
              },
              child: Text(AppLocalizations.of(context).tr(
                  "app.account.my.edit.field.header.dialog.action"
                      ".select"))),
          FlatButton(
              onPressed: () async {
                File croppedFile =
                await cropImage(filePickerFile.file, context);

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
              child: Text(AppLocalizations.of(context).tr(
                  "app.account.my.edit.field.header.dialog.action"
                      ".crop"))),
          FlatButton(
              onPressed: () {
                dismissDialog(context);
              },
              child: Text(AppLocalizations.of(context).tr(
                  "app.account.my.edit.field.header.dialog.action"
                      ".cancel"))),
        ],
      ));
}

void dismissDialog(BuildContext context) {
  Navigator.pop(context);
}
