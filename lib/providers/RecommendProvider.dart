// import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RecommendProvider extends State<StatefulWidget>
    with ChangeNotifier, TickerProviderStateMixin {
  bool ifShowBottom = true;

  double screenHeight;
  List<MainInfo> infos = List<MainInfo>();
  List<MainInfo> followed = List<MainInfo>();
  TabController controller;
  MainInfo mainInfo;

  Reply reply;

  RecommendProvider() {
    controller = TabController(vsync: this, length: 2);
    mainInfo = MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content:
            "奥斯卡答复哈士大夫哈师大发输电和健康阿萨德鸿福路口氨基酸的鸿福路口啊,奥斯卡答复哈士大夫哈师大发输电和健康阿萨德鸿福路口氨基酸的鸿福路口啊",
        favCount: 109,
        replyCount: 212,
        shareCount: 317,
        userName: "马有发",
        videoPath: "lib/images/pingguo.jpeg",
        desc: "马友发做的一个有意思的模拟抖音的小App，用的Flutter哦~",
        ifFaved: false);

    reply = Reply(
        ifFaved: true,
        afterReplies: List<Reply>(),
        replyContent: "真可爱，真好看，真厉害~真可爱，真好看，真厉害~",
        replyMakerAvatar:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        replyMakerName: "ABC",
        whenReplied: "3小时前");

    infos.add(MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content: "弗兰克斯代理费绿色出行女郎自行车卡水电费卡；双列的会计法第十六届法律深刻江东父老；看氨基酸的；联发科",
        favCount: 219,
        replyCount: 329,
        shareCount: 1222,
        userName: "范德彪",
        videoPath: "lib/images/sky.jpg",
        desc: "这个天空的图有点好看",
        ifFaved: true));
    infos.add(MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content: "弗兰克斯代理费绿色出行女郎自行车卡水电费卡；双列的会计法第十六届法律深刻江东父老；看氨基酸的；联发科",
        favCount: 119,
        replyCount: 189,
        shareCount: 262,
        userName: "马大帅",
        videoPath: "lib/images/temple.jpg",
        desc: "我喜欢拜佛",
        ifFaved: true));

    infos.add(MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content: "弗兰克斯代理费绿色出行女郎自行车卡水电费卡；双列的会计法第十六届法律深刻江东父老；看氨基酸的；联发科",
        favCount: 98,
        replyCount: 222,
        shareCount: 1983,
        userName: "ABC",
        videoPath: "lib/images/woman.jpg",
        desc: "黑色女人有黑色的美",
        ifFaved: true));

    followed.add(MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content: "弗兰克斯代理费绿色出行女郎自行车卡水电费卡；双列的会计法第十六届法律深刻江东父老；看氨基酸的；联发科",
        favCount: 219,
        replyCount: 329,
        shareCount: 1222,
        userName: "范德彪",
        videoPath: "lib/images/whitehouse.jpg",
        desc: "这个天空的图有点好看",
        ifFaved: true));
    followed.add(MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content: "弗兰克斯代理费绿色出行女郎自行车卡水电费卡；双列的会计法第十六届法律深刻江东父老；看氨基酸的；联发科",
        favCount: 119,
        replyCount: 189,
        shareCount: 262,
        userName: "马大帅",
        videoPath: "lib/images/waterdrop.jpg",
        desc: "我喜欢拜佛",
        ifFaved: true));

    followed.add(MainInfo(
        avatarUrl:
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg",
        content: "弗兰克斯代理费绿色出行女郎自行车卡水电费卡；双列的会计法第十六届法律深刻江东父老；看氨基酸的；联发科",
        favCount: 98,
        replyCount: 222,
        shareCount: 1983,
        userName: "ABC",
        videoPath: "lib/images/woman2.jpg",
        desc: "黑色女人有黑色的美",
        ifFaved: true));
  }

  setScreenHeight(height) {
    screenHeight = height;
    notifyListeners();
  }

  setTabController(ctrl) {
    controller = ctrl;
    // notifyListeners();
  }

  hideBottomBar() {
    ifShowBottom = false;
    notifyListeners();
  }

  tapFav() {
    mainInfo.ifFaved = !mainInfo.ifFaved;
    if (mainInfo.ifFaved) {
      mainInfo.favCount += 1;
    } else {
      mainInfo.favCount -= 1;
    }
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class MainInfo {
  String avatarUrl;
  String userName;
  String content;
  int favCount;
  int replyCount;
  int shareCount;
  String videoPath;
  String desc;
  bool ifFaved;

  MainInfo(
      {this.avatarUrl,
      this.content,
      this.favCount,
      this.replyCount,
      this.shareCount,
      this.userName,
      this.videoPath,
      this.desc,
      this.ifFaved});
}

class Reply {
  String replyMakerName;
  String replyMakerAvatar;
  String replyContent;
  String whenReplied;
  bool ifFaved;
  List<Reply> afterReplies;

  Reply(
      {this.ifFaved,
      this.afterReplies,
      this.replyContent,
      this.replyMakerAvatar,
      this.replyMakerName,
      this.whenReplied});
}
