import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplyFullList extends StatelessWidget {
  const ReplyFullList({Key key,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    ScrollController controller=ScrollController();
    double rpx = MediaQuery.of(context).size.width / 750;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    List<Reply> replies = List<Reply>();
    replies.add(provider.reply);
    replies.add(provider.reply);
    replies.add(provider.reply);
    replies.add(provider.reply);
    replies.add(provider.reply);
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              // width: 750*rpx,
              height: 80 * rpx,
              child: ListTile(
                leading: Container(
                  width: 80 * rpx,
                ),
                title: Container(child: Center(child: Text("当前有100条回复"))),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                ),
              )),
          genReplyList(replies,controller)
        ],
      ),
    );
  }
}

genReplyList(List<Reply> replies,ScrollController controller) {
  return ListView.builder(
    itemCount: replies.length,
    controller:controller,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return ReplyList(reply: replies[index],controller: controller,);
    },
  );
}

class ReplyList extends StatelessWidget {
  const ReplyList({Key key, this.reply,this.controller}) : super(key: key);
  final Reply reply;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5 * rpx),
                width: 100 * rpx,
                height: 100 * rpx,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("${reply.replyMakerAvatar}"),
                ),
              ),
              Container(
                  width: 550 * rpx,
                  child: ListTile(
                    title: Container(
                        height: 60 * rpx,
                        child: Text("${reply.replyMakerName}")),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            "${reply.replyContent}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ]),
                  )),
              Container(
                width: 100 * rpx,
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 100*rpx),
            child: ListView.builder(
              itemCount: 2,
              controller: controller,
              shrinkWrap: true,
              itemBuilder: (context, int) {
                return SubTitleList(
                  rpx: rpx,
                  afterReply: reply,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SubTitleList extends StatelessWidget {
  const SubTitleList({Key key, this.rpx, this.afterReply}) : super(key: key);
  final double rpx;
  final Reply afterReply;
  @override
  Widget build(BuildContext context) {
    return Container(
      width:550*rpx,
      child: Row(
        children: <Widget>[
          Container(
            width: 70 * rpx,
            child: CircleAvatar(
              backgroundImage: NetworkImage("${afterReply.replyMakerAvatar}"),
            ),
          ),
          Container(
              width: 480 * rpx,
              child: ListTile(
                title: Text(
                  "${afterReply.replyMakerName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("${afterReply.replyContent}",
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              )),
          Container(
            width: 100 * rpx,
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey[300],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
