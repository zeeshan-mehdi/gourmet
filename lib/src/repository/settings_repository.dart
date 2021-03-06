import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/maps_util.dart';
import '../models/address.dart';
import '../models/coupon.dart';
import '../models/setting.dart';


import 'user_repository.dart' as userRepo;

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
ValueNotifier<Address> deliveryAddress = new ValueNotifier(new Address());
ValueNotifier<String> currency = new ValueNotifier('');
Coupon coupon = new Coupon.fromJSON({});
final navigatorKey = GlobalKey<NavigatorState>();

Future<Setting> initSettings() async {
  Setting _setting;
  final String url = '${GlobalConfiguration().getValue('api_base_url')}settings';
  try {
    final response = await http.get(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200 && response.headers.containsValue('application/json')) {
      if (json.decode(response.body)['data'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('settings', json.encode(json.decode(response.body)['data']));
        _setting = Setting.fromJSON(json.decode(response.body)['data']);
        if (prefs.containsKey('language')) {
          _setting.mobileLanguage.value = Locale(prefs.get('language'), '');
        }
        _setting.brightness.value = prefs.getBool('isDark') ?? false ? Brightness.dark : Brightness.light;
        setting.value = _setting;
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        setting.notifyListeners();
      }
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Setting.fromJSON({});
  }
  return setting.value;
}

Future<int> getTime() async{
  SharedPreferences instance = await SharedPreferences.getInstance();
  return instance.get('time')??5;
}

Future<dynamic> setCurrentLocation() async {

  var address =  await userRepo.getDefaultAddresses();
  final whenDone = new Completer();
  if(address==null) {
    var location = new Location();
    MapsUtil mapsUtil = new MapsUtil();

    Address _address = new Address();
    location.requestService().then((value) async {
      location.getLocation().then((_locationData) async {
        String _addressName = await mapsUtil.getAddressName(
            new LatLng(_locationData?.latitude, _locationData?.longitude),
            setting.value.googleMapsKey);

        print('i am getting lat :${_locationData
            ?.latitude}  and longitude ${_locationData?.longitude}');

        _address = Address.fromJSON({
          'address': _addressName,
          'latitude': _locationData?.latitude,
          'longitude': _locationData?.longitude
        });

        print('address that i have ${_address.toMap()}');

        await changeCurrentLocation(_address);
        whenDone.complete(_address);
      }).timeout(Duration(seconds: 10), onTimeout: () async {
        await changeCurrentLocation(_address);
        whenDone.complete(_address);
        return null;
      }).catchError((e) {
        whenDone.complete(_address);
      });
    });
    return whenDone.future;
  }else{
    await changeCurrentLocation(address);
    whenDone.complete(address);
    return whenDone.future;
  }
}

Future<Address> changeCurrentLocation(Address _address) async {
  if (!_address.isUnknown()) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('delivery_address', json.encode(_address.toMap()));
  }
  if(_address.country =='KW'){
    currency.value ='kWD';
  }else if(_address.country  == 'SA'){
    currency.value ='SR';
  }else{
    currency.value=setting.value.defaultCurrency;
  }
  return _address;
}

Future<Address> getCurrentLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //await prefs.clear();
  if (prefs.containsKey('delivery_address')) {
    deliveryAddress.value = Address.fromJSON(json.decode(prefs.getString('delivery_address')));
    if(deliveryAddress.value.country =='KW'){
      currency.value ='kWD';
    }else if(deliveryAddress.value.country == 'SA'){
      currency.value ='SR';
    }else{
      currency.value=setting.value.defaultCurrency;
    }
    return deliveryAddress.value;
  } else {
    deliveryAddress.value = Address.fromJSON({});
    if(deliveryAddress.value.country =='KW'){
      currency.value ='kWD';
    }else if(deliveryAddress.value.country == 'SA'){
      currency.value ='SR';
    }else{
      currency.value=setting.value.defaultCurrency;
    }
    return Address.fromJSON({});
  }
}

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (brightness == Brightness.dark) {
    prefs.setBool("isDark", true);
    brightness = Brightness.dark;
  } else {
    prefs.setBool("isDark", false);
    brightness = Brightness.light;
  }
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await prefs.get('language');
  }
  return defaultLanguage;
}

Future<void> saveMessageId(String messageId) async {
  if (messageId != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('google.message_id', messageId);
  }
}

Future<String> getMessageId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('google.message_id');
}
