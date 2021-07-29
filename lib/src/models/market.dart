import 'package:markets/src/helpers/custom_trace.dart';

import '../models/media.dart';
import 'user.dart';

class Market {
  String id;
  String name;
  Media image;
  String rate;
  String address;
  String description;
  String phone;
  String mobile;
  String information;
  double deliveryFee;
  double adminCommission;
  double defaultTax;
  String latitude;
  String longitude;
  bool closed;
  bool availableForDelivery;
  double deliveryRange;
  double distance;
  List<User> users;
  bool isPaidKitchen = false;
  String cuisine;
  bool sameDayDelivery = false;
  bool vegetarianFood = false;
  int maximumOrdersPerDay = 100;
  int autoAccept;

  Market();

  Market.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
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
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      closed = jsonMap['closed'] ?? false;
      autoAccept = jsonMap['auto_accept'] ?? 0;
      isPaidKitchen = jsonMap['is_paid']==1 ?? false;
      availableForDelivery = jsonMap['available_for_delivery'] ?? false;
      vegetarianFood = jsonMap['vegetarian_food']==1 ?? false;
      sameDayDelivery = jsonMap['same_day_delivery']==1 ?? false;
      cuisine = jsonMap['cuisine'] ?? null;
      maximumOrdersPerDay = jsonMap['maximum_orders_per_day'] ??100;
      distance = jsonMap['distance'] != null ? double.parse(jsonMap['distance'].toString()) : 0.0;
      users = jsonMap['users'] != null && (jsonMap['users'] as List).length > 0 ? List.from(jsonMap['users']).map((element) => User.fromJSON(element)).toSet().toList() : [];
    } catch (e) {
      id = '';
      name = '';
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
      isPaidKitchen = false;
      autoAccept = 0;
      users = [];
      print(CustomTrace(StackTrace.current, message: e.toString()).toString());
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'auto_accept':autoAccept,
      'longitude': longitude,
      'delivery_fee': deliveryFee,
      'distance': distance,
      'cuisine':cuisine,
      'same_day_delivery':sameDayDelivery,
      'vegetarian_food':vegetarianFood,
      'maximum_orders_per_day':maximumOrdersPerDay,
    };
  }
}
