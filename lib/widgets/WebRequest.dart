import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class WebRequest extends Object {
  //
  bool ifPrd;
  bool ifIos;

  Future<Uri> generate(String path, Map<String, dynamic> params) async {
    final prefs = await SharedPreferences.getInstance();

    String hosts;
    String scheme;
    int ports;

    if (prefs.getBool("ifPrd")) {
      hosts = prefs.getString('urlPath_p');
      scheme = prefs.getString('scheme_p');
      ports = prefs.getInt('ports_p');
    } else {
      if (prefs.getBool("ifIOS")) {
        hosts = prefs.getString('urlPath_ios_d');
        scheme = prefs.getString('scheme_ios_d');
        ports = prefs.getInt('ports_ios_d');
      } else {
        hosts = prefs.getString('urlPath_and_d');
        scheme = prefs.getString('scheme_and_d');
        ports = prefs.getInt('ports_and_d');
      }
    }

    if(prefs.getBool("ifReal_d")){
      hosts = prefs.getString('urlPath_real_d');
        scheme = prefs.getString('scheme_real_d');
        ports = prefs.getInt('ports_real_d');
    }
    Uri url = Uri(
        scheme: scheme,
        host: hosts,
        port: ports,
        path: path,
        queryParameters: params);
    return url;
  }
}
