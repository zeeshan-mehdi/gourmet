

import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:markets/restaurent_app/src/helpers/helper.dart';
import 'package:markets/src/models/user.dart';

import 'package:markets/src/repository/user_repository.dart' as userRepo;





  getMarketUsers()async{
   // String url ='${GlobalConfiguration().getValue('api_base_url')}user/by-market-id/{id}';

    List<User> users = [];

    String url ='${GlobalConfiguration().getValue('api_base_url')}user/markets/${userRepo.currentUser.value.id}?api_token=${userRepo.currentUser.value.apiToken}';


    try {
      final client = new http.Client();
      final response = await client.get(Uri.parse(url));

      var data = Helper.getData(jsonDecode(response.body));

      print('first call response $data');

      for(int i =0;i<data.length;i++){
        var item = data[i]['market_id'];

        var array = await getUserByMarketId(item);

        users.addAll(array);
      }

      return users;

      // return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
      //   return Review.fromJSON(data);
      // });
    } catch (e) {
      print('exception');
      print(e);
      return  [];
      // print(CustomTrace(StackTrace.current, message: url).toString());
      // return new Stream.value(new Review.fromJSON({}));
    }
  }

  getUserByMarketId(marketId)async{
    List<User> users = [];
    String url ='${GlobalConfiguration().getValue('api_base_url')}user/by-market-id/$marketId?api_token=${userRepo.currentUser.value.apiToken}';

    final client = new http.Client();
    final response = await client.get(Uri.parse(url));

    var data = Helper.getData(jsonDecode(response.body));


    for(int i =0;i<data.length;i++){
      var userId = data[i]['user_id'];

      print('user id $userId');
      var u = await getUser(userId);
      print('user received $u');

      try {
        var user = User.fromJSON(u[0]);
        print('converting from json ');

        users.add(user);
        print('user added');
      }catch(e){
        print('problem is here');
        print(e);
      }

    }

    print('users ${users}');

    return users;

  }

  getUser(id)async{
    String url ='${GlobalConfiguration().getValue('api_base_url')}users/$id?api_token=${userRepo.currentUser.value.apiToken}';

    final client = new http.Client();
    final response = await client.get(Uri.parse(url));

    var data = Helper.getData(jsonDecode(response.body));

    return data;

  }

