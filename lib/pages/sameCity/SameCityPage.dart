import 'package:douyin_demo/widgets/BottomBar.dart';
import 'package:flutter/material.dart';

class SameCityMain extends StatelessWidget {
  const SameCityMain({Key key,this.selIndex}) : super(key: key);
  final int selIndex;
  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width/750;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("同城"),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: BtmBar(selectIndex:selIndex)
        )
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 120*rpx,
            padding: EdgeInsets.all(20*rpx),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.near_me,color: Colors.grey[400],),
                    Text("自动定位 ：上海",style: TextStyle(color: Colors.grey[400]),),
                  ],
                ),
                Row(
                  children: <Widget>[Text("切换",style: TextStyle(color: Colors.grey[400])), Icon(Icons.arrow_right,color: Colors.grey[400])],
                ),
              ],
            )
          ),

        ],
      ),
    );
  }
}
