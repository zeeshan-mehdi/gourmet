import '../models/media.dart';
import 'user.dart';

class Market {
  String id;
  String name;
  String nameAr;
  Media image;
  List<Media> images;
  String rate;
  String address;
  String description;
  String descriptionAr;

  String information;
  String informationAr;
  String termsAndConditions;
  String termsAndConditionsAr;
  String phone;
  String mobile;
  double deliveryFee;
  double adminCommission;
  double defaultTax;
  String latitude;
  String longitude;
  bool closed = false;
  bool isPaidKitchen = false;
  bool availableForDelivery= false;
  double deliveryRange;
  double distance;

  String uuid;
  List<User> users;
  List drivers;

  Market({closed = false,isPaidKitchen = false,availableForDelivery= false});

  Market.fromJSON(Map<String, dynamic> jsonMap) {
    print(jsonMap);
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      nameAr = jsonMap['name_ar'];
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
      rate = jsonMap['rate'] ?? '0';
      deliveryFee = jsonMap['delivery_fee'] != null ? jsonMap['delivery_fee'].toDouble() : 0.0;
      adminCommission = jsonMap['admin_commission'] != null ? jsonMap['admin_commission'].toDouble() : 0.0;
      deliveryRange = jsonMap['delivery_range'] != null ? jsonMap['delivery_range'].toDouble() : 0.0;
      address = jsonMap['address'];
      description = jsonMap['description'];
      phone = jsonMap['phone'];
      mobile = jsonMap['mobile'];
      defaultTax = jsonMap['default_tax'] != null ? jsonMap['default_tax'].toDouble() : 0.0;
      information = jsonMap['information'];
      informationAr = jsonMap['information_ar'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      closed = jsonMap['closed'] ?? false;
      availableForDelivery = jsonMap['available_for_delivery'] ?? false;
      distance = jsonMap['distance'] != null ? double.parse(jsonMap['distance'].toString()) : 0.0;
      users = jsonMap['users'] != null && (jsonMap['users'] as List).length > 0 ? List.from(jsonMap['users']).map((element) => User.fromJSON(element)).toSet().toList() : [];
    } catch (e) {
      id = '';
      name = '';
      nameAr = '';
      image = new Media();
      rate = '0';
      deliveryFee = 0.0;
      adminCommission = 0.0;
      deliveryRange = 0.0;
      address = '';
      description = '';
      phone = '';
      mobile = '';
      defaultTax = 0.0;
      information = '';
      latitude = '0';
      longitude = '0';
      closed = false;
      availableForDelivery = false;
      distance = 0.0;
      users = [];
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'delivery_fee': deliveryFee,
      'distance': distance,
    };
  }

  Map<String, dynamic> toJson(apiToken) {
    return {
      'user_id': id,
      'name': name,
      'name_ar': nameAr,
      'address':address,
      'latitude': latitude,
      'longitude': longitude,
      'delivery_fee': deliveryFee,
      'delivery_range': distance,
      'description': description,
      'description_ar': descriptionAr,
      'information': information,
      'information_ar': informationAr,
      'terms_and_conditions': termsAndConditions,
      'terms_and_conditions_ar': termsAndConditionsAr,
      'image': uuid,
      'available_for_delivery': availableForDelivery,
      'closed': closed,
      'is_paid': isPaidKitchen,
      'mobile': mobile,
      'phone': phone,
      'drivers':drivers,
      'api_token':apiToken
    };
  }






}
