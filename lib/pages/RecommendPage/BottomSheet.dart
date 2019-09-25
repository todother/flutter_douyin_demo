import 'package:douyin_demo/providers/RecommendProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplyFullList extends StatelessWidget {
  const ReplyFullList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    RecommendProvider provider = Provider.of<RecommendProvider>(context);
    Reply reply = provider.reply;
    List<Reply> replies = List<Reply>();

    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    ScrollController controller = ScrollController();
    return SingleChildScrollView(
        controller: controller,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80 * rpx,
                child: ListTile(
                  leading: Container(
                    width: 10 * rpx,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                  title: Center(child: Text("10条评论")),
                ),
              ),
              genReplyList(replies, controller)
            ],
          ),
        ));
  }
}

class ReplyList extends StatelessWidget {
  const ReplyList({Key key, this.reply, this.controller}) : super(key: key);
  final Reply reply;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    List<Reply> replies = List<Reply>();
    replies.add(reply);
    replies.add(reply);
    replies.add(reply);
    // RecommendProvider provider=Provider.of<RecommendProvider>(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100 * rpx,
                height: 100 * rpx,
                padding: EdgeInsets.all(10 * rpx),
                child: CircleAvatar(
                  backgroundImage: NetworkImage("${reply.replyMakerAvatar}"),
                ),
              ),
              Container(
                width: 550 * rpx,
                child: ListTile(
                  title: Text("${reply.replyMakerName}"),
                  subtitle: Text(
                    "${reply.replyContent}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 100 * rpx,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          ),
          genAfterReplyList(replies, controller)
        ],
      ),
    );
  }
}

class AfterReply extends StatelessWidget {
  const AfterReply({Key key, this.afterReply}) : super(key: key);
  final Reply afterReply;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100 * rpx,
              ),
              Container(
                width: 550 * rpx,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 70 * rpx,
                      height: 70 * rpx,
                      margin: EdgeInsets.only(top: 15 * rpx),
                      padding: EdgeInsets.all(10 * rpx),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${afterReply.replyMakerAvatar}"),
                      ),
                    ),
                    Container(
                      width: 480 * rpx,
                      child: ListTile(
                        title: Text("${afterReply.replyMakerName}"),
                        subtitle: RichText(
                          text: TextSpan(
                              text: "${afterReply.replyContent}",
                              style: TextStyle(color: Colors.grey[500]),
                              children: [
                                TextSpan(text: "  ${afterReply.whenReplied}")
                              ]
                              ),
                        ),

                        // Text(
                        //   "${afterReply.replyContent}",
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 100 * rpx,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

genReplyList(List<Reply> replies, ScrollController controller) {
  return ListView.builder(
    shrinkWrap: true,
    controller: controller,
    itemCount: replies.length,
    itemBuilder: (context, index) {
      return ReplyList(
        reply: replies[index],
        controller: controller,
      );
    },
  );
}

genAfterReplyList(List<Reply> replies, ScrollController controller) {
  return ListView.builder(
    shrinkWrap: true,
    controller: controller,
    itemCount: replies.length <= 2 ? replies.length : 2,
    itemBuilder: (context, index) {
      return AfterReply(
        afterReply: replies[index],
      );
    },
  );
}
