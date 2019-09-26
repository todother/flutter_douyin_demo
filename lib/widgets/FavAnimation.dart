import 'package:flutter/material.dart';

class AnimateFav extends StatefulWidget {
  AnimateFav({Key key, this.size}) : super(key: key);
  final double size;

  _AnimateFavState createState() => _AnimateFavState();
}

class _AnimateFavState extends State<AnimateFav>
    with TickerProviderStateMixin {
  AnimationController _controller_1;
  AnimationController _controller_2;
  Animation<double> _animation_1;
  Animation<double> _animation_2;
  Animation<double> curAnimation;
  double rpx;
  @override
  void initState() {
    super.initState();

    _controller_1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _controller_2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation_1 = Tween(begin: 0.0, end: 1.3).animate(_controller_1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller_2.forward(from: 0);
          setState(() {
            curAnimation = _animation_2;
          });
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _animation_2 = Tween(begin: 1.3, end: 1.0).animate(_controller_2)
      ..addListener(() {
        setState(() {});
      });
    curAnimation = _animation_1;
    _controller_1.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    rpx = MediaQuery.of(context).size.width / 750;
    return Center(
        child: Icon(
      Icons.favorite,
      size: widget.size * curAnimation.value,
      color: Colors.redAccent,
    ));
  }
}


class AnimatedUnFav extends StatefulWidget {
  AnimatedUnFav({Key key,@required this.size}) : super(key: key);
  final double size;
  _AnimatedUnFavState createState() => _AnimatedUnFavState();
}

class _AnimatedUnFavState extends State<AnimatedUnFav> with TickerProviderStateMixin {
  AnimationController _controller_1;
  AnimationController _controller_2;
  Animation<double> _animation_1;
  Animation<double> _animation_2;
  Animation<double> curAnimation;
  Color curColor;
  @override
  void initState() {
    super.initState();
    curColor=Colors.redAccent;
    _controller_1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _controller_2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation_1 = Tween(begin: 1.0, end: 1.2).animate(_controller_1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller_2.forward(from: 0);
          setState(() {
            curAnimation = _animation_2;
            curColor=Colors.grey[100];
          });
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _animation_2 = Tween(begin: 1.2, end: 1.0).animate(_controller_2)
      ..addListener(() {
        setState(() {});
      });
    curAnimation = _animation_1;
    _controller_1.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    // rpx = MediaQuery.of(context).size.width / 750;
    return Center(
        child: Icon(
      Icons.favorite,
      size: widget.size * curAnimation.value,
      color: curColor,
    ));
  }
}