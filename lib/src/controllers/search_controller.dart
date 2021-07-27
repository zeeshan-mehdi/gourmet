import 'package:markets/src/models/slide.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

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

class SearchController extends ControllerMVC {
  List<Market> markets = <Market>[];
  List<Product> products = <Product>[];
  List<Slide> slides = <Slide>[];

  SearchController() {
    listenForMarkets();
    listenForProducts();
    listenForSlides();
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
}
