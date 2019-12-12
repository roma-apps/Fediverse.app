import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fedi/Pages/Post/Gallery/GalleryCapture.dart';
import 'package:fedi/Pages/Post/Photo/PhotoCapture.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image_cropper/image_cropper.dart';

import 'ProfileMediaPage.dart';

class ProfileImageEditor extends StatefulWidget {
  final String imageType;
  final Function(String) mediaUploaded;

  final int selectedIndex;
  ProfileImageEditor(this.selectedIndex, this.mediaUploaded, this.imageType);

  @override
  State<StatefulWidget> createState() {
    return _ProfileImageEditor();
  }
}

class _ProfileImageEditor extends State<ProfileImageEditor>
    with TickerProviderStateMixin {
  ValueNotifier<int> _showNext = ValueNotifier<int>(0);
  AssetEntity selectedAsset;
  TabController _controller;
  List<AppBar> _appBar;

  @override
  void initState() {
    super.initState();

    _controller = TabController(vsync: this, length: 3);
    _currentIndex = widget.selectedIndex;
    _controller.addListener(_controllerChanged);

    _appBar = _appBar = [
      AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Ediit ${widget.imageType}"),
      ),
      AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Ediit ${widget.imageType}"),
        actions: <Widget>[
          FlatButton(
            child: Text("Next"),
            textColor: Colors.white,
            color: Colors.transparent,
            onPressed: () {
              selectedAsset.file.then((value) {
                cropImage2(value.path);
              });
            },
          ),
        ],
      ),
    ];
  }

  void tabTapped(int index) {}

  _controllerChanged() {
    print("change");
    if (_controller.index == 1) {
      _showNext.value = 1;
    } else {
      _showNext.value = 0;
    }
  }

  pop() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  cropImage(String sourcepath) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: sourcepath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop ${widget.imageType}',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileMediaPage(
            type: widget.imageType,
            imageURL: croppedFile.path,
            popParent: pop,
            mediaUploaded: widget.mediaUploaded),
      ),
    );
  }

  cropImage2(String sourcepath) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: sourcepath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop ${widget.imageType}',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile == null) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileMediaPage(
            type: widget.imageType,
            imageURL: croppedFile.path,
            popParent: pop,
            mediaUploaded: widget.mediaUploaded),
      ),
    );
  }

  photoTaken(String uri) {
    print(uri);

    cropImage(uri);
  }

  gallerySelected(AssetEntity asset) {
    selectedAsset = asset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar[_currentIndex],
      body: _currentIndex == 0
          ? PhotoCapture(photoTaken)
          : GalleryCapture(
              gallerySelected,
              showVideo: false,
            ), // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.grey,
              title: Text('Photo'),
              icon: Container(height: 0.0)),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey,
            title: Text('Gallery'),
            icon: Container(height: 0.0),
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
