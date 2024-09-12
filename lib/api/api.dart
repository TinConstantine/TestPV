import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:map_app/model/auto_suggest_address.dart';
class MapAppApi {
  static const autoSuggest =
      "https://autosuggest.search.hereapi.com/v1/autosuggest";
  static const apiKey = "KyJN6N36cdVsPWMg8Jy1k9mxgbdRZR1QUkPJWwM40eI";

  Future<AutoSuggestAddress> getAutoSuggestAddress(
      {required String lat,
        required String lon,
        required String q,
        int limit = 10}) async {
    var res = await http.get(
      Uri.parse(autoSuggest).replace(
        queryParameters: {
          'apiKey': apiKey,
          'at': "$lat,$lon",
          'q': q,
          'limit': limit.toString()
        },
      ),
    );
    if(res.statusCode == 200){
      var utf8Body = convert.utf8.decode(res.bodyBytes);
      var json = convert.jsonDecode(utf8Body) as Map<String, dynamic>;
      return AutoSuggestAddress.fromJson(json);
    }
    return AutoSuggestAddress();
  }

}
