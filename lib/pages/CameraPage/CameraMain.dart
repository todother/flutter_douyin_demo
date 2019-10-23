import 'dart:io';

import 'package:camera/camera.dart';
import 'package:douyin_demo/providers/CameraProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'dart:core';

class CameraPage extends StatelessWidget {
  const CameraPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return MultiProvider(
        providers: [ChangeNotifierProvider(builder: (_) => CameraProvider())],
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: CameraMain(),
          // bottomNavigationBar: SafeArea(
          //   child: Container(
          //     height: 100*rpx,
          //     child: BottomTab()
          //   )
          // ),
        ));
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
    return _controller.value.isInitialized
        ? Stack(children: <Widget>[
            ClipRect(
                child: Transform.scale(
              scale: _controller.value.aspectRatio / size.aspectRatio,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ),
            )),
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
              bottom: 100 * rpx,
              // left: (750*rpx-outBox)/2,
              child: Container(
                  width: 750 * rpx,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        provider.ifMakeVideo
                            ? Container(width: 80*rpx,)
                            : IconWithText(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                text: "道具"),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: provider.ifMakeVideo
                              ? VideoButtonAnim(
                                  provider: provider,
                                  rpx: rpx,
                                  outWidth: outBox,
                                  innerWidth: innerBox - 40 * rpx,
                                )
                              : CircleTakePhoto(
                                  outBox: outBox,
                                  innerBox: innerBox,
                                ),
                        ),
                        provider.ifMakeVideo
                            ? Container(
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(128, 219, 48, 85),
                                    size: 80*rpx,
                                  ),
                                  onPressed: () async {
                                    provider.cameraController
                                        .stopVideoRecording();
                                    // await ImagePickerSaver.saveFile(
                                    //     fileData: File(provider.fileName)
                                    //         .readAsBytesSync());

                                    await ImageGallerySaver.saveFile(provider.fileName);
                                    File(provider.fileName).deleteSync();
                                    provider.changePhotoWidget();
                                  },
                                ),
                              )
                            : IconWithText(
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
            ),
            provider.ifMakeVideo//底部导航栏
                ? Container()
                : Positioned(
                    bottom: 0,
                    left: 0,
                    child: ScrollTabBar(
                      rpx: rpx,
                    ),
                  )
          ])
        : Container();
  }
}

class ScrollTabBar extends StatefulWidget {
  ScrollTabBar({Key key, @required this.rpx}) : super(key: key);
  final double rpx;
  _ScrollTabBarState createState() => _ScrollTabBarState();
}

class _ScrollTabBarState extends State<ScrollTabBar>
    with AutomaticKeepAliveClientMixin {
  double curCenter = 0;
  ScrollController controller;
  List<String> items = ['拍照', '拍15秒', '拍60秒', '影集', '直播'];
  double eachWidth;
  double eachSide;
  double rpx;
  double maxPos;
  double minPos;
  double startDx = 0;
  double finalDx = 0;
  int curIndex = 2;
  @override
  void initState() {
    super.initState();
    rpx = widget.rpx;
    eachWidth = 130 * rpx;
    eachSide = (750 - eachWidth / rpx) / 2 * rpx;
    curCenter = curIndex * eachWidth;
    maxPos = eachWidth * items.length;
    minPos = 0;
    controller = ScrollController(initialScrollOffset: curCenter);
  }

  moveToItem(index) {
    controller.animateTo(index * eachWidth,
        duration: Duration(milliseconds: 200), curve: Curves.linearToEaseOut);
    setState(() {
      curCenter = index * eachWidth;
      curIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (result) {
          setState(() {
            startDx = result.position.dx;
          });
        },
        onPointerUp: (result) {
          finalDx = result.position.dx;
          double finalPosition = curCenter + startDx - finalDx;
          int index = (finalPosition / eachWidth).floor();
          // print('curCenter=$index,moveTo:$index');
          moveToItem(index);
        },
        child: Container(
            width: 750 * rpx,
            child: Column(children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: controller,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            width: eachSide,
                          ),
                          Row(
                            children: List.generate(
                                items.length,
                                (index) => Container(
                                      width: eachWidth,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        child: Text(
                                          items[index],
                                          style: TextStyle(
                                              fontSize: 28 * rpx,
                                              color: curIndex == index
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(0.3)),
                                        ),
                                        onPressed: () {
                                          moveToItem(index);
                                        },
                                      ),
                                    )),
                          ),
                          Container(
                            width: eachSide,
                          ),
                        ],
                      ),
                    ]),
              ),
              Container(
                height: 8 * rpx,
                width: 750 * rpx,
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                )),
              ),
              SizedBox(
                height: 10 * rpx,
              )
            ])));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class VideoButtonAnim extends StatefulWidget {
  VideoButtonAnim(
      {Key key,
      @required this.rpx,
      @required this.outWidth,
      @required this.innerWidth,
      @required this.provider})
      : super(key: key);
  final double rpx;
  final double outWidth;
  final double innerWidth;
  final CameraProvider provider;
  _VideoButtonAnimState createState() => _VideoButtonAnimState();
}

class _VideoButtonAnimState extends State<VideoButtonAnim>
    with TickerProviderStateMixin {
  double extraPadding = 0; //内外圆之间距离
  double borderWidth = 0;
  double outWidth = 0;
  double innerWidth = 0;
  double minDist = 0;
  double rpx = 0;
  Animation<double> animation;
  AnimationController controller;
  CameraProvider provider;
  bool ifPauseVideo = false;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    rpx = widget.rpx;
    outWidth = widget.outWidth;
    innerWidth = widget.innerWidth;
    provider = widget.provider;
    minDist = 10 * rpx;
    extraPadding = (outWidth - innerWidth) / 2 - borderWidth;
    borderWidth = 15 * rpx;
    controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animation =
        Tween(begin: (outWidth - innerWidth) / 2 - borderWidth, end: minDist)
            .animate(controller)
              ..addListener(() {
                setState(() {
                  borderWidth = animation.value;
                  extraPadding = (outWidth - innerWidth) / 2 - animation.value;
                });
              });
    controller.repeat(reverse: true);
    // controller.forward(from: 0.0).then((f){
    //   controller.reverse(from: 1.0);
    // });
  }

  pauseAnimation() {
    controller.reset();
    provider.cameraController.pauseVideoRecording();
    setState(() {
      ifPauseVideo = true;
    });
  }

  playAnimation() {
    controller.repeat(reverse: true);
    provider.cameraController.resumeVideoRecording();
    setState(() {
      ifPauseVideo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: outWidth,
      height: outWidth,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: borderWidth, color: Color.fromARGB(128, 219, 48, 85))),
      padding: EdgeInsets.all(extraPadding),
      child: Center(
        child: Container(
          width: innerWidth,
          height: innerWidth,
          // decoration: BoxDecoration(
          //     color: Color.fromARGB(255, 219, 48, 85),
          //     borderRadius: BorderRadius.circular(20 * rpx)),
          child: ifPauseVideo
              ? IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.pause_circle_filled,
                    size: innerWidth,
                    color: Color.fromARGB(255, 219, 48, 85),
                  ),
                  onPressed: () {
                    playAnimation();
                  },
                )
              : IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.play_circle_filled,
                    size: innerWidth,
                    color: Color.fromARGB(255, 219, 48, 85),
                  ),
                  onPressed: () {
                    pauseAnimation();
                  },
                ),
        ),
      ),
    );
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
            // provider.changeFileName();
            // print(provider.fileName);
            // await provider.cameraController
            //     .takePicture(provider.fileName)
            //     .then((_) {
            //   // Navigator.push(context, MaterialPageRoute(fullscreenDialog: true,builder: (_){
            //   //   return Image.file(File(provider.fileName) );
            //   // }));

            //   ImagePickerSaver.saveFile(
            //       fileData: File(provider.fileName).readAsBytesSync());
            //   File(provider.fileName).deleteSync();
            // });
            provider.changePhotoWidget();
            provider.changeFileName('mp4');
            provider.cameraController.startVideoRecording(provider.fileName);
          },
          child: Container(
            width: innerBox,
            height: innerBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 219, 48, 85),
                borderRadius: BorderRadius.circular(75 * rpx)),
          )),
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
