import 'package:location/location.dart';

import '../helpers/custom_trace.dart';

class Address {
  String id;
  String description;
  String address;
  double latitude;
  double longitude;
  bool isDefault;
  String userId;

  String street;
  String apartment;
  String block;
  String city;
  String state;
  String country;
  String phoneNumber;
  String zipCode;
  String mapUrl;
  String emirate;
  String area;
  String jada;
  String house;
  String floor;

  String governorate;
  String province;

  String way;

  Address();

  Address.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      description = jsonMap['description'] != null ? jsonMap['description'].toString() : null;
      address = jsonMap['address'] != null ? jsonMap['address'] : null;
      latitude = jsonMap['latitude'] != null ? jsonMap['latitude'] : null;
      longitude = jsonMap['longitude'] != null ? jsonMap['longitude'] : null;
      isDefault = jsonMap['is_default'] ?? false;
      jada = jsonMap['jada'];
      way = jsonMap['way'];
      area = jsonMap['area'];
      governorate = jsonMap['governorate'];
      emirate = jsonMap['emirate'];
      province = jsonMap['province'];
      house = jsonMap['house'];
      floor =jsonMap['floor'];
      city = jsonMap['city'];
      country = jsonMap['country'];
      block = jsonMap['block'];
      street= jsonMap['street'];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  bool isUnknown() {
    return latitude == null || longitude == null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["description"] = description;
    map["address"] = address??'${country??''} ${city??''} ${area??''} ${street??''} ${block??''} ${house??''}';
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["is_default"] = isDefault;
    map["user_id"] = userId;
    map['postcode']= zipCode;
    map['jada']=jada ?? '';
    map['country']=country??'';
    map['city'] = city??'';
    map['block']=block ?? '';
    map['street']=street??'';
    map['area']= area ?? '';
    map['way']=way ?? '';
    map['governorate']=governorate??'';
    map['emirate']=emirate??'';
    map['province']=province??'';
    map['house']=house??'';
    map['floor']=floor??'';
    return map;
  }

  LocationData toLocationData() {
    return LocationData.fromMap({
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}
