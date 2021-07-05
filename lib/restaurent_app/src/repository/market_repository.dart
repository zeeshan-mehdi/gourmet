import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' ;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:markets/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/filter.dart';
import '../models/market.dart';
import '../models/review.dart';
import '../../../src/repository/user_repository.dart' as userRepo;

Future<Stream<Market>> getMarkets() async {
  Uri uri = Helper.getUri('api/manager/markets');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(new Market.fromJSON({}));
  }
  _queryParams['api_token'] = _user.apiToken;
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';
  uri = uri.replace(queryParameters: _queryParams);


  print(uri);

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Market.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Market.fromJSON({}));
  }
}

isPaidUser(){
  return userRepo.currentUser.value!=null && (userRepo.currentUser.value.memebership==1||userRepo.currentUser.value.memebership==true);
}


Future<List<Market>> getAllMarkets() async {
  List<Market> markets = [];
  Uri uri = Helper.getUri('api/manager/markets');
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
        markets.add(Market.fromJSON(val));
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



Future<Stream<Market>> getNearMarkets(Address myLocation, Address areaLocation) async {
  Uri uri = Helper.getUri('api/markets');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));

  _queryParams['limit'] = '6';
  if (!myLocation.isUnknown() && !areaLocation.isUnknown()) {
    _queryParams['myLon'] = myLocation.longitude.toString();
    _queryParams['myLat'] = myLocation.latitude.toString();
    _queryParams['areaLon'] = areaLocation.longitude.toString();
    _queryParams['areaLat'] = areaLocation.latitude.toString();
  }
  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Market.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Market.fromJSON({}));
  }
}

Future<Stream<Market>> searchMarkets(String search) async {
  Uri uri = Helper.getUri('api/markets');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = 'name:$search;description:$search';
  _queryParams['searchFields'] = 'name:like;description:like';
  _queryParams['limit'] = '5';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Market.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Market.fromJSON({}));
  }
}

Future<Stream<Market>> getMarket(String id) async {
  Uri uri = Helper.getUri('api/markets/$id');
  Map<String, dynamic> _queryParams = {};
  _queryParams['with'] = 'users';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    print('market');

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).map((data) {
      print(data);
      return  Market.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Market.fromJSON({}));
  }
}

Future<Stream<Review>> getMarketReviews(String id) async {
  Uri uri = Helper.getUri('api/market_reviews');
  Map<String, dynamic> _queryParams = {};
  _queryParams['with'] = 'user';
  _queryParams['search'] = 'market_id:$id';
  _queryParams['limit'] = '5';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Review.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Review.fromJSON({}));
  }
}

Future<Stream<Review>> getRecentReviews() async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}market_reviews?orderBy=updated_at&sortedBy=desc&limit=3&with=user';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      return Review.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Review.fromJSON({}));
  }
}

Future<Review> addMarketReview(Review review, Market market) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}market_reviews';
  final client = new http.Client();
  review.user = userRepo.currentUser.value;
  try {
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.ofMarketToMap(market)),
    );
    if (response.statusCode == 200) {
      return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return Review.fromJSON({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Review.fromJSON({});
  }
}



Future<String> uploadImage(File imageFile)async{
  print('${imageFile.path}');
  var user= await userRepo.getCurrentUser();

 String url = '${GlobalConfiguration().getValue('api_base_url')}';
  url = url.replaceFirst("/manager", '');
  var postUri = Uri.parse("${url}uploads/store?api_token=${user.apiToken}&user_id=${user.id}");
  // var request = new http.MultipartRequest("POST", postUri);
   String uuid = Uuid().generateV4().toString();
  // request.fields['uuid'] = uuid;
  // request.fields['field'] = 'image';
  // request.files.add(new http.MultipartFile.fromBytes('file', await imageFile.readAsBytes(),contentType: 'image/png'));
  //
  //  await request.send().then((response) {
  //   if (response.statusCode == 200) {
  //     print('response ok');
  //       // response.stream.transform(utf8.decoder).listen((value) {
  //       //   print(value);
  //       //
  //       // });
  //   } else
  //     print('something went wrong');
  // });
   var dio = Dio();
  var file = await MultipartFile.fromFile(imageFile.path,
      filename: basename(imageFile.path),
      contentType: MediaType("image", basename(imageFile.path)));

  FormData formData = new FormData.fromMap({
    "field": "image",
    "uuid":uuid,
    "file": file
  });
  var response = await dio.post("${url}uploads/store?api_token=${user.apiToken}&user_id=${user.id}", data: formData);


  print(response);


  return uuid;

}

Future addMarket( Market market) async {
  final String url = '${GlobalConfiguration().getValue('api_base_url')}manager/markets';
  final client = new http.Client();
 // review.user = userRepo.currentUser.value;

  var user = await userRepo.getCurrentUser();
  market.id = user.id;
  print('making request with url $url');
  print(market.toJson(user.apiToken));

  try {
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(market.toJson(user.apiToken)),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('status code not 200');
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return response.body;
     // return Review.fromJSON({});
    }
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: url).toString());
    return e.toString();
    //return Review.fromJSON({});
  }
}


Future getUser(id) async {
  var user = await userRepo.getCurrentUser();
  String baseUrl = GlobalConfiguration().getValue('api_base_url');

  baseUrl = baseUrl.replaceFirst("/manager", "");

  final String url = '${baseUrl}user?user_id=${id}';
  final client = new http.Client();
  // review.user = userRepo.currentUser.value;
  print(url);

  try {
    final response = await client.get(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/url-encoded'}
    );
    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      if(resp['success']){
        print(resp['data']);
        return  resp['data'];
      }
      return null;
    } else {
      print('status code not 200');
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return null;
      // return Review.fromJSON({});
    }
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: url).toString());
    return null;
    //return Review.fromJSON({});
  }
}

Future getAllDrivers() async {
  var user = await userRepo.getCurrentUser();
  String baseUrl = GlobalConfiguration().getValue('api_base_url');

  baseUrl = baseUrl.replaceFirst("/manager", "");

  final String url = '${baseUrl}drivers?api_token=${user.apiToken}';
  final client = new http.Client();
  // review.user = userRepo.currentUser.value;
  print(url);

  try {
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/url-encoded'}
    );
    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      if(resp['success']){
        print(resp['data']);
        List drivers = resp['data'];


        for(int i=0;i<drivers.length;i++){
          var d = drivers[i];

          var user = await getUser(d['user_id']);

          d = {
            'user':user,
            'driver':drivers[i]
          };
          drivers[i] =d;
        }

        print('we have drivers');
        print(drivers);

        return drivers;

      }
      return [];
    } else {
      print('status code not 200');
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return [];
      // return Review.fromJSON({});
    }
  } catch (e) {
    print(e);
    print(CustomTrace(StackTrace.current, message: url).toString());
    return [];
    //return Review.fromJSON({});
  }
}
