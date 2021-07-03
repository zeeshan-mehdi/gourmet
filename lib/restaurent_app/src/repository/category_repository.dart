import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:markets/restaurent_app/src/helpers/custom_trace.dart';
import 'package:markets/restaurent_app/src/models/user.dart';

import '../helpers/helper.dart';
import '../models/category.dart';
import '../repository/user_repository.dart' as userRepo;

Future<Stream<Category>> getCategories() async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}manager/categories';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Category.fromJSON(data));
}

Future<Stream<Category>> getCategory(String id) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}manager/categories/$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) => Category.fromJSON(data));
}

Future<List<Category>> getAllCategories() async {
  List<Category> markets = [];
  String url = '${GlobalConfiguration().getValue('api_base_url')}manager/categories';
  url = url.replaceFirst("manager/", "");
  Uri uri = Uri.parse(url);
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return [];
  }
  _queryParams['api_token'] = _user.apiToken;
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final response = await client.get( uri);

    var resp = jsonDecode(response.body);

    if(resp['success']) {
      resp = resp['data'];
      resp.forEach((val) {
        markets.add(Category.fromJSON(val));
      });

      return markets;
    }else{
      return [];
    }
    // return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    //   return Market.fromJSON(data);
    // });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return [];
  }
}
