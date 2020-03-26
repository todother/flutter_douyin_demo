import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
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
  int curCamera = 1;
  String appFolder = "";
  String fileName;
  Widget photoButton;
  bool ifMakeVideo = false;
  FaceDetector faceDetector;

  CameraProvider() {
    tabController = TabController(length: 6, vsync: this);
    getCameras();
  }

  changeFileName(afterFix) {
    String id = Uuid().v4().toString();
    fileName = p.join(appFolder, '$id.$afterFix');
    notifyListeners();
  }

  captureFrame() {
   
    cameraController.startImageStream((CameraImage image)  {
      cameraController.stopImageStream();
      detectImage(image);
      captureFrame();
    });
  }

  detectImage(image) async {
    final List<Face> faces = await faceDetector.processImage(
          FirebaseVisionImage.fromBytes(image.planes[0].bytes, null));
          print(faces);
      if (faces.length > 0) {
        print(faces[0].headEulerAngleY);
      }
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
        
    try {
      await cameraController.initialize();
    } catch (e) {
      print(e);
    }
    
        // cameraController.startImageStream(onAvailable);
        
        notifyListeners();
    // cameraController.initialize().then((_) {
      
    //   cameraController.prepareForVideoRecording();
    //   faceDetector = FirebaseVision.instance.faceDetector();
    //   // captureFrame();
    //   notifyListeners();
    // });
  }

  dispose() {
    cameraController.dispose();
    super.dispose();
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

  changePhotoWidget() {
    ifMakeVideo = !ifMakeVideo;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
