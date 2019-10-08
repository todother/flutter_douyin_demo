import 'package:douyin_demo/models/PostsModel.dart';
import 'package:douyin_demo/providers/PostsGalleryProvider.dart';
import 'package:douyin_demo/widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SameCityMain extends StatelessWidget {
  const SameCityMain({Key key, this.selIndex}) : super(key: key);
  final int selIndex;
  @override
  Widget build(BuildContext context) {
    PostsGalleryProvider provider =
        Provider.of<PostsGalleryProvider>(context); //null
    double rpx = MediaQuery.of(context).size.width / 750;
    ScrollController controller = ScrollController();
    return provider == null || provider.model1 == null
        ? Scaffold(
            // body: Loading(),
            )
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              title: Text("同城"),
            ),
            bottomNavigationBar: Container(
                decoration: BoxDecoration(color: Colors.black),
                child: SafeArea(child: BtmBar(selectIndex: selIndex))),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 120 * rpx,
                    padding: EdgeInsets.all(20 * rpx),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.near_me,
                              color: Colors.grey[400],
                            ),
                            Text(
                              "自动定位 ：上海",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("切换",
                                style: TextStyle(color: Colors.grey[400])),
                            Icon(Icons.arrow_right, color: Colors.grey[400])
                          ],
                        ),
                      ],
                    )),
                Expanded(
                    child: SingleChildScrollView(
                        controller: controller,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10 * rpx),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                    flex: 1,
                                    child: WaterFallList(
                                      dataList: provider.model1,
                                      controller: controller,
                                    )),
                                Flexible(
                                  flex: 1,
                                  child: WaterFallList(
                                      dataList: provider.model2,
                                      controller: controller),
                                ),
                              ],
                            ))))
              ],
            ),
          );
  }
}

class WaterFallList extends StatelessWidget {
  const WaterFallList({Key key, this.dataList, this.controller})
      : super(key: key);
  final List<PostsModel> dataList;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    
    double rpx = MediaQuery.of(context).size.width / 750;
    double outPadding=10*rpx;
    double eachSide=2*rpx;
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        PostsModel curPosts = dataList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10*rpx),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: 345 * rpx,
                      padding: EdgeInsets.symmetric(horizontal: eachSide),
                      height: 345 * curPosts.picsRate * rpx,
                      child: Image.network(
                        "https://www.guojio.com/" + curPosts.postsPics,
                        fit: BoxFit.fitWidth,
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        width: 345 * rpx,
                        height: 60 * rpx,
                        padding: EdgeInsets.all(eachSide+10*rpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.near_me,color: Colors.grey[400],size: 32*rpx,),
                                Text("1km",style: TextStyle(color:Colors.grey[400],fontSize: 26*rpx),),
                              ],
                            ),
                            Container(
                                width: 40 * rpx,
                                height: 40 * rpx,
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                  curPosts.makerPhoto,
                                )))
                          ],
                        )),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10*rpx),
                child: Text(
                  curPosts.postsContent,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white,fontSize: 26*rpx),
                )
              )
            ],
          )
        );
      },
    );
  }
}
