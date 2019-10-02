import 'dart:async';
import 'dart:convert';

import 'package:douyin_demo/models/PostsModel.dart';
import 'package:douyin_demo/widgets/WebRequest.dart';
import 'package:flutter/material.dart';
// import 'package:my_app/models/PostsModel.dart';
// import 'package:my_app/tools/WebRequest.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';


class PostsGalleryProvider with ChangeNotifier {
  List<PostsModel> model1 = List<PostsModel>();
  List<PostsModel> model2 = List<PostsModel>();
  double _len1 = 0;
  double _len2 = 0;
  // get  models1 => _model1;
  // get models2 => _model2;
  List<PostsModel> posts = List<PostsModel>();

  PostsGalleryProvider() {
    getPosts(0, 0);
    notifyListeners();
  }

  Future getPosts(orderType, ifRefresh) async {
    Uri url = await WebRequest().generate('posts/getPosts', {
      "openId": "ol_BV4zcyVJaOBtOTD5AfpkFERww",
      "dataFrom": "0",
      "count": "30",
      "refreshTime": DateTime.now().toString(),
      "currentSel": "1",
      "ulo": "0",
      "ula": "0"
    });

    var response = await http.get(url);
    //.then((response) {
    // var post = json.decode(response.body)["result"];
    setGalleryModel(response.body);
    notifyListeners();
  }

  setGalleryModel(String items) {
    var result = List<PostsModel>();

    var posts = json.decode(items)["result"];
    // result.add(posts);

    for (var item in posts) {
      result.add(PostsModel.fromJson(item));
    }
    for (var item in result) {
      if (_len1 <= _len2) {
        item.makerName="";
        item.picsPath="";
        item.postsLocation="";
        item.postsReaded=0;
        model1.add(item);
        _len1 += item.picsRate;
      } else {
        model2.add(item);
        _len2 += item.picsRate;
      }
    }
    // notifyListeners();
  }
}
