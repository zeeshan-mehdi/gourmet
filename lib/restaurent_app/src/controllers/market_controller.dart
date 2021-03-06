import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import  'package:markets/generated/l10n.dart';
import '../models/gallery.dart';
import '../models/market.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../repository/gallery_repository.dart';
import '../repository/market_repository.dart';
import '../repository/product_repository.dart';



class MarketController extends ControllerMVC {
  Market market;
  Market kitchen = Market();
  List<Gallery> galleries = <Gallery>[];
  List<Market> markets = <Market>[];
  List<Product> products = <Product>[];
  List<Product> trendingProducts = <Product>[];
  List<Product> featuredProducts = <Product>[];
  List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  GlobalKey<FormState> formKey1;  //for page 1 about kitchen

  bool loadingMakets =true;

  MarketController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.formKey1 = new GlobalKey<FormState>();
    this.formKey = new GlobalKey<FormState>();
  }

  isPaid(){
    return isPaidUser();
  }

  getFirstMarket()async{

    final Stream<Market> stream = await getMarkets();
    Market firstMarket ;
    try {
     // throw Exception('no kitchen found');
      await stream.first.then((Market _market) {
        print('frst market found market');
        firstMarket = _market;
      }, onError: (a) {
        print('something went wrong');

        print(a);
        // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        //   content: Text(S.of(state.context).verify_your_internet_connection),
        // ));
      });
    }catch(e){
      print(e);
      firstMarket = null;
    }

    return firstMarket;
  }

 Future<String> uploadImage1(var imageFile)async{
   return  await uploadImage(imageFile);
  }

  getDriversList()async{
    return await getAllDrivers();
  }


  addNewMarket()async{
    return await addMarket(this.kitchen);
  }



  void listenForMarkets({String message, shouldLoad}) async {
    final Stream<Market> stream = await getMarkets();
    loadingMakets  = false;
    stream.listen((Market _market) {

      print('adding market');
      setState(() => markets.add(_market));
    }, onError: (a) {
      print('something went wrong');

      print(a);

      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).verify_your_internet_connection),
      // ));
    }, onDone: () {
      if(shouldLoad){
        print('i am loading ');
        listenForMarket(id: markets.first.id);
        listenForGalleries( markets.first.id);
        listenForFeaturedProducts( markets.first.id);
        listenForMarketReviews(id:  markets.first.id);
      }
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });

  }

  void listenForMarket({String id, String message}) async {
    final Stream<Market> stream = await getMarket(id);
    stream.listen((Market _market) {
      setState(() => market = _market);
    }, onError: (a) {
      print(a);
      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).verify_your_internet_connection),
      // ));
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
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
    }, onError: (a) {}, onDone: () {});
  }

  void listenForProducts(String idMarket) async {
    final Stream<Product> stream = await getProductsOfMarket(idMarket);
    stream.listen((Product _product) {
      setState(() => products.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForTrendingProducts(String idMarket) async {
    final Stream<Product> stream = await getTrendingProductsOfMarket(idMarket);
    stream.listen((Product _product) {
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {
      print(a);
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

  Future<void> refreshMarket() async {
    var _id = market.id;
    market = new Market();
    galleries.clear();
    reviews.clear();
    featuredProducts.clear();
    listenForMarket(id: _id, message: S.of(state.context).market_refreshed_successfuly);
    listenForMarketReviews(id: _id);
    listenForGalleries(_id);
    listenForFeaturedProducts(_id);
  }

  Future<void> refreshMarkets() async {
    markets.clear();
    listenForMarkets(message: S.of(state.context).market_refreshed_successfuly);
  }
}
