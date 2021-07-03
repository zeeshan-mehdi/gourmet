import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/models/category.dart';
import 'package:markets/restaurent_app/src/models/market.dart';
import 'package:markets/restaurent_app/src/repository/category_repository.dart';
import 'package:markets/restaurent_app/src/repository/market_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import  'package:markets/generated/l10n.dart';
import '../models/cart.dart';
import '../models/favorite.dart';
import '../models/option.dart';
import '../models/product.dart';
import '../repository/product_repository.dart';

class ProductController extends ControllerMVC {
  Product product;
  double quantity = 1;
  double total = 0;
  Cart cart;
  Favorite favorite;
  bool loadCart = false;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey1;
  GlobalKey<FormState> formKey;
  List<Category> categories = <Category>[];
  List<Product> products = [];

  ProductController() {
    product = Product();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.formKey = new GlobalKey<FormState>();
    this.formKey1 = new GlobalKey<FormState>();
   // listenForCategories();
    listenForProducts();

  }
  Future<String> uploadImage1(var imageFile)async{
    return  await uploadImage(imageFile);
  }

  Future getKitchens()async{
    final List<Market> stream = await getAllMarkets();
    return stream;
  }

  Future getCategories()async{
    final List<Category> stream = await getAllCategories();
    return stream;
  }


  void listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForProducts() async {
    products.clear();
    final Stream<Product> stream = await getProducts();
    stream.listen((Product _category) {
      setState(() => products.add(_category));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForProduct({String productId, String message}) async {
    final Stream<Product> stream = await getProduct(productId);
    stream.listen((Product _product) {
      setState(() => product = _product);
    }, onError: (a) {
      print(a);
      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).verify_your_internet_connection),
      // ));
    }, onDone: () {
      calculateTotal();
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForFavorite({String productId}) async {
    final Stream<Favorite> stream = await isFavoriteProduct(productId);
    stream.listen((Favorite _favorite) {
      setState(() => favorite = _favorite);
    }, onError: (a) {
      print(a);
    });
  }

  bool isSameMarkets(Product product) {
    if (cart != null) {
      return cart.product?.market?.id == product.market.id;
    }
    return true;
  }

  addNewProduct()async{
    return await addProduct(this.product);
  }

  void addToFavorite(Product product) async {
    var _favorite = new Favorite();
    _favorite.product = product;
    _favorite.options = product.options.where((Option _option) {
      return _option.checked;
    }).toList();
    addFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = value;
      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).thisProductWasAddedToFavorite),
      ));
    });
  }

  void removeFromFavorite(Favorite _favorite) async {
    removeFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = new Favorite();
      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).thisProductWasRemovedFromFavorites),
      ));
    });
  }

  Future<void> refreshProduct() async {
    var _id = product.id;
    product = new Product();
    listenForFavorite(productId: _id);
    listenForProduct(productId: _id, message: S.of(state.context).productRefreshedSuccessfully);
  }

  Future<void> refreshProducts() async {
    products.clear();
    listenForProducts();
  }



  void calculateTotal() {
    total = product?.price ?? 0;
    product.options.forEach((option) {
      total += option.checked ? option.price : 0;
    });
    total *= quantity;
    setState(() {});
  }

  incrementQuantity() {
    if (this.quantity <= 99) {
      ++this.quantity;
      calculateTotal();
    }
  }

  decrementQuantity() {
    if (this.quantity > 1) {
      --this.quantity;
      calculateTotal();
    }
  }
}
