

import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
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

        if(user.id != userRepo.currentUser.value.id) {
          users.add(user);
        }
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

  getUserByEmail(String email)async{

    String url ='${GlobalConfiguration().getValue('api_base_url')}users/by-email/$email?api_token=${userRepo.currentUser.value.apiToken}';

    final client = new http.Client();
    final response = await client.get(Uri.parse(url));

    var data = Helper.getData(jsonDecode(response.body));

    print('user found or not $data');
    if(data!=null && data.length>0) {
      return User.fromJSON(data[0]);
    }else{return null;
    }
  }

  deleteStaff(String marketId,userId)async{

    try {
      String endPoint = 'user/markets/delete';
      String url = '${GlobalConfiguration().getValue(
          'api_base_url')}$endPoint?api_token=${userRepo.currentUser.value
          .apiToken}';


      final client = new http.Client();
      Map<String, dynamic> headers = {
        'market_id': marketId,
        'user_id': userId
      };
      final response = await client.post(Uri.parse(url), body: headers);

      print(response.body);

      var data = jsonDecode(response.body);

      print(data);

      if (data['success'])
        return true;
      else {
        Fluttertoast.showToast(msg: '${data['message']}');
        return false;
      }
    }catch(e){
      print('exception $e');
      return false;
    }


  }




  addStaffUser(String marketId,email)async{
    User user = await getUserByEmail(email);

    if(user ==null){
      Fluttertoast.showToast(msg: 'User with this email does not exist');
      return false;
    }

    String endPoint  = 'user/markets';
    String url ='${GlobalConfiguration().getValue('api_base_url')}$endPoint?api_token=${userRepo.currentUser.value.apiToken}';

    if(user!=null){
      final client = new http.Client();
      Map<String,dynamic> headers = {
        'market_id':marketId,
        'user_id':user.id
      };
      final response = await client.post(Uri.parse(url),body: headers);

      print(response.body);

      var data = jsonDecode(response.body);

      print(data);

      if(data['success'])
        return true;
      else {
        Fluttertoast.showToast(msg: '${data['message']}');
        return false;
      }

    }





  }

