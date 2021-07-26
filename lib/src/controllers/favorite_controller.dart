import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/src/models/market.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../repository/product_repository.dart';

class FavoriteController extends ControllerMVC {
  List<Favorite> favorites = <Favorite>[];
  List<Favorite> favoritesKitchen = <Favorite>[];
  GlobalKey<ScaffoldState> scaffoldKey;


  FavoriteController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFavorites();
    listenForFavoritesKitchen();
  }

  void listenForFavorites({String message}) async {
    final Stream<Favorite> stream = await getFavorites();
    stream.listen((Favorite _favorite) {
      setState(() {
        favorites.add(_favorite);
      });
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


  void deleteFavoriteKitchen(Favorite favorite)async{
    var resp = await removeFavoriteKitchen(favorite);

    if(resp['success']==true) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text('Kitchen removed from Favorites'),
      ));

      listenForFavoritesKitchen();
    }else{
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text('Failed to remove Kitchen from Favorites'),
      ));
    }



  }

  void listenForFavoritesKitchen({String message}) async {
    favoritesKitchen = [];
    Stream<FavoriteMarket> data = await getFavoritesKitchen();
    print('favourite kitchens that i have');

    await data.listen((marketJson) async{
      int id = marketJson.marketId;
      Market m = await getbyMarket(id);
      Favorite f = Favorite();
      f.id = '${marketJson.favoriteId}';
      f.market = m;
      favoritesKitchen.add(f);
      //print(m);
      setState(() {});
    });

    setState(() { });


    //print(favoritesKitchen);

    //setState(() {});
    // print("favorit kitchen is caling");
    // var aa  = stream.map((event) => event.id.toString());
    // print(aa.map((event) => event.toString()));
    // print(stream.map((event) => event.id.toString()));
    // stream.listen((Favorite _favorite) {
    //   setState(() {
    //     favoritesKitchen.add(_favorite);
    //     print(_favorite);
    //   });
    // }, onError: (a) {
    //   ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
    //     content: Text(S.of(state.context).verify_your_internet_connection),
    //   ));
    // }, onDone: () {
    //   if (message != null) {
    //     ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
    //       content: Text(message),
    //     ));
    //   }
    // });
  }

  Future<void> refreshFavorites() async {
    favorites.clear();
    listenForFavorites(message: S.of(state.context).favorites_refreshed_successfuly);
  }
}
