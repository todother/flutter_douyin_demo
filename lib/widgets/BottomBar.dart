import 'package:douyin_demo/main.dart';
import 'package:douyin_demo/pages/sameCity/SameCityPage.dart';
import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:flutter/material.dart';

// class BtmBar extends StatelessWidget {
//   const BtmBar({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // RecommendProvider provider = Provider.of<RecommendProvider>(context);
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           getBtmTextWidget("首页", true),
//           getBtmTextWidget("同城", false),
//           AddIcon(),
//           getBtmTextWidget("消息", false),
//           getBtmTextWidget("我", false),
//         ],
//       ),
//     );
//   }
// }

class BtmBar extends StatefulWidget {
  BtmBar({Key key, this.selectIndex}) : super(key: key);
  final int selectIndex;

  _BtmBarState createState() => _BtmBarState();
}

class _BtmBarState extends State<BtmBar> {
  List<bool> selected = List<bool>();
  List<String> selectItems = List<String>();
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 4; i++) {
      selected.add(false);
    }
    selected[widget.selectIndex] = true;
  }
  
  @override
  void dispose() {
  // _controller.dispose();
  super.dispose();
}

  tapItem(index) {
    // selected=List<bool>();
    // for (var i = 0; i < 4; i++) {
    //   selected.add(false);
    // }
    // selected[index]=true;
    // setState(() {

    //   selected=selected;
    // });
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => RecommendPage(
                      selIndex: index,
                    )),
            ModalRoute.withName("/Home"));
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SameCityMain(
                      selIndex: index,
                    )),
            ModalRoute.withName("/sameCity"));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // RecommendProvider provider = Provider.of<RecommendProvider>(context);
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: getBtmTextWidget("首页", selected[0], () {
                tapItem(0);
              }, rpx)),
          Expanded(
              flex: 1,
              child: getBtmTextWidget("同城", selected[1], () {
                tapItem(1);
              }, rpx)),
          Expanded(flex: 1, child: AddIcon()),
          Expanded(
              flex: 1,
              child: getBtmTextWidget("消息", selected[2], () {
                tapItem(2);
              }, rpx)),
          Expanded(
              flex: 1,
              child: getBtmTextWidget("我", selected[3], () {
                tapItem(3);
              }, rpx)),
        ],
      ),
    );
  }
}

getBtmTextWidget(String content, bool ifSelected, tapFunc, double rpx) {
  return FlatButton(
      onPressed: () {
        tapFunc();
      },
      child: Text("$content",
          style: ifSelected
              ? TextStyle(
                  fontSize: 30 * rpx,
                  color: Colors.white,
                  fontWeight: FontWeight.w900)
              : TextStyle(
                  fontSize: 30 * rpx,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w900)));
}

class AddIcon extends StatelessWidget {
  const AddIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double iconHeight = 55 * rpx;
    double totalWidth = 90 * rpx;
    double eachSide = 5 * rpx;
    return Container(
      // decoration: BoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 30 * rpx),
      height: iconHeight,
      width: 150 * rpx,
      child: Stack(
        children: <Widget>[
          Positioned(
            height: iconHeight,
            width: totalWidth - eachSide,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: iconHeight,
            width: totalWidth - eachSide,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            height: iconHeight,
            width: totalWidth - eachSide * 2,
            right: eachSide,
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
