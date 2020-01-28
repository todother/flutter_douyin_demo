import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class FaceDetectionView extends StatefulWidget {
  FaceDetectionView({Key key}) : super(key: key);

  @override
  _FaceDetectionViewState createState() => _FaceDetectionViewState();
}

class _FaceDetectionViewState extends State<FaceDetectionView> {
  File filePath;
  @override
  void initState() { 
    super.initState();
    
  }
  chooseImage() async {
    filePath=await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 100,maxWidth: MediaQuery.of(context).size.width);
    var availableImage=filePath;
    // final FirebaseVisionImageMetadata metadata = FirebaseVisionImageMetadata(
    //     rawFormat: availableImage.format.raw,
    //     size: Size(
    //         availableImage.width.toDouble(), availableImage.height.toDouble()),
    //     planeData: availableImage.planes
    //         .map((currentPlane) => FirebaseVisionImagePlaneMetadata(
    //             bytesPerRow: currentPlane.bytesPerRow,
    //             height: currentPlane.height,
    //             width: currentPlane.width))
    //         .toList(),
    //     rotation: ImageRotation.rotation90);
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(filePath);
    final FaceDetector detector = FirebaseVision.instance.faceDetector();
    final List<Face> faces = await detector.processImage(visionImage);

    print(faces[0].boundingBox);

    setState(() {
      filePath=filePath;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RaisedButton(child: Text("选择图片"),onPressed: (){chooseImage();},),
        filePath==null?Container():
        Container(
           child: Image.file(filePath,fit: BoxFit.fitWidth,),
        )
      ]
    );
  }
}

class FaceMain extends StatelessWidget {
  const FaceMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FaceDetectionView(),
    );
  }
}