import 'package:douyin_demo/providers/AtUserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AtFriendPage extends StatelessWidget {
  const AtFriendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    double rpx = MediaQuery.of(context).size.width / 750;
    AtUserProvider provider = Provider.of<AtUserProvider>(context);
    // AtUserProvider provider = Provider.of<AtUserProvider>(context);

    List<String> groupList = provider.groupList;
    return provider != null
        ? Scaffold(
          backgroundColor: Color(0xff121319),
            appBar: AppBar(
                backgroundColor: Color(0xff121319),
                leading: Container(
                    width: 80 * rpx,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                title: Text("@好友"),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(80 * rpx),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20 * rpx),
                    decoration: BoxDecoration(color: Colors.grey[700]),
                    padding: EdgeInsets.symmetric(horizontal: 20 * rpx),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                          ),
                          hintText: "搜索用户备注或名字",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          )),
                    ),
                  ),
                )),
            body: ListView.builder(
                  shrinkWrap: true,
                  controller: controller,
                  itemCount: groupList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StickyHeader(
                      header: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:EdgeInsets.only(left: 20*rpx) ,
                        height: 50,
                        decoration: BoxDecoration(color: Color(0xff121319)),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          groupList[index].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 35*rpx),
                        ),
                      ),
                      content: genContentList(
                          provider.result[provider.groupList[index]],
                          context,
                          controller),
                    );
                  },
                ),
          )
        : Scaffold();
  }
}

genUserList(context, controller) {
  AtUserProvider provider = Provider.of<AtUserProvider>(context);

  List<String> groupList = provider.groupList;
  return ListView.builder(
    shrinkWrap: true,
    controller: controller,
    itemCount: groupList.length,
    itemBuilder: (BuildContext context, int index) {
      return StickyHeader(
        header: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(color: Colors.black),
          child: Text(
            groupList[index].toString(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        content: genContentList(
            provider.result[provider.groupList[index]], context, controller),
      );
    },
  );
}

genContentList(
    List<dynamic> friends, BuildContext context, ScrollController controller) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return ListView.builder(
    shrinkWrap: true,
    controller: controller,
    itemCount: friends.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
          decoration: BoxDecoration(color: Color(0xff121319)),
          height: 130 * rpx,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15 * rpx),
                width: 100 * rpx,
                height: 100 * rpx,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(friends[index]["avatarUrl"]),
                ),
              ),
              Container(
                width: 450 * rpx,
                child: friends[index]["desc"].toString().length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              friends[index]["userName"],
                              style: TextStyle(
                                  fontSize: 32 * rpx, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: Text(
                              friends[index]["desc"],
                              style: TextStyle(color: Colors.grey[500]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: Text(
                          friends[index]["userName"],
                          style: TextStyle(
                              fontSize: 32 * rpx, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
              Container(
                width: 200 * rpx,
                child: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                ),
              )
            ],
          ));
    },
  );
}
