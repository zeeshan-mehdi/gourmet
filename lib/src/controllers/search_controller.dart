import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markets/restaurent_app/src/models/user.dart';
import 'package:markets/src/models/slide.dart';
import 'package:markets/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../repository/user_repository.dart' as userRepo;

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../helpers/maps_util.dart';
import '../models/address.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';
import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/slide.dart';
import '../models/address.dart';
import '../models/market.dart';
import '../models/product.dart';
import '../repository/market_repository.dart';
import '../repository/product_repository.dart';
import '../repository/search_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/settings_repository.dart' as sett;

class SearchController extends ControllerMVC {
  List<Market> markets = <Market>[];
  List<Market> allMarkets = <Market>[];
  List<Marker> allMarkers = <Marker>[];

  double userLatitude;
  double userLongitude;
  List<Product> products = <Product>[];
  List<Slide> slides = <Slide>[];
  Set<Polyline> polylines = new Set();
  List<Market> topMarkets = <Market>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  CameraPosition cameraPosition;
  SearchController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    listenForMarkets();
    listenForProducts();
    listenForSlides();
    listenForTopMarkets();

    // setCurrentLocation();
   // getCurrentLocation();
  }

  Address currentAddress;
  Completer<GoogleMapController> mapController = Completer();
  // ValueNotifier<Address> deliveryAddress = new ValueNotifier(new Address());

  // Future<void> goCurrentLocation() async {
  //   final GoogleMapController controller = await mapController.future;
  //
  //   sett.setCurrentLocation().then((_currentAddress) {
  //     print(_currentAddress);
  //     setState(() {
  //      // sett.myAddress.value = _currentAddress;
  //       currentAddress = _currentAddress;
  //     });
  //     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(_currentAddress.latitude, _currentAddress.longitude),
  //       zoom: 14.4746,
  //     )));
  //   });
  // }
  Future<Address> getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    if (prefs.containsKey('delivery_address')) {
      print("1");
      deliveryAddress.value = Address.fromJSON(json.decode(prefs.getString('delivery_address')));
      return deliveryAddress.value;
    } else {
      print("1");

      deliveryAddress.value = Address.fromJSON({});
      return Address.fromJSON({});
    }
  }
  Future<void> listenForTopMarkets() async {
    final Stream<Market> stream = await getNearMarkets(deliveryAddress.value, deliveryAddress.value);
    //final Stream<Market> stream = await getPopularMarkets(deliveryAddress.value);
    stream.listen((Market _market) {
      if(_market.isPaidKitchen) {
        print(_market.cuisine);
        //    setState(() =>
        setState(() {
          topMarkets.add(_market);
        });
      }
    }, onError: (a) {}, onDone: () {

    });
  }

  Future<dynamic> setCurrentLocation() async {
    var location = new Location();
    MapsUtil mapsUtil = new MapsUtil();
    final whenDone = new Completer();
    Address _address = new Address();
    location.requestService().then((value) async {
      location.getLocation().then((_locationData) async {
        String _addressName = await mapsUtil.getAddressName(new LatLng(_locationData?.latitude, _locationData?.longitude), setting.value.googleMapsKey);

        print('i am getting lat :${_locationData?.latitude}  and longitude ${_locationData?.longitude}');

        _address = Address.fromJSON({'address': _addressName, 'latitude': _locationData?.latitude, 'longitude': _locationData?.longitude});
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
  }

  Future<void> listenForSlides() async {
    final Stream<Slide> stream = await getSlides();
    stream.listen((Slide _slide) {
      setState(() => slides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<Stream<Slide>> getSlides() async {
    Uri uri = Helper.getUri('api/slides');
    Map<String, dynamic> _queryParams = {
      'with': 'product;market',
      'search': 'enabled:1',
      'orderBy': 'order',
      'sortedBy': 'asc',
    };
    uri = uri.replace(queryParameters: _queryParams);
    try {
      final client = new http.Client();
      final streamedRest = await client.send(http.Request('get', uri));

      return streamedRest.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .map((data) => Helper.getData(data))
          .expand((data) => (data as List))
          .map((data) => Slide.fromJSON(data));
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
      return new Stream.value(new Slide.fromJSON({}));
    }
  }

  void listenForMarkets({String search}) async {
    if (search == null) {
      search = await getRecentSearch();
    }
    print(search);
    Address _address = deliveryAddress.value;
    print(_address.address);
    final Stream<Market> stream = await searchMarkets(search, _address);
    stream.listen((Market _market) {
      print(_market.name);
      setState(() => markets.add(_market));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForProducts({String search}) async {
    if (search == null) {
      search = await getRecentSearch();
    }
    Address _address = deliveryAddress.value;
    final Stream<Product> stream = await searchProducts(search, _address);
    stream.listen((Product _product) {
      setState(() => products.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> refreshSearch(search) async {
    setState(() {
      markets = <Market>[];
      products = <Product>[];
    });
    listenForMarkets(search: search);
    listenForProducts(search: search);
  }

  void saveSearch(String search) {
    print(search);
    refreshSearch(search);
    //setRecentSearch(search);
  }

  Future getKitchens()async{
    final List<Market> stream = await getAllMarketss();
    return stream;
  }
  Future<List<Market>> getAllMarketss() async {
    List<Market> markets = [];
    Uri uri = Helper.getUri('api/manager/markets');
    Map<String, dynamic> _queryParams = {};
    var _user = userRepo.currentUser.value;
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



}
