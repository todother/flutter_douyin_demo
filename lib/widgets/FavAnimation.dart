// import 'package:flutter/material.dart';

// class AnimateFav extends StatefulWidget {
//   AnimateFav({Key key, this.size}) : super(key: key);
//   final double size;

//   _AnimateFavState createState() => _AnimateFavState();
// }

// class _AnimateFavState extends State<AnimateFav>
//     with TickerProviderStateMixin {
//   AnimationController _controller_1;
//   AnimationController _controller_2;
//   Animation<double> _animation_1;
//   Animation<double> _animation_2;
//   Animation<double> curAnimation;
//   double rpx;
//   @override
//   void initState() {
//     super.initState();

//     _controller_1 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _controller_2 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 200));
//     _animation_1 = Tween(begin: 0.0, end: 1.3).animate(_controller_1)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller_2.forward(from: 0);
//           setState(() {
//             curAnimation = _animation_2;
//           });
//         }
//       })
//       ..addListener(() {
//         setState(() {});
//       });
//     _animation_2 = Tween(begin: 1.3, end: 1.0).animate(_controller_2)
//       ..addListener(() {
//         setState(() {});
//       });
//     curAnimation = _animation_1;
//     _controller_1.forward(from: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     rpx = MediaQuery.of(context).size.width / 750;
//     return Center(
//         child: Icon(
//       Icons.favorite,
//       size: widget.size * curAnimation.value,
//       color: Colors.redAccent,
//     ));
//   }
// }

// class AnimatedUnFav extends StatefulWidget {
//   AnimatedUnFav({Key key,@required this.size}) : super(key: key);
//   final double size;
//   _AnimatedUnFavState createState() => _AnimatedUnFavState();
// }

// class _AnimatedUnFavState extends State<AnimatedUnFav> with TickerProviderStateMixin {
//   AnimationController _controller_1;
//   AnimationController _controller_2;
//   Animation<double> _animation_1;
//   Animation<double> _animation_2;
//   Animation<double> curAnimation;
//   Color curColor;
//   @override
//   void initState() {
//     super.initState();
//     curColor=Colors.redAccent;
//     _controller_1 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 100));
//     _controller_2 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 100));
//     _animation_1 = Tween(begin: 1.0, end: 1.2).animate(_controller_1)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller_2.forward(from: 0);
//           setState(() {
//             curAnimation = _animation_2;
//             curColor=Colors.grey[100];
//           });
//         }
//       })
//       ..addListener(() {
//         setState(() {});
//       });
//     _animation_2 = Tween(begin: 1.2, end: 1.0).animate(_controller_2)
//       ..addListener(() {
//         setState(() {});
//       });
//     curAnimation = _animation_1;
//     _controller_1.forward(from: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // rpx = MediaQuery.of(context).size.width / 750;
//     return Center(
//         child: Icon(
//       Icons.favorite,
//       size: widget.size * curAnimation.value,
//       color: curColor,
//     ));
//   }
// }

import 'dart:async';

import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AnimatePositiveIcon extends StatefulWidget {
//   AnimatePositiveIcon({Key key, @required this.size, this.callback})
//       : super(key: key);
//   final double size;
//   final VoidCallback callback;
//   _AnimatePositiveIconState createState() => _AnimatePositiveIconState();
// }

// class _AnimatePositiveIconState extends State<AnimatePositiveIcon>
//     with TickerProviderStateMixin {
//   AnimationController _controller1;
//   AnimationController _controller2;
//   AnimationController _controller3;

//   Animation<double> _animation1;
//   Animation<double> _animation2;
//   Animation<double> _animation3;

//   Animation<double> curAnimation;

//   Color curColor;

//   @override
//   void initState() {
//     super.initState();
//     _controller1 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 150));
//     _controller2 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 200));
//     _controller3 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 60));

//     curColor = Colors.grey[100];
//     _animation1 = Tween(begin: 1.0, end: 0.0).animate(_controller1)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller2.forward(from: 0);
//           curAnimation = _animation2;
//           curColor = Colors.redAccent;
//         }
//       });

//     _animation2 = Tween(begin: 0.0, end: 1.2).animate(_controller2)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller3.forward(from: 0);
//           curAnimation = _animation3;
//         }
//       });

//     _animation3 = Tween(begin: 1.2, end: 1.0).animate(_controller3)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed && widget.callback != null) {
//           widget.callback();
//         }
//       });
//     // _controller1.forward(from: 0).then((_) {
//     //   _controller2.forward(from: 0).then((_){
//     //     _controller3.forward(from: 0);
//     //   });
//     // });
//     curAnimation = _animation1;
//     _controller1.forward(from: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Icon(
//         Icons.favorite,
//         size: widget.size * curAnimation.value,
//         color: curColor,
//       ),
//     );
//   }
// }

// class AnimateNegtiveIcon extends StatefulWidget {
//   AnimateNegtiveIcon(
//       {Key key,
//       @required this.size,
//       @required this.icon,
//       @required this.startColor,
//       @required this.endColor,
//       this.callback})
//       : super(key: key);
//   final double size;
//   final IconData icon;
//   final VoidCallback callback;
//   final Color startColor;
//   final Color endColor;
//   _AnimateNegtiveIconState createState() => _AnimateNegtiveIconState();
// }

// class _AnimateNegtiveIconState extends State<AnimateNegtiveIcon>
//     with TickerProviderStateMixin {
//   AnimationController _controller1;
//   AnimationController _controller2;

//   Animation<double> _animation1;
//   Animation<double> _animation2;

//   Animation<double> curAnimation;

//   Color curColor;

//   @override
//   void initState() {
//     super.initState();
//     _controller1 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 200));
//     _controller2 =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 200));

//     curColor = widget.startColor;
//     _animation1 = Tween(begin: 1.0, end: 1.2).animate(_controller1)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller2.forward(from: 0);
//           curAnimation = _animation2;
//           curColor = widget.endColor;
//         }
//       });

//     _animation2 = Tween(begin: 1.2, end: 1.0).animate(_controller2)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed && widget.callback != null) {
//           Timer(Duration(milliseconds: 100), () {
//             widget.callback();
//           });
//         }
//       });
//     // _controller1.forward(from: 0).then((_) {
//     //   _controller2.forward(from: 0).then((_){
//     //     _controller3.forward(from: 0);
//     //   });
//     // });
//     curAnimation = _animation1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         padding: EdgeInsets.all(0),
//         onPressed: () {
//           _controller1.forward(from: 0);
//         },
//         icon: Icon(
//           widget.icon,
//           semanticLabel: "label",
//           size: widget.size * curAnimation.value,
//           color: curColor,
//         ));
//   }
// }

class AnimatedIconWidget extends StatefulWidget {
  AnimatedIconWidget(
      {Key key,
      @required this.animationList,
      @required this.icon,
      @required this.size,
      this.callback,
      this.callbackDelay,
      this.provider})
      : super(key: key);
  final List<IconAnimationStage> animationList;
  final IconData icon;
  final VoidCallback callback;
  final double size;
  final RecommendProvider provider;
  final Duration callbackDelay;
  _AnimatedIconWidgetState createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with TickerProviderStateMixin {
  List<IconAnimationStage> anis = List<IconAnimationStage>();
  List<AnimationController> controllers = List<AnimationController>();
  List<Animation<double>> animations = List<Animation<double>>();
  Animation<double> curAnim;
  Color curColor;
  int curIndex = 0;
  List<bool> ifAdded = List<bool>();
  double curSize;
  bool ifInit = true;

  loopAnimation(index) {
    curColor = curColor == null ? anis.first.color : curColor;
    if (index < controllers.length - 1) {
      if (!ifAdded[index]) {
        animations[index] = animations[index]
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              curAnim = animations[index + 1];
              curColor = anis[index + 1].color;

              controllers[index + 1].forward(from: 0);
              loopAnimation(index + 1);
            }
          })
          ..addListener(() {
            setState(() {});
          });
        ifAdded[index] = true;
      }
    } else if (index == controllers.length - 1) {
      if (!ifAdded[index]) {
        animations[index] = animations[index]
          ..addStatusListener((status) {
            curColor = anis[index].color;
            if (status == AnimationStatus.completed) {
              if (widget.callback != null) {
                if (widget.callbackDelay == null) {
                  widget.callback();
                } else {
                  Timer(widget.callbackDelay, () {
                    widget.callback();
                  });
                }
              }
            }
          })
          ..addListener(() {
            setState(() {});
          });
        ifAdded[index] = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    anis = widget.animationList;

    List.generate(anis.length, (index) {
      var curAni = anis[index];
      ifAdded.add(false);
      controllers.add(
          AnimationController(vsync: this, duration: anis[index].duration));
      animations.add(Tween(begin: curAni.start, end: curAni.end)
          .animate(controllers[index]));
    });
    curAnim = animations.first;
    loopAnimation(0);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        controllers.first.forward(from: 0);
      },
      icon: Icon(
        widget.icon,
        size: widget.size * curAnim.value,
        color: curColor,
      ),
    );
  }
}

class IconAnimationStage {
  double start;
  double end;
  Color color;
  Duration duration;

  IconAnimationStage({this.color, this.duration, this.end, this.start});
}
