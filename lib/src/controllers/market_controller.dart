import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:markets/src/helpers/custom_trace.dart';
import 'package:markets/src/models/favorite.dart';
import 'package:markets/src/models/option.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/category.dart';
import '../models/gallery.dart';
import '../models/market.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../repository/category_repository.dart';
import '../repository/gallery_repository.dart';
import '../repository/market_repository.dart';
import '../repository/product_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart' as userRepo;

class MarketController extends ControllerMVC {
  Market market;
  Favorite favorite;
  Favorite favoriteProduct;

  List<Gallery> galleries = <Gallery>[];
  List<Product> products = <Product>[];
  List<Category> categories = <Category>[];
  List<Product> trendingProducts = <Product>[];
  List<Product> featuredProducts = <Product>[];
  List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Favorite> favorites = <Favorite>[];
  List<Favorite> kitchenFavorites = <Favorite>[];
  MarketController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFavorites();
  }
   bool getKitchenFavourite(){
  // print('eed' + favorites.firstWhere((element) => element.product.market.id == market.id).toString());
print(favorites.length);
     int i =favorites.indexWhere((element) => element.product.market.id == market.id);
    print(i.toString() + 'ffffrrrr');
    if(i != -1){
      print('fftt');

      return true;

    }else{
      return false;
    }
    print('kitchen length');

  }

  void listenForFavorites({String message}) async {
    final Stream<Favorite> stream = await getFavorites();
    stream.listen((Favorite _favorite) {
      print('rrrrr');
      print(_favorite.toMap());

        favorites.add(_favorite);

      print(favorites.length);

    }, onError: (a) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }
  Future<dynamic> listenForMarket({String id, String message}) async {
    final whenDone = new Completer();
    final Stream<Market> stream = await getMarket(id, deliveryAddress.value);
    stream.listen((Market _market) {
      print(_market.toMap());
      setState(() => market = _market);
      return whenDone.complete(_market);
    }, onError: (a) {
      print(CustomTrace(StackTrace.current, message: a.toString()).toString());
      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).verify_your_internet_connection),
      // ));
      return whenDone.complete(Market.fromJSON({}));
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
        return whenDone.complete(market);
      }
    });
    return whenDone.future;
  }

  void listenForGalleries(String idMarket) async {
    final Stream<Gallery> stream = await getGalleries(idMarket);
    stream.listen((Gallery _gallery) {
      setState(() => galleries.add(_gallery));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForMarketReviews({String id, String message}) async {
    final Stream<Review> stream = await getMarketReviews(id);
    stream.listen((Review _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) { print(CustomTrace(StackTrace.current, message: a.toString()).toString());}, onDone: () {});
  }


   listenForMarketDesign({Market market,context}) async {
   addmarketDesign(market).then((value) {
     print('updated');
     Navigator.of(context).pushNamed('/Pages',arguments: RouteArgument(id: '4', param: market.id));
     print(value);

   });


  }
bool checkFavourite(id){
    int i =favorites.indexWhere((element) => element.product.id == id);
    if(i != -1){
      return true;
    }else{
      return false;
    }
}
 getFavouriteProduct(id){
    int i =favorites.indexWhere((element) => element.product.id == id);
    if(i != -1){
      return favorites[i];
    }else{
      return false;
    }
}

  void listenForProducts(String idMarket, {List<String> categoriesId}) async {
    final Stream<Product> stream = await getProductsOfMarket(idMarket, categories: categoriesId);
    stream.listen((Product _product) {
      setState(() => products.add(_product));
    }, onError: (a) {
      print(CustomTrace(StackTrace.current, message: a.toString()).toString());
    }, onDone: () {
      try {
        market
          ..name = products
              .elementAt(0)
              .market
              .name;
      }catch(e){
        print(e);
      }
    });
  }

  void listenForTrendingProducts(String idMarket) async {
    final Stream<Product> stream = await getTrendingProductsOfMarket(idMarket);
    stream.listen((Product _product) {
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {
      print(CustomTrace(StackTrace.current, message: a.toString()).toString());
    }, onDone: () {});
  }

  void listenForFeaturedProducts(String idMarket) async {
    final Stream<Product> stream = await getFeaturedProductsOfMarket(idMarket);
    stream.listen((Product _product) {
      setState(() => featuredProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForCategories(String marketId) async {
    final Stream<Category> stream = await getCategoriesOfMarket(marketId);
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(CustomTrace(StackTrace.current, message: a.toString()).toString());
    }, onDone: () {
      categories.insert(0, new Category.fromJSON({'id': '0', 'name': S.of(state.context).all}));
    });
  }

  Future<void> selectCategory(List<String> categoriesId) async {
    products.clear();
    listenForProducts(market.id, categoriesId: categoriesId);
  }



  Future<void> refreshMarket() async {
    var _id = market.id;
    market = new Market();
    galleries.clear();
    reviews.clear();
    featuredProducts.clear();
    favorites.clear();
    kitchenFavorites.clear();
    listenForFavorites();
    listenForMarket(id: _id, message: S.of(state.context).market_refreshed_successfuly);
    listenForMarketReviews(id: _id);
    listenForGalleries(_id);
    listenForFeaturedProducts(_id);




  }

  void addToFavorite(Product product) async {
    var _favorite = new Favorite();
   print(product.id);
   _favorite.product = product;

   _favorite.options = product.options.where((Option _option) {
      return _option.checked;
    }).toList();
   print(_favorite.product.id);

    addFavorite(_favorite).then((value) {
      setState(() {
        print(value.product.name);
        this.favoriteProduct = value;

      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).thisProductWasAddedToFavorite),
      ));
    });
  }


  void addToFavoriteKitchens(String market) async {
    var _favorite = new Favorite();
    // print(product.id);
    // _favorite.product = product;

    // _favorite.options = product.options.where((Option _option) {
    //    return _option.checked;
    //  }).toList();
    // print(_favorite.product.id);

    addFavoriteKitchen(market).then((value) {
      setState(() {
        print(value.product.name);
        this.favorite = value;
      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).thisProductWasAddedToFavorite),
      ));
    });
  }


  void removeFromFavorite(Favorite _favorite) async {
    print('in fvrt mrthod');
    print(_favorite.toMap());
    removeFavoriteKitechen(_favorite).then((value) {
      setState(() {
        this.favorite = new Favorite();

      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).thisProductWasRemovedFromFavorites),
      ));
    });
  }


  void removeFromFavoriteKitchens(Favorite _favorite) async {
    removeFavoriteKitchen(_favorite).then((value) {
      setState(() {
        this.favorite = new Favorite();
      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).thisProductWasRemovedFromFavorites),
      ));
    });
  }



}
