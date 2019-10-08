import 'package:flutter/material.dart';

class SelfHomePage extends StatelessWidget {
  const SelfHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width/750;
    return Scaffold(
      body: Container(
        child: HomeMain(rpx: rpx,),
      ),
    );
  }
}

class HomeMain extends StatefulWidget {
  HomeMain({Key key,@required this.rpx}) : super(key: key);
  final double rpx;
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with TickerProviderStateMixin {
  double extraPicHeight = 0;
  BoxFit fitType;
  double prev_dy;
  double rpx;
  AnimationController animationController;
  Animation<double> anim;

  @override
  void initState() {
    super.initState();
    prev_dy = 0;
    fitType = BoxFit.fitWidth;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  updatePicHeight(changed) {
    if (prev_dy == 0) {
      prev_dy = changed;
    }
    extraPicHeight += changed - prev_dy;
    if (extraPicHeight >= 200*widget.rpx) {
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.fitWidth;
    }
    setState(() {
      prev_dy = changed;
      extraPicHeight = extraPicHeight;
      fitType=fitType;
    });
  }

  runAnimate() {
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          if (extraPicHeight >= widget.rpx*200) {
            fitType = BoxFit.fitHeight;
          } else {
            fitType = BoxFit.fitWidth;
          }
          setState(() {
            extraPicHeight = anim.value;
            fitType=fitType;
          });
        });
      prev_dy = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Listener(
        onPointerMove: (result) {
          updatePicHeight(result.position.dy);
        },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0);
        },
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              expandedHeight: 510 * rpx + extraPicHeight,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text("Flutter SliverAppBar"),
                background: SliverTopBar(
                  extraPicHeight: extraPicHeight,
                  fitType: fitType,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  height: 30,
                  color: Colors.blueAccent,
                );
              }, childCount: 80),
            )
          ],
        ));
  }
}

class SliverTopBar extends StatelessWidget {
  const SliverTopBar(
      {Key key, @required this.extraPicHeight, @required this.fitType})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset(
              "lib/images/temple.jpg",
              width: 750 * rpx,
              height: 300 * rpx + extraPicHeight,
              fit: fitType,
            ),
            Container(
              height: 100 * rpx,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * rpx),
              child: Divider(
                color: Colors.grey[700],
              ),
            ),
            Container(
              height: 100 * rpx,
            )
          ],
        ),
        Positioned(
          top: 240 * rpx + extraPicHeight,
          left: 30 * rpx,
          child: Container(
              width: 180 * rpx,
              height: 180 * rpx,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg"))),
        )
      ],
    );
  }
}
