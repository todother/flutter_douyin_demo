import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CameraProvider extends State<StatefulWidget>
    with ChangeNotifier, TickerProviderStateMixin {
  CameraController cameraController;
  TabController tabController;
  List<CameraDescription> cameras;
  int curCamera = 0;
  String appFolder = "";
  String fileName;
  Widget photoButton;
  bool ifMakeVideo=false;

  CameraProvider() {
    tabController=TabController(length: 6,vsync: this);
    getCameras();
  }

  changeFileName(afterFix) {
    String id = Uuid().v4().toString();
    fileName = p.join(appFolder, '$id.$afterFix');
    notifyListeners();
  }

  getCameras() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    if (!Directory(appDocDir.path).existsSync()) {
      appDocDir.createSync();
    }
    appFolder = appDocDir.path;
    cameras = await availableCameras();
    cameraController =
        CameraController(cameras[curCamera], ResolutionPreset.high);
    cameraController.initialize().then((_) {
      cameraController.prepareForVideoRecording();
      notifyListeners();
    });
  }

  changeCamera() {
    if (curCamera == 0) {
      curCamera = 1;
    } else {
      curCamera = 0;
    }
    cameraController =
        CameraController(cameras[curCamera], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      notifyListeners();
    });
  }

  changePhotoWidget(){
    ifMakeVideo=!ifMakeVideo;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }


}
