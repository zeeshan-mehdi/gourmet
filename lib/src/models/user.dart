import '../models/media.dart';

enum UserState { available, away, busy }

class User {
  String id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  bool verifiedPhone;
  String verificationId;
  String address;
  String bio;
  Media image;
  String membershipType;
  // used for indicate if client logged in or not
  bool auth;
  int memebership;
  String trialEnds;
  bool isDriver;




//  String role;

  User({isDriver = false});

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      print('is_driver received');
      print(jsonMap['is_driver']);


      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
      try {
        phone = jsonMap['custom_fields']['phone']['view'];
      } catch (e) {
        phone = "";
      }
      try {
        verifiedPhone = jsonMap['custom_fields']['verifiedPhone']['view'] == '1' ? true : false;
      } catch (e) {
        verifiedPhone = false;
      }
      try {
        address = jsonMap['custom_fields']['address']['view'];
      } catch (e) {
        address = "";
      }
      try {
        isDriver = jsonMap['is_driver'] is String && jsonMap['is_driver']==1?true: jsonMap['is_driver'] is String ? false: jsonMap['is_driver'];
        print('is_driver');
        print(isDriver);
        bio = jsonMap['custom_fields']['bio']['view'];
        memebership = jsonMap['membership'];
        trialEnds = jsonMap['trial_ends_at'];
        membershipType =  jsonMap['membership_type'];

      } catch (e) {
        bio = "";
      }
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["phone"] = phone;
    map["verifiedPhone"] = verifiedPhone;
    map["address"] = address;
    map["bio"] = bio;
    map["membership"]= memebership;
    map['trial_ends_at'] = trialEnds;
    map['membership_type'] = membershipType;
    map['is_driver'] = isDriver;
    map["media"] = image?.toMap();
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = image?.thumb;
    map["is_driver"] = isDriver;
    map["device_token"] = deviceToken;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool profileCompleted() {
    //return address != null && address != '' && phone != null && phone != '' && verifiedPhone != null && verifiedPhone;
    return  phone != null && phone != '';
  }
}
