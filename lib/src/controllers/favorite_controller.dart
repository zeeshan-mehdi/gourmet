import 'package:flutter/material.dart';
import 'package:markets/src/models/market.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/favorite.dart';
import '../repository/product_repository.dart';

class FavoriteController extends ControllerMVC {
  List<Favorite> favorites = <Favorite>[];
  List<Market> favoritesKitchen = <Market>[];
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

  void listenForFavoritesKitchen({String message}) async {
    favoritesKitchen = await getFavoritesKitchen();
    setState(() {});
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
