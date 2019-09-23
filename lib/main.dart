import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "某音",
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[500]),
          child: Home(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.black),
            child: BtmBar(),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Positioned(
        top: 0,
        height: 120,
        width: screenWidth,
        child: Container(
          // decoration: BoxDecoration(color: Colors.pinkAccent),
          child: TopTab(),
        ),
      ),
      Positioned(
        bottom: 0,
        width: 0.70 * screenWidth,
        height: 140,
        child: Container(
          // decoration: BoxDecoration(color: Colors.redAccent),
          child: BtnContent(),
        ),
      ),
      Positioned(
        right: 0,
        width: 0.25 * screenWidth,
        height: 0.4 * screenHeight,
        top: 0.32 * screenHeight,
        child: Container(
          // decoration: BoxDecoration(color: Colors.orangeAccent),
          child: getButtonList(),
        ),
      ),
      Positioned(
        bottom: 20,
        right: 0,
        width: 0.25 * screenWidth,
        height: 0.25 * screenWidth,
        child: Container(
          width: 20,
          height: 20,
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
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              width: 240,
              child: TabBar(
                indicatorColor: Colors.white,
                labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
                unselectedLabelStyle:
                    TextStyle(color: Colors.grey[700], fontSize: 20),
                controller: _controller,
                tabs: <Widget>[Text("关注"), Text("推荐")],
              )),
        ),
        Flexible(
          flex: 2,
          child: Row(children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.live_tv,
              size: 30,
              color: Colors.white,
            ),
          ]),
        )
      ],
    );
  }
}

class BtmBar extends StatelessWidget {
  const BtmBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getBtmTextWidget("首页", true),
          getBtmTextWidget("同城", false),
          AddIcon(),
          getBtmTextWidget("消息", false),
          getBtmTextWidget("我", false),
        ],
      ),
    );
  }
}

getBtmTextWidget(String content, bool ifSelected) {
  return Text("$content",
      style: ifSelected
          ? TextStyle(fontSize: 18, color: Colors.white)
          : TextStyle(fontSize: 18, color: Colors.grey[600]));
}

class AddIcon extends StatelessWidget {
  const AddIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(),
      height: 35,
      width: 60,
      child: Stack(
        children: <Widget>[
          Positioned(
            height: 35,
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: 35,
            width: 50,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: 35,
            width: 50,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class BtnContent extends StatelessWidget {
  const BtnContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("@人民日报",style: TextStyle(color: Colors.white),),
            subtitle: Text("奥斯卡答复哈士大夫哈师大发输电和健康阿萨德鸿福路口氨基酸的鸿福路口啊,奥斯卡答复哈士大夫哈师大发输电和健康阿萨德鸿福路口氨基酸的鸿福路口啊",style: TextStyle(color: Colors.white,),maxLines: 3,overflow: TextOverflow.ellipsis,),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 10,),
              Icon(Icons.music_note),
              // Marquee(text: "",),
              // Flexible(
              //   child: Marquee(
              //     text: '人民日报创作的一些比较',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //     scrollAxis: Axis.horizontal,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     blankSpace: 20.0,
              //     velocity: 100.0,
              //     pauseAfterRound: Duration(seconds: 1),
              //     startPadding: 10.0,
              //     accelerationDuration: Duration(seconds: 1),
              //     accelerationCurve: Curves.linear,
              //     decelerationDuration: Duration(milliseconds: 500),
              //     decelerationCurve: Curves.easeOut,
              //   )
              // )
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
        child: CircleAvatar(backgroundImage: NetworkImage("https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D500/sign=dde475320ee9390152028d3e4bec54f9/d009b3de9c82d1586d8294a38f0a19d8bc3e42a4.jpg"),)
      ),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        padding: EdgeInsets.all(15),
      child: animation,
    );
  }
}

getButtonList() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
          width: 60,
          height: 70,
          child: Stack(
            children: <Widget>[
              Container(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg"),
                  )),
              Positioned(
                bottom: 0,
                left: 17.5,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.circular(25)),
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
        text: "999w",
        icon: Icon(Icons.favorite,size: 50,color: Colors.redAccent,),
      ),
      IconText(
        text: "999w",
        icon: Icon(Icons.feedback,size: 50,color: Colors.white,),
      ),
      IconText(
        text: "999w",
        icon: Icon(Icons.reply,size: 50,color: Colors.white,),
      ),
    ],
  );
}

class IconText extends StatelessWidget {
  const IconText({Key key, this.icon, this.text}) : super(key: key);
  final Icon icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          Text(text,style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
