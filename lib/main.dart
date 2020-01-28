import 'dart:io';

import 'package:douyin_demo/pages/RecommendPage/BottomSheet.dart';
import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:douyin_demo/widgets/BottomBar.dart';
// import 'package:douyin_demo/widgets/FavAnimation.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:marquee/marquee.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'widgets/FavAnimation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  // String hosts = prefs.get('urlPath');
  // String scheme = prefs.get('scheme');
  // int ports = prefs.get('ports');
  prefs.setBool("ifIOS", Platform.isIOS);
  prefs.setBool("ifPrd", false);
  prefs.setBool("ifReal_d", false);

  prefs.setString("urlPath_real_d", "192.168.0.8");
  prefs.setString("scheme_real_d", "http");
  prefs.setInt("ports_real_d", 5000);

  prefs.setString("urlPath_ios_d", "127.0.0.1");
  prefs.setString("scheme_ios_d", "http");
  prefs.setInt("ports_ios_d", 5000);

  prefs.setString("urlPath_and_d", "10.0.2.2");
  prefs.setString("scheme_and_d", "http");
  prefs.setInt("ports_and_d", 5000);

  prefs.setString("urlPath_p", "118.26.177.76");
  prefs.setString("scheme_p", "http");
  prefs.setInt("ports_p", 80);

  prefs.setString("picServer", "http://www.guojio.com");

  runApp(MyApp());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "某音",
      theme: ThemeData(primaryColor: Color(0xff121319)),
      home: RecommendPage(
        selIndex: 0,
      ),
    );
  }
}

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key key, @required this.selIndex}) : super(key: key);
  final int selIndex;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (context) => RecommendProvider(),
          )
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            MainTabView(),
            Positioned(
              top: 20 * rpx,
              // height: 120,
              width: 750 * rpx,
              child: SafeArea(
                  child: Container(
                // decoration: BoxDecoration(color: Colors.pinkAccent),
                child: TopTab(),
              )),
            ),
          ]),
          bottomNavigationBar: BottomSafeBar(
            selIndex: selIndex,
          ),
        ));
  }
}

class MainTabView extends StatelessWidget {
  const MainTabView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    return TabBarView(
      
      controller: provider.controller,
      children: <Widget>[
        SwiperMain(type: "followed",),
        SwiperMain(type: "recommend",),
      ],
    );
  }
}

class SwiperMain extends StatefulWidget {
  SwiperMain({Key key,this.type}) : super(key: key);
  final String type;
  _SwiperMainState createState() => _SwiperMainState();
}

class _SwiperMainState extends State<SwiperMain> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    List<MainInfo> infos=List<MainInfo>();
    if(widget.type=="followed"){
      infos=provider.followed;
    }
    else{
      infos=provider.infos;
    }
    return Swiper(
      loop: false,
      scrollDirection: Axis.vertical,
      itemCount: infos.length,
      itemBuilder: (context, index) {
        MainInfo curData = infos[index];
        return Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(children: [
            CenterImage(
              videoPath: curData.videoPath,
            ),
            Home(),
          ]),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// class SwiperMain extends StatelessWidget {
//   const SwiperMain({Key key,@required this.type}) : super(key: key);
//   final String type;
//   @override
//   Widget build(BuildContext context) {
//     RecommendProvider provider = Provider.of<RecommendProvider>(context);
//     List<MainInfo> infos=List<MainInfo>();
//     if(type=="followed"){
//       infos=provider.followed;
//     }
//     else{
//       infos=provider.infos;
//     }
//     return Swiper(
//       loop: false,
//       scrollDirection: Axis.vertical,
//       itemCount: infos.length,
//       itemBuilder: (context, index) {
//         MainInfo curData = infos[index];
//         return Container(
//           decoration: BoxDecoration(color: Colors.black),
//           child: Stack(children: [
//             CenterImage(
//               videoPath: curData.videoPath,
//             ),
//             Home(),
//           ]),
//         );
//       },
//     );
//   }
// }

class BottomSafeBar extends StatelessWidget {
  const BottomSafeBar({Key key, @required this.selIndex}) : super(key: key);
  final int selIndex;
  @override
  Widget build(BuildContext context) {
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    // double toBottom=MediaQuery.of(context).viewInsets.bottom;
    return Container(
      // padding: EdgeInsets.only(top:toBottom),
      decoration: BoxDecoration(color: Colors.black),
      child: SafeArea(
          child: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          height: 60,
          // decoration: BoxDecoration(color: Colors.black),
          child: BtmBar(
            selectIndex: selIndex,
          ),
        ),
      )),
    );
  }
}

class CenterImage extends StatelessWidget {
  const CenterImage({Key key, @required this.videoPath}) : super(key: key);
  final String videoPath;
  @override
  Widget build(BuildContext context) {
    // double bottom = MediaQuery.of(context).viewInsets.bottom;
    // RecommendProvider provider = Provider.of<RecommendProvider>(context);
    return Center(
      child: Container(
          // padding: EdgeInsets.only(top: bottom),
          child: Image.asset(videoPath)),
    );
  }
}

class VideoBack extends StatefulWidget {
  VideoBack({Key key}) : super(key: key);

  _VideoBackState createState() => _VideoBackState();
}

class _VideoBackState extends State<VideoBack> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  String url =
      "https://www.guojio.com/video/07a7faa1-3696-4af7-aeac-2d6cf6bf25f9.mp4";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(this.url)
      // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.initialized
          // 加载成功
          ? new AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : new Container(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);

    double rpx = screenWidth / 750;
    return Stack(children: [
      Positioned(
        bottom: 0,
        width: 0.70 * screenWidth,
        height: 260 * rpx,
        child: Container(
          // decoration: BoxDecoration(color: Colors.redAccent),
          child: BtnContent(),
        ),
      ),
      Positioned(
        right: 0,
        width: 0.2 * screenWidth,
        height: 500 * rpx,
        top: 0.45 * screenHeight,
        child: Container(
          // decoration: BoxDecoration(color: Colors.orangeAccent),
          child: ButtonList(),
        ),
      ),
      Positioned(
        bottom: 20 * rpx,
        right: 0,
        width: 0.2 * screenWidth,
        height: 0.2 * screenWidth,
        child: Container(
          // decoration: BoxDecoration(color: Colors.purpleAccent),
          child: RotateAlbum(),
        ),
      )
    ]);
  }
}

class TopTab extends StatefulWidget {
  TopTab({Key key}) : super(key: key);

  _TopTabState createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> with SingleTickerProviderStateMixin {
  // TabController _controller;
  // RecommendProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TabController(vsync: this, length: 2, initialIndex: 1);
    
  }

  @override
  Widget build(BuildContext context) {
    RecommendProvider provider=Provider.of<RecommendProvider>(context);
    double rpx = MediaQuery.of(context).size.width / 750;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // BottomNavigationBar(items: [BottomNavigationBarItem(icon: null,)],)
        SizedBox(
          width: 17 * rpx,
        ),
        Icon(
          Icons.search,
          size: 50 * rpx,
          color: Colors.white,
        ),
        Container(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 90 * rpx),
                width: 500 * rpx,
                child: TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                  unselectedLabelStyle:
                      TextStyle(color: Colors.grey[700], fontSize: 18),
                  controller: provider.controller,
                  tabs: <Widget>[Text("关注"), Text("推荐")],
                ))),
        Icon(
          Icons.live_tv,
          size: 30,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class BtnContent extends StatelessWidget {
  const BtnContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              "@${provider.mainInfo.userName}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            subtitle: Text(
              "${provider.mainInfo.content}",
              style: TextStyle(color: Colors.white, fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              // Marquee(text: "",),

              // Container(
              //     width: 200,
              //     height: 20,
              //     child: MarqueeWidget(
              //       text: '${provider.mainInfo.desc}',
              //       textStyle: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //           fontSize: 16),
              //       // scrollAxis: Axis.horizontal,
              //       // crossAxisAlignment: CrossAxisAlignment.start,
              //       // blankSpace: 20.0,
              //       // velocity: 100.0,
              //       // pauseAfterRound: Duration(seconds: 1),
              //       // startPadding: 10.0,
              //       // accelerationDuration: Duration(seconds: 1),
              //       // accelerationCurve: Curves.linear,
              //       // decelerationDuration: Duration(milliseconds: 500),
              //       // decelerationCurve: Curves.easeOut,
              //     ))
            ],
          )
        ],
      ),
    );
  }
}

class RotateAlbum extends StatefulWidget {
  RotateAlbum({Key key}) : super(key: key);

  _RotateAlbumState createState() => _RotateAlbumState();
}

class _RotateAlbumState extends State<RotateAlbum>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation = RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            // _controller.forward(from: 0.0);
          }
        }),
      child: Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D500/sign=dde475320ee9390152028d3e4bec54f9/d009b3de9c82d1586d8294a38f0a19d8bc3e42a4.jpg"),
      )),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: animation,
    );
  }
}

class ButtonList extends StatefulWidget {
  ButtonList({Key key}) : super(key: key);

  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    List<IconAnimationStage> stages1 = List<IconAnimationStage>();
    stages1.add(IconAnimationStage(
        color: Colors.grey[100],
        start: 1.0,
        end: 0.0,
        duration: Duration(milliseconds: 200)));
    stages1.add(IconAnimationStage(
        color: Colors.redAccent,
        start: 0.0,
        end: 1.3,
        duration: Duration(milliseconds: 300)));
    stages1.add(IconAnimationStage(
        color: Colors.redAccent,
        start: 1.3,
        end: 1.0,
        duration: Duration(milliseconds: 100)));

    List<IconAnimationStage> stages2 = List<IconAnimationStage>();
    stages2.add(IconAnimationStage(
        color: Colors.grey[100],
        start: 1.0,
        end: 1.2,
        duration: Duration(milliseconds: 200)));
    stages2.add(IconAnimationStage(
        color: Colors.grey[100],
        start: 1.2,
        end: 1.0,
        duration: Duration(milliseconds: 200)));

    List<IconAnimationStage> stages3 = List<IconAnimationStage>();
    stages3.add(IconAnimationStage(
        color: Colors.redAccent,
        start: 1.0,
        end: 1.2,
        duration: Duration(milliseconds: 200)));
    stages3.add(IconAnimationStage(
        color: Colors.grey[100],
        start: 1.2,
        end: 1.0,
        duration: Duration(milliseconds: 200)));
    double iconSize = 70 * rpx;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 90 * rpx,
              height: 105 * rpx,
              child: Stack(
                children: <Widget>[
                  Container(
                      // decoration: BoxDecoration(c),
                      width: 90 * rpx,
                      height: 90 * rpx,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${provider.mainInfo.avatarUrl}"),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 25 * rpx,
                    child: Container(
                      width: 40 * rpx,
                      height: 40 * rpx,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
          IconText(
            text: "${provider.mainInfo.favCount}",
            icon: !provider.mainInfo.ifFaved
                ? AnimatedIconWidget(
                    key: UniqueKey(),
                    animationList: stages1,
                    icon: Icons.favorite,
                    size: iconSize,
                    provider: provider,
                    callback: () {
                      provider.tapFav();
                    })
                : AnimatedIconWidget(
                    key: UniqueKey(),
                    animationList: stages3,
                    icon: Icons.favorite,
                    size: iconSize,
                    provider: provider,
                    callback: () {
                      provider.tapFav();
                    },
                  ),
          ),
          IconText(
            text: "${provider.mainInfo.replyCount}",
            icon: AnimatedIconWidget(
              animationList: stages2,
              icon: Icons.comment,
              size: iconSize,
              callbackDelay: Duration(milliseconds: 200),
              callback: () {
                showBottom(context, provider);
              },
            ),
          ),
          IconText(
            text: "${provider.mainInfo.shareCount}",
            icon: AnimatedIconWidget(
              animationList: stages2,
              icon: Icons.reply,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}

// class ButtonList extends StatelessWidget {
//   const ButtonList({Key key}) : super(key: key);

//   @override

// }

// getButtonList(double rpx, RecommendProvider provider, BuildContext context) {

//   return
// }

class IconText extends StatelessWidget {
  const IconText({Key key, this.icon, this.text}) : super(key: key);
  final AnimatedIconWidget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon,
          Container(
              // alignment: Alignment.center,
              child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 25 * rpx),
          )),
        ],
      ),
    );
  }
}

showBottom(context, provider) {
  // RecommendProvider provider = Provider.of<RecommendProvider>(context);
  double height = MediaQuery.of(context).size.height;
  provider.setScreenHeight(height);
  provider.hideBottomBar();
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      context: context,
      builder: (_) {
        return Container(
            height: 600,
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ReplyFullList(pCtx: context)));
      });
}




// import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'detector_painters.dart';
// import 'utils.dart';

// void main() => runApp(MaterialApp(home: MyHomePage()));

// class MyHomePage extends StatefulWidget {
//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   dynamic _scanResults;
//   CameraController _camera;

//   Detector _currentDetector = Detector.text;
//   bool _isDetecting = false;
//   CameraLensDirection _direction = CameraLensDirection.back;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   void _initializeCamera() async {
//     CameraDescription description = await getCamera(_direction);
//     ImageRotation rotation = rotationIntToImageRotation(
//       description.sensorOrientation,
//     );

//     _camera = CameraController(
//       description,
//       defaultTargetPlatform == TargetPlatform.iOS
//           ? ResolutionPreset.low
//           : ResolutionPreset.high,
//     );
//     await _camera.initialize();

//     _camera.startImageStream((CameraImage image) {
//       if (_isDetecting) return;

//       _isDetecting = true;

//       detect(image, _getDetectionMethod(), rotation).then(
//         (dynamic result) {
//           setState(() {
//             _scanResults = result;
//           });

//           _isDetecting = false;
//         },
//       ).catchError(
//         (_) {
//           _isDetecting = false;
//         },
//       );
//     });
//   }

//   HandleDetection _getDetectionMethod() {
//     final FirebaseVision mlVision = FirebaseVision.instance;

//     switch (_currentDetector) {
//       case Detector.text:
//         return mlVision.textRecognizer().processImage;
//       case Detector.barcode:
//         return mlVision.barcodeDetector().detectInImage;
//       // case Detector.label:
//       //   return mlVision.labelDetector().detectInImage;
//       // case Detector.cloudLabel:
//       //   return mlVision.cloudLabelDetector().detectInImage;
//       default:
//         assert(_currentDetector == Detector.face);
//         return mlVision.faceDetector().processImage;
//     }
//   }

//   Widget _buildResults() {
//     const Text noResultsText = const Text('No results!');

//     if (_scanResults == null ||
//         _camera == null ||
//         !_camera.value.isInitialized) {
//       return noResultsText;
//     }

//     CustomPainter painter;

//     final Size imageSize = Size(
//       _camera.value.previewSize.height,
//       _camera.value.previewSize.width,
//     );

//     switch (_currentDetector) {
//       case Detector.barcode:
//         if (_scanResults is! List<Barcode>) return noResultsText;
//         painter = BarcodeDetectorPainter(imageSize, _scanResults);
//         break;
//       case Detector.face:
//         if (_scanResults is! List<Face>) return noResultsText;
//         painter = FaceDetectorPainter(imageSize, _scanResults);
//         break;
//       // case Detector.label:
//       //   if (_scanResults is! List<Label>) return noResultsText;
//       //   painter = LabelDetectorPainter(imageSize, _scanResults);
//       //   break;
//       // case Detector.cloudLabel:
//       //   if (_scanResults is! List<Label>) return noResultsText;
//       //   painter = LabelDetectorPainter(imageSize, _scanResults);
//       //   break;
//       default:
//         assert(_currentDetector == Detector.text);
//         if (_scanResults is! VisionText) return noResultsText;
//         painter = TextDetectorPainter(imageSize, _scanResults);
//     }

//     return CustomPaint(
//       painter: painter,
//     );
//   }

//   Widget _buildImage() {
//     return Container(
//       constraints: const BoxConstraints.expand(),
//       child: _camera == null
//           ? const Center(
//               child: Text(
//                 'Initializing Camera...',
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 30.0,
//                 ),
//               ),
//             )
//           : Stack(
//               // fit: StackFit.expand,
//               children: <Widget>[
//                 AspectRatio(
//                   aspectRatio: _camera.value.aspectRatio,
//                   child: CameraPreview(_camera)
//                 ),
//                 _buildResults(),
//               ],
//             ),
//     );
//   }

//   void _toggleCameraDirection() async {
//     if (_direction == CameraLensDirection.back) {
//       _direction = CameraLensDirection.front;
//     } else {
//       _direction = CameraLensDirection.back;
//     }

//     await _camera.stopImageStream();
//     await _camera.dispose();

//     setState(() {
//       _camera = null;
//     });

//     _initializeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ML Vision Example'),
//         actions: <Widget>[
//           PopupMenuButton<Detector>(
//             onSelected: (Detector result) {
//               _currentDetector = result;
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>>[
//                   const PopupMenuItem<Detector>(
//                     child: Text('Detect Barcode'),
//                     value: Detector.barcode,
//                   ),
//                   const PopupMenuItem<Detector>(
//                     child: Text('Detect Face'),
//                     value: Detector.face,
//                   ),
//                   // const PopupMenuItem<Detector>(
//                   //   child: Text('Detect Label'),
//                   //   value: Detector.label,
//                   // ),
//                   // const PopupMenuItem<Detector>(
//                   //   child: Text('Detect Cloud Label'),
//                   //   value: Detector.cloudLabel,
//                   // ),
//                   const PopupMenuItem<Detector>(
//                     child: Text('Detect Text'),
//                     value: Detector.text,
//                   ),
//                 ],
//           ),
//         ],
//       ),
//       body: _buildImage(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _toggleCameraDirection,
//         child: _direction == CameraLensDirection.back
//             ? const Icon(Icons.camera_front)
//             : const Icon(Icons.camera_rear),
//       ),
//     );
//   }
// }
