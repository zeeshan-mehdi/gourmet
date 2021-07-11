import 'package:mvc_pattern/mvc_pattern.dart';

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

  SearchController() {
    listenForMarkets();
    listenForProducts();
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
