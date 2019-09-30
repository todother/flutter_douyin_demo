import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:collection/collection.dart';

class AtUserProvider with ChangeNotifier {
  int curTop = 0;
  // double appHeight=80;

  double appBtmHeight=40;
  bool ifStick=true;

  AppBar appBar = AppBar();
  double appHeight;

  List<Key> keys=List<Key>();
  ScrollController controller=ScrollController();
  
  List<Contact> contacts = List<Contact>();
  List<Map<String, dynamic>> dataMap=List<Map<String, dynamic>>();
  Map<dynamic,List<dynamic>> result;
  List<String> groupList=List<String>();
  AtUserProvider() {
     appHeight= appBar.preferredSize.height;
    // data.sort((a,b)=>a["name"].toString().compareTo(b["name"].toString()));
    for (var item in data) {
      contacts.add(Contact(
          avatarUrl: item["avatar_url"].toString(),
          userName: item["name"].toString(),
          desc: item["headline"].toString()));
      String startText = item["name"].toString();
      if (startText == "") {
        startText = " ";
      } else {
        startText = startText[0];
      }
      if (RegExp("^[\u4e00-\u9fa5]").firstMatch(startText) != null) {
        contacts.last.groupCode = PinyinHelper.getShortPinyin(startText)[0].toLowerCase();
      } else if (RegExp("^[a-zA-Z]").firstMatch(startText) != null) {
        contacts.last.groupCode = startText.toLowerCase();
      } else {
        contacts.last.groupCode = "#";
      }
      groupList.add(contacts.last.groupCode);
      dataMap.add(Contact.toMap(contacts.last));
    } 
    groupList=groupList.toSet().toList();
    groupList.sort((a,b)=>a.toString().compareTo(b.toString()));
    dataMap.sort((a,b)=>a["groupCode"].toString().compareTo(b["groupCode"].toString()));
    result= groupBy(dataMap,(o)=>o["groupCode"]);
    // print(result);
    print('done');
  }


  // setAppHeight(height){
  //   appHeight=height;
  //   // notifyListeners();
  // }

  setIfStick(stick){
    ifStick=stick;
    notifyListeners();
  }
}

class ContactResult{
  String key;
  List<dynamic> value;
}


class Contact {
  String avatarUrl;
  String userName;
  String desc;
  String groupCode;
  static Map<String, dynamic> toMap(Contact item) {
    return {
      "avatarUrl": item.avatarUrl,
      "userName": item.userName,
      "desc": item.desc,
      "groupCode": item.groupCode
    };
  }

  Contact({this.avatarUrl, this.desc, this.userName});
}

List data = [
  {
    "id": "2149cbd6f1fbd070ff9045e648764ab6",
    "url_token": "ji-yi-85-34",
    "name": "记忆",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic1.zhimg.com/v2-0aa271fdadb3130a549af500c4d4569a_is.jpg",
    "avatar_url_template":
        "https://pic1.zhimg.com/v2-0aa271fdadb3130a549af500c4d4569a_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/ji-yi-85-34",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "04d44e85c074c4b22775375886576303",
    "url_token": "leyls-50",
    "name": "Leyls",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-d2f3715564b0b40a8dafbfdec3803f97_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-d2f3715564b0b40a8dafbfdec3803f97_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/leyls-50",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "8fbf538ae273714fc51df3e845edb22b",
    "url_token": "yong-hu-6198445175",
    "name": "用户6198445175",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/yong-hu-6198445175",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "a91ae701e3a5907caa2e9b391aa2ffed",
    "url_token": "maybe-15-63",
    "name": "Maybe",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-0edac6fcc7bf69f6da105fe63268b84c_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-0edac6fcc7bf69f6da105fe63268b84c_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/maybe-15-63",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "ea9806c42cc0b02f5f2bd059777724fd",
    "url_token": "du-ji-57-59-74",
    "name": "嘟唧",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-bd46162e4c96d4046ec27a7cf48536cb_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-bd46162e4c96d4046ec27a7cf48536cb_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/du-ji-57-59-74",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "62f34d1e4fb40d0d5b908aa35bb95459",
    "url_token": "she-yu-79-9",
    "name": "舍予",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic1.zhimg.com/v2-f8c95bf6807a3773eb5679aae2892960_is.jpg",
    "avatar_url_template":
        "https://pic1.zhimg.com/v2-f8c95bf6807a3773eb5679aae2892960_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/she-yu-79-9",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "294db0cf83ea2625c09e098a3bcb0d5f",
    "url_token": "govern-89-70",
    "name": "govern",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-5f8e42cfb17988e013b9bf76153da7be_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-5f8e42cfb17988e013b9bf76153da7be_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/govern-89-70",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "7d54c9819b6cec2a47518e37be7e0dfa",
    "url_token": "melody-48-78",
    "name": "melody",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-8824912d536a4c3185ed0a33453b87c0_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-8824912d536a4c3185ed0a33453b87c0_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/melody-48-78",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "017090d3fbbcba60b16f2e28ff6a78c2",
    "url_token": "na-4jia-ha-will",
    "name": "那4家哈will",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/na-4jia-ha-will",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "8e88f077f33d1c9a368a2829293214c8",
    "url_token": "susu-35-99",
    "name": "susu",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic1.zhimg.com/v2-0246f15a0edea34ad0fa426cef107cca_is.jpg",
    "avatar_url_template":
        "https://pic1.zhimg.com/v2-0246f15a0edea34ad0fa426cef107cca_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/susu-35-99",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "bcb3809c512bc3f5ce266790a2d69eb9",
    "url_token": "an-an-zai-zhe-li",
    "name": "安安在这里",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/v2-e76b43292c40d3888d55644c75cb1a9d_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/v2-e76b43292c40d3888d55644c75cb1a9d_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/an-an-zai-zhe-li",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "2780e8e9169704de47fdaca88747cfbe",
    "url_token": "xuan-yun-51-6",
    "name": "轩云",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-d2070c612f4a50a2e080361bba9d228a_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-d2070c612f4a50a2e080361bba9d228a_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/xuan-yun-51-6",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "13b23e127a897838fa372bcb33a83fa1",
    "url_token": "wei-feng-qing-yu-99",
    "name": "微风清雨",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-f60459b992aa3df8ecf313db0451c48c_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-f60459b992aa3df8ecf313db0451c48c_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/wei-feng-qing-yu-99",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "0f8bc9f18b249c7d214582dc40a81800",
    "url_token": "present-2-45",
    "name": "PRESENT",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-ab4e823f1d9610dc2eff629948cdfea6_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-ab4e823f1d9610dc2eff629948cdfea6_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/present-2-45",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 1,
    "articles_count": 0
  },
  {
    "id": "dff166d133b4a3ce4967871873b95403",
    "url_token": "yu-xi-4-89",
    "name": "玉璽",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/yu-xi-4-89",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "6775f0f8abefef670cd748fd4bdc98fb",
    "url_token": "a-bai-7-98",
    "name": "阿白",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic1.zhimg.com/v2-b8977fa6273c7030bc1e3543feb8a357_is.jpg",
    "avatar_url_template":
        "https://pic1.zhimg.com/v2-b8977fa6273c7030bc1e3543feb8a357_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/a-bai-7-98",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 1,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "a3e583a3cf456e911e7744b4bc5ffe1e",
    "url_token": "wan-ju-gong-han",
    "name": "玩具工厂",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic1.zhimg.com/v2-e68a91273a85aad4d8710cfc31e4d3fa_is.jpg",
    "avatar_url_template":
        "https://pic1.zhimg.com/v2-e68a91273a85aad4d8710cfc31e4d3fa_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/wan-ju-gong-han",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 1
  },
  {
    "id": "df8c74471ab4a3bccabee02404850b1f",
    "url_token": "a-jun-82-48-57",
    "name": "阿军",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-5a90429e867a3fe4357524434580c635_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-5a90429e867a3fe4357524434580c635_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/a-jun-82-48-57",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "b8bfdb6901403ff5d7ab490c6ccddff0",
    "url_token": "a-qiang-15-57-64",
    "name": "阿强",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-774b0897493093bd0814aec5e4360657_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-774b0897493093bd0814aec5e4360657_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/a-qiang-15-57-64",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "607413c4a2a6d90262b9f804a8385d43",
    "url_token": "qing-yu-42-55-23",
    "name": "轻语",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/v2-74c5a0171ae78c83b7af639ca3947279_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/v2-74c5a0171ae78c83b7af639ca3947279_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/qing-yu-42-55-23",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "00950a23d0691ddfd0522bde60fac94a",
    "url_token": "bai-ying-64-30",
    "name": "白影",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/v2-c2a2e8a65a8817edc0256c4b8ede334c_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/v2-c2a2e8a65a8817edc0256c4b8ede334c_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/bai-ying-64-30",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "c4bf223e7c7826c717ec5c0c2d4aabfc",
    "url_token": "shuang-yue-68-9",
    "name": "霜月",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-88be115180f0bd5612b2515e7868fc36_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-88be115180f0bd5612b2515e7868fc36_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/shuang-yue-68-9",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "f476195faf1a5fdf02f59a5c27da15a1",
    "url_token": "alisa-9-77-97",
    "name": "Alisa",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/alisa-9-77-97",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 1,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "34bd49496536946170d4eae49f86f01f",
    "url_token": "irishxy",
    "name": "Irishxy",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/v2-349882fdd51865217e50ec786d542257_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/v2-349882fdd51865217e50ec786d542257_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/irishxy",
    "user_type": "people",
    "headline": "典型的巨蟹女",
    "gender": 0,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 1,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "517ce235adf85e15d7ed73c3acde0dbb",
    "url_token": "xiao-an-ai-huo-guo",
    "name": "小安爱火锅",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-a66bf8e0583d29fff640d9cc0f9e7ade_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-a66bf8e0583d29fff640d9cc0f9e7ade_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/xiao-an-ai-huo-guo",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "a3c97c84d22422ffc8b88b2c15a06d0d",
    "url_token": "hong-yi-xie",
    "name": "弘毅",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/68ffeee3c2f46f0ff97cfc82ddaced39_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/68ffeee3c2f46f0ff97cfc82ddaced39_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/hong-yi-xie",
    "user_type": "people",
    "headline": "铜钱",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 10,
    "answer_count": 10,
    "articles_count": 0
  },
  {
    "id": "17617844a030a1bb13563fcba08ac0bc",
    "url_token": "gst-62",
    "name": "GST",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/78cd328bd22026ad7e5c95b34a484ef8_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/78cd328bd22026ad7e5c95b34a484ef8_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/gst-62",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 10,
    "answer_count": 32,
    "articles_count": 0
  },
  {
    "id": "28085a8fd28550cf00f47f7115ac035e",
    "url_token": "lanlan-15-96",
    "name": "Lanlan",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/v2-743e61568785289cf402f3565334c58b_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/v2-743e61568785289cf402f3565334c58b_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/lanlan-15-96",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "201a7add349e2b16d68deb13bed81a30",
    "url_token": "ran-shao-de-tu-shu-guan",
    "name": "燃烧的图书馆",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/f45ffc0805e61bf4295c8422f4cdd169_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/f45ffc0805e61bf4295c8422f4cdd169_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/ran-shao-de-tu-shu-guan",
    "user_type": "people",
    "headline": "自动化",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "80aad13efe63c02263387fb9bc52729f",
    "url_token": "qi-miao-zhong-de-ji-yi-80-1",
    "name": "七秒钟的记忆",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-f33d1a1fee3bd54c0d44fc0aa8522cd2_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-f33d1a1fee3bd54c0d44fc0aa8522cd2_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/qi-miao-zhong-de-ji-yi-80-1",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "064db3bd2bb39e8c8b707f729ae7756d",
    "url_token": "jia-kai-6-30",
    "name": "加凯",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic1.zhimg.com/v2-a9bcb9a806731b87414d1aea4669b099_is.jpg",
    "avatar_url_template":
        "https://pic1.zhimg.com/v2-a9bcb9a806731b87414d1aea4669b099_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/jia-kai-6-30",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 1,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "92c3e7514fb0a5a71c4d23432fe321af",
    "url_token": "ihowe",
    "name": "haroel",
    "use_default_avatar": false,
    "avatar_url": "https://pic2.zhimg.com/87cdbc0fb_is.jpg",
    "avatar_url_template": "https://pic2.zhimg.com/87cdbc0fb_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/ihowe",
    "user_type": "people",
    "headline": "Yo~~ listen up here\u0026#39;s a story",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 191,
    "answer_count": 359,
    "articles_count": 0
  },
  {
    "id": "fc1fa66ab4b9b660806d50dcfd7012aa",
    "url_token": "ling-dong-you-feng",
    "name": "灵动游峰",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-6d1f871ecf2ebbaef30ef4ab7b96a3d0_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-6d1f871ecf2ebbaef30ef4ab7b96a3d0_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/ling-dong-you-feng",
    "user_type": "people",
    "headline": "小论文和大论文的区别",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 1,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "4e6d8d84c9d26c1c8ea2f5afe260247d",
    "url_token": "mo-mo-mo-mo-39-75",
    "name": "嘿嘿嘿嘿",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/mo-mo-mo-mo-39-75",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 6,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "1b65a94bdf04f8bedc510a000f67a49d",
    "url_token": "edward-47-15",
    "name": "Edward",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic2.zhimg.com/v2-3b757736ac5b92e8ba0d039569a0b08d_is.jpg",
    "avatar_url_template":
        "https://pic2.zhimg.com/v2-3b757736ac5b92e8ba0d039569a0b08d_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/edward-47-15",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 3,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "dd441c0dc5047cf97645585e5baae599",
    "url_token": "zengchao",
    "name": "曾超",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic3.zhimg.com/v2-550a2af4dc30317194950b6a371192f1_is.jpg",
    "avatar_url_template":
        "https://pic3.zhimg.com/v2-550a2af4dc30317194950b6a371192f1_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/zengchao",
    "user_type": "people",
    "headline": "企业SaaS行业从业者，企客宝+企搜客产品经理",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 72,
    "answer_count": 85,
    "articles_count": 0
  },
  {
    "id": "9ab2f6ae276549d9129b4fa67c25e33a",
    "url_token": "li-oo",
    "name": "李oo",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/li-oo",
    "user_type": "people",
    "headline": "呵呵",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 11,
    "answer_count": 35,
    "articles_count": 0
  },
  {
    "id": "ce928cf7539fc6f8360ff5f5baab64ca",
    "url_token": "xin-di-de-zi-you",
    "name": "心底的自由",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/xin-di-de-zi-you",
    "user_type": "people",
    "headline": "",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  },
  {
    "id": "0e4b7c6a6ae7075d04f46ea3cf8afa22",
    "url_token": "huyuguo",
    "name": "胡玉国",
    "use_default_avatar": false,
    "avatar_url":
        "https://pic4.zhimg.com/v2-28e61ae8e1f56afd3f4f943155cd1af3_is.jpg",
    "avatar_url_template":
        "https://pic4.zhimg.com/v2-28e61ae8e1f56afd3f4f943155cd1af3_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/huyuguo",
    "user_type": "people",
    "headline": "",
    "gender": 1,
    "is_advertiser": false,
    "vip_info": {
      "is_vip": true,
      "rename_days": "60",
      "vip_icon": {
        "url":
            "https://pic3.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a_r.png",
        "night_mode_url":
            "https://pic3.zhimg.com/v2-c9686ff064ea3579730756ac6c289978_r.png"
      }
    },
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 1,
    "articles_count": 1
  },
  {
    "id": "7757793cd034b9ef8f654c8ab0a5117a",
    "url_token": "spring-9-46",
    "name": "spring",
    "use_default_avatar": true,
    "avatar_url": "https://pic4.zhimg.com/da8e974dc_is.jpg",
    "avatar_url_template": "https://pic4.zhimg.com/da8e974dc_{size}.jpg",
    "is_org": false,
    "type": "people",
    "url": "https://www.zhihu.com/people/spring-9-46",
    "user_type": "people",
    "headline": "IT工程师",
    "gender": -1,
    "is_advertiser": false,
    "vip_info": {"is_vip": false, "rename_days": "60"},
    "badge": [],
    "is_following": false,
    "is_followed": true,
    "follower_count": 0,
    "answer_count": 0,
    "articles_count": 0
  }
];
