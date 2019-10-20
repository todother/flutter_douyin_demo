import 'package:camera/camera.dart';
import 'package:camera/new/src/support_android/camera.dart';
import 'package:douyin_demo/providers/CameraProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class CameraPage extends StatelessWidget {
  const CameraPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: MultiProvider(providers: [
        ChangeNotifierProvider(
          builder: (_) => CameraProvider(),
        )
      ], child: CameraMain()),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}

// class CameraMain extends StatefulWidget {
//   CameraMain({Key key}) : super(key: key);

//   _CameraMainState createState() => _CameraMainState();
// }

// class _CameraMainState extends State<CameraMain> {
//   var cameras;
//   CameraController _controller;
//   @override
//   initState() {
//     // TODO: implement initState
//     super.initState();
//     initCamera();
//   }

//   Future initCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });

//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//   }
// }

class CameraMain extends StatelessWidget {
  const CameraMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CameraProvider provider = Provider.of<CameraProvider>(context);
    if (provider == null || provider.cameraController == null) {
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    double rpx = MediaQuery.of(context).size.width / 750;
    double toTop = 100 * rpx;
    double outBox = 170 * rpx;
    double innerBox = 130 * rpx;
    CameraController _controller = provider.cameraController;
    var cameras = provider.cameras;
    if (_controller == null || _controller?.value == null) {
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return _controller.value.isInitialized
        ? Stack(children: <Widget>[
            // Camera.open(cameraId),

            Transform.scale(
              scale: _controller.value.aspectRatio / deviceRatio,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ),
            ),
            Positioned(
              //顶部关闭按钮
              top: toTop,
              left: 30 * rpx,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 60 * rpx,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              //选择音乐
              top: toTop,
              left: 250 * rpx,
              child: Container(
                width: 250 * rpx,
                child: FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10 * rpx,
                      ),
                      Text(
                        "选择音乐",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              //拍照按钮
              bottom: 60 * rpx,
              // left: (750*rpx-outBox)/2,
              child: Container(
                  width: 750 * rpx,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconWithText(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            text: "道具"),
                        CircleTakePhoto(
                          outBox: outBox,
                          innerBox: innerBox,
                        ),
                        IconWithText(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            text: "道具"),
                      ])),
            ),
            Positioned(
              right: 30 * rpx,
              top: 80 * rpx,
              child: IconButton(
                  icon: Icon(Icons.camera_front),
                  onPressed: () {
                    provider.changeCamera();
                  }),
            )
          ])
        : Container();
  }
}


class CircleTakePhoto extends StatelessWidget {
  const CircleTakePhoto(
      {Key key, @required this.outBox, @required this.innerBox})
      : super(key: key);
  final double outBox;
  final double innerBox;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    CameraProvider provider = Provider.of<CameraProvider>(context);
    
    // double outBox=160*rpx;
    // double innerBox=130*rpx;
    return Container(
      width: outBox,
      height: outBox,
      padding: EdgeInsets.all(10 * rpx),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(90 * rpx),
        border: Border.all(
            width: 10 * rpx, color: Color.fromARGB(128, 219, 48, 85)),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () async {
          provider.changeFileName();
          print(provider.fileName);
          await provider.cameraController.takePicture(provider.fileName);
        },
        child: Container(
          width: innerBox,
          height: innerBox,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 219, 48, 85),
              borderRadius: BorderRadius.circular(75 * rpx)),
        )
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({Key key, @required this.icon, @required this.text})
      : super(key: key);
  final Icon icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        icon,
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
