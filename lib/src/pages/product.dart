import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/generated/l10n.dart';
import 'package:markets/restaurent_app/src/controllers/order_controller.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/controllers/checkout_controller.dart';
import 'package:markets/src/controllers/market_controller.dart';
import 'package:markets/src/controllers/product_controller.dart';
import 'package:markets/src/elements/AddToCartAlertDialog.dart';
import 'package:markets/src/elements/ShoppingCartButtonWidget.dart';
import 'package:markets/src/models/market.dart';
import 'package:markets/src/models/product.dart';
import 'package:markets/src/pages/cart.dart';
import 'package:markets/src/pages/kitchen_cart.dart';
import 'package:markets/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

import '../elements/CircularLoadingWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart' as settingRepo;

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  RouteArgument routeArgument;

  ProductWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _ProductWidgetState createState() {
    return _ProductWidgetState();
  }
}

class _ProductWidgetState extends StateMVC<ProductWidget> {
  MarketController _con;

  ProductController _productController;
  CartController _cartController;

  int cartIndex = 0;

  Function refreshCart;

  bool cartLoading = false;

  _ProductWidgetState() : super(MarketController()) {
    _con = controller;
  }

  @override
  void initState() {
    _productController = ProductController();
    _cartController = CartController();

    _productController.listenForCart();
    _con.listenForMarket(id: widget.routeArgument.param).then((value) {
      setState(() {
        _con.market = value as Market;
        print(_con.market.toMap());
      });
    });

    _con.listenForProducts(widget.routeArgument.param);

    // _con.listenForCart();
    // _con.listenForFavorite(productId: widget.routeArgument.id);
    super.initState();
  }

  int selectedIndex = null;

  // List<Product> products = <Product>[];
  List<Product> products = List<Product>();

// List<SelectedOrderItem> selecteditems = List<SelectedOrderItem>();
  @override
  Widget build(BuildContext context) {
    String langCode =
        settingRepo.setting.value.mobileLanguage.value.languageCode;

    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
      //   ],
      // ) ,
      key: _con.scaffoldKey,
      body: _con.market == null ||
              _con.market?.image == null ||
              _productController.loading
          ? CircularLoadingWidget(height: 500)
          : RefreshIndicator(
              onRefresh: _con.refreshMarket,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 0),
                    padding: EdgeInsets.only(bottom: 0),
                    child: CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor:
                              Theme.of(context).accentColor.withOpacity(0.9),
                          expandedHeight: 275,
                          elevation: 0,
                          automaticallyImplyLeading: false,
                          // leadingWidth:  config.App(context).appWidth(400),
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),

                          iconTheme: IconThemeData(
                              color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                              tag: (widget?.routeArgument?.heroTag ?? '') +
                                  _con.market.id,
                              child: Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        // color: Colors.greenAccent,
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: _con.market.image.url,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/img/loading.gif',
                                          fit: BoxFit.cover,
                                          width: 400,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 0, top: 130, right: 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 2, right: 20),
                                              child: Text(
                                                langCode == 'en'
                                                    ? _con.market?.name ?? ''
                                                    : _con.market?.nameAr ?? '',
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 30),
                                              ),
                                            ),

                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                              color: Colors.transparent,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  // SizedBox(
                                                  //   width: 42,
                                                  //   height: 8,
                                                  //   child: MaterialButton(
                                                  //     elevation: 0,
                                                  //     padding: EdgeInsets.all(0),
                                                  //     onPressed: () {
                                                  //       Navigator.of(context).pushNamed(
                                                  //           '/Pages',
                                                  //           arguments: new RouteArgument(
                                                  //               id: '1', param: _con.market));
                                                  //     },
                                                  //     child: Icon(
                                                  //       Icons.golf_course_outlined,
                                                  //       color: Colors.grey.withOpacity(0.5),
                                                  //       size: 24,
                                                  //     ),
                                                  //     color: Theme.of(context)
                                                  //         .primaryColor
                                                  //         .withOpacity(0.9),
                                                  //     shape: StadiumBorder(),
                                                  //   ),
                                                  // ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_pin,
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                        ),
                                                        Text(
                                                          _con.market
                                                                  ?.address ??
                                                              '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(
                                            //       left: 20, top: 0, right: 20),
                                            //   child: Text(
                                            //     "Address" ?? '',
                                            //     overflow: TextOverflow.fade,
                                            //     softWrap: false,
                                            //     maxLines: 2,
                                            //     style: TextStyle(fontSize: 14),
                                            //   ),
                                            // ),

                                            Container(
                                              height: 76,
                                              color: Color(0xFF7A6857)
                                                  .withOpacity(0.7),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    S
                                                        .of(context)
                                                        .restaurant_achievements,
                                                    overflow: TextOverflow.fade,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.orangeAccent,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Container(
                                                          height: 29,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Container(
                                                          height: 29,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightGreen,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Container(
                                                          height: 29,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Container(
                                                          height: 29,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //)
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),

                          // flexibleSpace: FlexibleSpaceBar(
                          //   collapseMode: CollapseMode.parallax,
                          //   background: Stack(
                          //     alignment: AlignmentDirectional.bottomCenter,
                          //     children: <Widget>[
                          //       CarouselSlider(
                          //         options: CarouselOptions(
                          //           autoPlay: true,
                          //           autoPlayInterval: Duration(seconds: 7),
                          //           height: 300,
                          //           viewportFraction: 1.0,
                          //           onPageChanged: (index, reason) {
                          //             setState(() {
                          //               _con.current = index;
                          //             });
                          //           },
                          //         ),
                          //         items: _con.product.images.map((Media image) {
                          //
                          //           String url = image.url;
                          //
                          //           if(url!=null && ! url.contains("https")) {
                          //             url = url.replaceFirst("http", "https");
                          //           }
                          //
                          //           return Builder(
                          //             builder: (BuildContext context) {
                          //               return CachedNetworkImage(
                          //                 height: 300,
                          //                 width: double.infinity,
                          //                 fit: BoxFit.cover,
                          //                 imageUrl: url,
                          //                 placeholder: (context, url) => Image.asset(
                          //                   'assets/img/loading.gif',
                          //                   fit: BoxFit.cover,
                          //                   width: double.infinity,
                          //                   height: 300,
                          //                 ),
                          //                 errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          //               );
                          //             },
                          //           );
                          //         }).toList(),
                          //       ),
                          //       Container(
                          //         //margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: _con.product.images.map((Media image) {
                          //             return Container(
                          //               width: 20.0,
                          //               height: 5.0,
                          //               margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.all(
                          //                     Radius.circular(10),
                          //                   ),
                          //                   color: _con.current == _con.product.images.indexOf(image)
                          //                       ? Theme.of(context).accentColor
                          //                       : Theme.of(context).primaryColor.withOpacity(0.4)),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Wrap(
                              runSpacing: 8,
                              children: [
                                Text(
                                  S.of(context).favorites,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                      controller: PageController(
                                          viewportFraction: 0.5,
                                          initialPage: 0),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _con.products.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Stack(
                                                  alignment: langCode == 'en'
                                                      ? AlignmentDirectional
                                                          .topEnd
                                                      : AlignmentDirectional
                                                          .topStart,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        // color: Colors.greenAccent,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        width: 200,
                                                        height: 120,
                                                        fit: BoxFit.cover,
                                                        imageUrl: _con
                                                            .products[index]
                                                            .image
                                                            .url,
                                                        placeholder:
                                                            (context, url) =>
                                                                Image.asset(
                                                          'assets/img/loading.gif',
                                                          fit: BoxFit.cover,
                                                          width: 200,
                                                          height: 120,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons
                                                                .error_outline),
                                                      ),
                                                    ),
                                                    _con.favoriteProduct?.id !=
                                                            null
                                                        ? IconButton(
                                                            onPressed: () {
                                                              _con.removeFromFavorite(
                                                                  _con.favoriteProduct);
                                                            },
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        20),
                                                            //color: Theme.of(context).primaryColor,
                                                            //shape: StadiumBorder(),
                                                            // borderSide: BorderSide(color: Theme.of(context).accentColor),
                                                            icon: Icon(
                                                              Icons.bookmark,
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                            ))
                                                        : IconButton(
                                                            onPressed: () {
                                                              if (currentUser
                                                                      .value
                                                                      .apiToken ==
                                                                  null) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamed(
                                                                        "/Login");
                                                              } else {
                                                                _con.addToFavorite(
                                                                    _con.products[
                                                                        index]);
                                                              }
                                                            },
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        20),
                                                            color: Colors
                                                                .transparent,
                                                            // shape: StadiumBorder(),
                                                            icon: Icon(
                                                              Icons
                                                                  .bookmark_border_outlined,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            )),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                        langCode == 'en'
                                                            ? _con
                                                                    .products[
                                                                        index]
                                                                    .name ??
                                                                ''
                                                            : _con
                                                                    .products[
                                                                        index]
                                                                    .nameAr ??
                                                                '',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Helper.getPrice(
                                                      _con.products[index]
                                                          .price,
                                                      context,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                    // _con.product.discountPrice > 0
                                                    //     ? Helper.getPrice(_con.product.discountPrice, context,
                                                    //     style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                                    //     : SizedBox(height: 0),
                                                  ],
                                                ),
                                                // Expanded(
                                                //   flex: 3,
                                                //   child: Column(
                                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                                //     children: <Widget>[
                                                //       Text(
                                                //         _con.product?.name ?? '',
                                                //         overflow: TextOverflow.ellipsis,
                                                //         maxLines: 2,
                                                //         style: Theme.of(context).textTheme.headline3,
                                                //       ),
                                                //       Text(
                                                //         _con.product?.market?.name ?? '',
                                                //         overflow: TextOverflow.ellipsis,
                                                //         maxLines: 2,
                                                //         style: Theme.of(context).textTheme.bodyText2,
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Column(
                                                //     crossAxisAlignment: CrossAxisAlignment.end,
                                                //     children: <Widget>[
                                                //       Helper.getPrice(
                                                //         _con.product.price,
                                                //         context,
                                                //         style: Theme.of(context).textTheme.headline2,
                                                //       ),
                                                //       _con.product.discountPrice > 0
                                                //           ? Helper.getPrice(_con.product.discountPrice, context,
                                                //               style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                                //           : SizedBox(height: 0),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            onTap: () {
                                              setState(() {
                                                cartLoading = true;
                                              });

                                              // if (!isPresent) {
                                              print(_con.products[index].name);
                                              setState(() {
                                                selectedIndex = index;
                                                //  List<Product> products = List<Product>();
                                                products
                                                    .add(_con.products[index]);
                                                // products.add(SelectedOrderItem(id: _con.products[index].id,name:  _con.products[index].name,imageUrl:  _con.products[index].image.url,price:_con.products[index].price ));
                                                products.toSet().toList();

                                                print('index  $index');

                                                if (currentUser
                                                        .value.apiToken ==
                                                    null) {
                                                  setState(() {
                                                    cartLoading = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushNamed("/Login");
                                                } else {
                                                  if (_productController
                                                      .isSameMarkets(_con
                                                          .products[index])) {
                                                    _productController
                                                        .addToCart(_con
                                                            .products[index]);
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      refreshCart();
                                                      _productController
                                                          .listenForCart();
                                                      setState(() {
                                                        cartLoading = false;
                                                      });
                                                    });
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        // return object of type Dialog
                                                        return AddToCartAlertDialogWidget(
                                                            oldProduct:
                                                                _productController
                                                                    .carts
                                                                    .elementAt(
                                                                        0)
                                                                    ?.product,
                                                            newProduct: _con
                                                                    .products[
                                                                selectedIndex],
                                                            onPressed: (product,
                                                                {reset: true}) {
                                                              _productController
                                                                  .addToCart(
                                                                      product,
                                                                      reset:
                                                                          reset);
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                                  () {
                                                                refreshCart();
                                                                _productController
                                                                    .listenForCart();

                                                                setState(() {
                                                                  cartLoading =
                                                                      false;
                                                                });
                                                              });
                                                              return;
                                                            });
                                                      },
                                                    );
                                                  }
                                                }
                                              });
                                            });
                                      }),
                                ),

                                Text(
                                  S.of(context).menu,
                                  style: Theme.of(context).textTheme.headline4,
                                ),

                                Container(
                                    height: 600,
                                    child: cartLoading
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              // color: Colors.greenAccent,
                                            ),
                                            child: Image.asset(
                                              'assets/img/loading.gif',
                                              fit: BoxFit.cover,
                                              width: 400,
                                            ))
                                        : KitchenCartWidget(callback: (func) {
                                            refreshCart = func;
                                          }, removeFromCart: () {
                                            Future.delayed(
                                                Duration(milliseconds: 30), () {
                                              _productController
                                                  .listenForCart();
                                              refreshCart();
                                            });
                                          })),

                                // products.isEmpty
                                //     ? SizedBox()
                                //     : Container(
                                //         height: 200,
                                //         child: ListView.builder(
                                //             controller: PageController(viewportFraction: 0.5),
                                //             itemCount: products.length,
                                //             itemBuilder: (context, index) {
                                //               return InkWell(
                                //                 child: Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: <Widget>[
                                //                     Container(
                                //                       decoration: BoxDecoration(
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(25.0),
                                //                         // color: Colors.greenAccent,
                                //                       ),
                                //                       child: CachedNetworkImage(
                                //                         width: 200,
                                //                         height: 100,
                                //                         fit: BoxFit.cover,
                                //                         imageUrl:
                                //                             products[index]
                                //                                 .image
                                //                                 .url,
                                //                         placeholder:
                                //                             (context, url) =>
                                //                                 Image.asset(
                                //                           'assets/img/loading.gif',
                                //                           fit: BoxFit.cover,
                                //                           width: 200,
                                //                           height: 100,
                                //                         ),
                                //                         errorWidget: (context,
                                //                                 url, error) =>
                                //                             Icon(Icons
                                //                                 .error_outline),
                                //                       ),
                                //                     ),
                                //                     Column(
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .start,
                                //                       children: <Widget>[
                                //                         SizedBox(
                                //                           height: 8,
                                //                         ),
                                //                         Text(
                                //                             products[index]
                                //                                 .name,
                                //                             style: TextStyle(
                                //                                 fontSize: 18,
                                //                                 color: Colors
                                //                                     .black,
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .bold)),
                                //                         Helper.getPrice(
                                //                           products[index].price,
                                //                           context,
                                //                           style: TextStyle(
                                //                               fontSize: 12,
                                //                               color: Colors
                                //                                   .black
                                //                                   .withOpacity(
                                //                                       0.5)),
                                //                         ),
                                //                         Row(children: <Widget>[
                                //                           // Expanded(
                                //                           //   child: Text(
                                //                           //     S.of(context).quantity,
                                //                           //     style: Theme.of(context).textTheme.subtitle1,
                                //                           //   ),
                                //                           // ),
                                //
                                //                           Spacer(),
                                //                           Row(
                                //                             mainAxisSize:
                                //                                 MainAxisSize
                                //                                     .min,
                                //                             children: <Widget>[
                                //                               IconButton(
                                //                                 onPressed: () {
                                //                                   // _con.decrementQuantity();
                                //                                   print("decr");
                                //                                   setState(() {
                                //                                     if (products
                                //                                         .isEmpty) {
                                //                                      // _cartController.removeFromCart(_productController.carts.elementAt(cartIndex));
                                //                                     } else {
                                //                                       products
                                //                                           .removeLast();
                                //                                       cartIndex = products.indexOf(products.last);
                                //                                       _cartController.decrementQuantity(_productController.carts.elementAt(cartIndex));
                                //
                                //                                     }
                                //                                   });
                                //                                 },
                                //                                 iconSize: 30,
                                //                                 padding: EdgeInsets
                                //                                     .symmetric(
                                //                                         horizontal:
                                //                                             5,
                                //                                         vertical:
                                //                                             10),
                                //                                 icon: Icon(Icons
                                //                                     .remove_circle_outline),
                                //                                 color: Theme.of(
                                //                                         context)
                                //                                     .hintColor,
                                //                               ),
                                //                               Text(
                                //                                   products
                                //                                       .length
                                //                                       .toString(),
                                //                                   style: Theme.of(
                                //                                           context)
                                //                                       .textTheme
                                //                                       .subtitle1),
                                //                               IconButton(
                                //                                 onPressed: () {
                                //
                                //                                     cartIndex = products.indexOf(products.last)+1;
                                //                                     _cartController.incrementQuantity(_productController.carts.elementAt(cartIndex));
                                //
                                //
                                //                                   products.add(_con
                                //                                           .products[
                                //                                       selectedIndex]);
                                //
                                //                                   setState(() {});
                                //
                                //
                                //                                   //  products.addAll(products);
                                //                                   // _con.products.incrementQuantity();
                                //                                 },
                                //                                 iconSize: 30,
                                //                                 padding: EdgeInsets
                                //                                     .symmetric(
                                //                                         horizontal:
                                //                                             5,
                                //                                         vertical:
                                //                                             10),
                                //                                 icon: Icon(Icons
                                //                                     .add_circle_outline),
                                //                                 color: Theme.of(
                                //                                         context)
                                //                                     .hintColor,
                                //                               )
                                //                             ],
                                //                           ),
                                //                         ]
                                //                             // _con.product.discountPrice > 0
                                //                             //     ? Helper.getPrice(_con.product.discountPrice, context,
                                //                             //     style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                //                             //     : SizedBox(height: 0),
                                //                             )
                                //                       ],
                                //                     ),
                                //
                                //                     // Expanded(
                                //                     //   flex: 3,
                                //                     //   child: Column(
                                //                     //     crossAxisAlignment: CrossAxisAlignment.start,
                                //                     //     children: <Widget>[
                                //                     //       Text(
                                //                     //         _con.product?.name ?? '',
                                //                     //         overflow: TextOverflow.ellipsis,
                                //                     //         maxLines: 2,
                                //                     //         style: Theme.of(context).textTheme.headline3,
                                //                     //       ),
                                //                     //       Text(
                                //                     //         _con.product?.market?.name ?? '',
                                //                     //         overflow: TextOverflow.ellipsis,
                                //                     //         maxLines: 2,
                                //                     //         style: Theme.of(context).textTheme.bodyText2,
                                //                     //       ),
                                //                     //     ],
                                //                     //   ),
                                //                     // ),
                                //                     // Expanded(
                                //                     //   flex: 1,
                                //                     //   child: Column(
                                //                     //     crossAxisAlignment: CrossAxisAlignment.end,
                                //                     //     children: <Widget>[
                                //                     //       Helper.getPrice(
                                //                     //         _con.product.price,
                                //                     //         context,
                                //                     //         style: Theme.of(context).textTheme.headline2,
                                //                     //       ),
                                //                     //       _con.product.discountPrice > 0
                                //                     //           ? Helper.getPrice(_con.product.discountPrice, context,
                                //                     //               style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                //                     //           : SizedBox(height: 0),
                                //                     //     ],
                                //                     //   ),
                                //                     // ),
                                //                   ],
                                //                 ),
                                //                 onTap: () {
                                //                   print(_con
                                //                       .products[index].name);
                                //                 },
                                //               );
                                //             }),
                                //       ),

                                // Row(
                                //   children: <Widget>[
                                //
                                //     Container(
                                //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                //       decoration: BoxDecoration(
                                //           color: Helper.canDelivery(_con.product.market) && _con.product.deliverable ? Colors.green : Colors.orange,
                                //           borderRadius: BorderRadius.circular(24)),
                                //       child: Helper.canDelivery(_con.product.market) && _con.product.deliverable
                                //           ? Text(
                                //               S.of(context).deliverable,
                                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //             )
                                //           : Text(
                                //               S.of(context).not_deliverable,
                                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //             ),
                                //     ),
                                //     Expanded(child: SizedBox(height: 0)),
                                //     Container(
                                //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                //         decoration: BoxDecoration(color: Theme.of(context).focusColor, borderRadius: BorderRadius.circular(24)),
                                //         child: Text(
                                //           _con.product.capacity + " " + _con.product.unit,
                                //           style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //         )),
                                //     SizedBox(width: 5),
                                //     Container(
                                //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                //         decoration: BoxDecoration(color: Theme.of(context).focusColor, borderRadius: BorderRadius.circular(24)),
                                //         child: Text(
                                //           _con.product.packageItemsCount + " " + S.of(context).items,
                                //           style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                //         )),
                                //   ],
                                // ),

                                //Divider(height: 0),
                                //Text(Helper.skipHtml(_con.product.description)),
                                //  Text("Menu",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                                //   Container(
                                //     height: 450,
                                //     child: CartWidget(hideAppBar: true,)
                                //     //}),
                                //    ),
                                // if (_con.product.optionGroups.isNotEmpty)
                                //   ListTile(
                                //     dense: true,
                                //     contentPadding: EdgeInsets.symmetric(vertical: 10),
                                //     leading: Icon(
                                //       Icons.add_circle_outline,
                                //       color: Theme.of(context).hintColor,
                                //     ),
                                //     title: Text(
                                //       S.of(context).options,
                                //       style: Theme.of(context).textTheme.subtitle1,
                                //     ),
                                //     subtitle: Text(
                                //       S.of(context).select_options_to_add_them_on_the_product,
                                //       style: Theme.of(context).textTheme.caption,
                                //     ),
                                //   ),
                                // _con.product.optionGroups?.isNotEmpty ?? false
                                //     ? CircularLoadingWidget(height: 100)
                                //     : ListView.separated(
                                //         padding: EdgeInsets.all(0),
                                //         itemBuilder: (context, optionGroupIndex) {
                                //           var optionGroup = _con.product.optionGroups.elementAt(optionGroupIndex);
                                //           return Wrap(
                                //             children: <Widget>[
                                //               ListTile(
                                //                 dense: true,
                                //                 contentPadding: EdgeInsets.symmetric(vertical: 0),
                                //                 leading: Icon(
                                //                   Icons.add_circle_outline,
                                //                   color: Theme.of(context).hintColor,
                                //                 ),
                                //                 title: Text(
                                //                   optionGroup.name,
                                //                   style: Theme.of(context).textTheme.subtitle1,
                                //                 ),
                                //               ),
                                //               ListView.separated(
                                //                 padding: EdgeInsets.all(0),
                                //                 itemBuilder: (context, optionIndex) {
                                //                   return OptionItemWidget(
                                //                     option: _con.product.options.where((option) => option.optionGroupId == optionGroup.id).elementAt(optionIndex),
                                //                     onChanged: _con.calculateTotal,
                                //                   );
                                //                 },
                                //                 separatorBuilder: (context, index) {
                                //                   return SizedBox(height: 20);
                                //                 },
                                //                 itemCount: _con.product.options.where((option) => option.optionGroupId == optionGroup.id).length,
                                //                 primary: false,
                                //                 shrinkWrap: true,
                                //               ),
                                //             ],
                                //           );
                                //         },
                                //         separatorBuilder: (context, index) {
                                //           return SizedBox(height: 20);
                                //         },
                                //         itemCount: _con.product.optionGroups.length,
                                //         primary: false,
                                //         shrinkWrap: true,
                                //       ),
                                // ListTile(
                                //   dense: true,
                                //   contentPadding: EdgeInsets.symmetric(vertical: 10),
                                //   leading: Icon(
                                //     Icons.recent_actors_outlined,
                                //     color: Theme.of(context).hintColor,
                                //   ),
                                //   title: Text(
                                //     S.of(context).reviews,
                                //     style: Theme.of(context).textTheme.subtitle1,
                                //   ),
                                // ),
                                // ReviewsListWidget(
                                //   reviewsList: _con.product.productReviews,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: 32,
                  //   right: 20,
                  //   child: _con.loadCart
                  //       ? SizedBox(
                  //           width: 60,
                  //           height: 60,
                  //           child: RefreshProgressIndicator(),
                  //         )
                  //       : ShoppingCartFloatButtonWidget(
                  //           iconColor: Theme.of(context).primaryColor,
                  //           labelColor: Theme.of(context).hintColor,
                  //           routeArgument: RouteArgument(param: '/Product', id: _con.product.id),
                  //         ),
                  // ),
                  // Positioned(
                  //   bottom: 0,
                  //   child: Row(
                  //     children: [
                  //
                  //       // Container(
                  //       //   height: 200,
                  //       //   color: Colors.yellow,
                  //       //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  //         // decoration: BoxDecoration(
                  //         //     color: Theme.of(context).primaryColor,
                  //         //     borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                  //         //     boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
                  //       Padding(padding: EdgeInsets.only(left: 20,bottom: 10),
                  //       child:  Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(25.0),
                  //          // color: Colors.greenAccent,
                  //         ),
                  //       child :CachedNetworkImage(
                  //         width: 100,
                  //         height: 120,
                  //         fit: BoxFit.cover,
                  //         imageUrl: _con.market.image.url,
                  //         placeholder: (context, url) => Image.asset(
                  //           'assets/img/loading.gif',
                  //           fit: BoxFit.cover,
                  //           width: 100,
                  //           height: 100,
                  //         ),
                  //         errorWidget: (context, url, error) =>
                  //             Icon(Icons.error_outline),
                  //       ),
                  //       ),),
                  //
                  //         Container(
                  //           width: MediaQuery.of(context).size.width - 160,
                  //           child: Column(
                  //             children: [
                  //               Row(
                  //                 //crossAxisAlignment: CrossAxisAlignment.end,
                  //                   children: <Widget>[
                  //                     Spacer(),
                  //                     Text("A Menu Item with \n Image"),
                  //
                  //                   ]),
                  //               Row(
                  //                 //crossAxisAlignment: CrossAxisAlignment.end,
                  //                   children: <Widget>[
                  //                     Spacer(),
                  //                     Helper.getPrice(
                  //                       _con.product.price,
                  //                       context,
                  //                       style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.5)),
                  //                     ),
                  //                     SizedBox(width: 60,),
                  //                   ]),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisSize: MainAxisSize.max,
                  //                 children: <Widget>[
                  //                   Row(
                  //                     children: <Widget>[
                  //                       // Expanded(
                  //                       //   child: Text(
                  //                       //     S.of(context).quantity,
                  //                       //     style: Theme.of(context).textTheme.subtitle1,
                  //                       //   ),
                  //                       // ),
                  //
                  //                       Spacer(),
                  //                       Row(
                  //                         mainAxisSize: MainAxisSize.min,
                  //                         children: <Widget>[
                  //                           IconButton(
                  //                             onPressed: () {
                  //                               _con.decrementQuantity();
                  //                             },
                  //                             iconSize: 30,
                  //                             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  //                             icon: Icon(Icons.remove_circle_outline),
                  //                             color: Theme.of(context).hintColor,
                  //                           ),
                  //                           Text(_con.quantity.toString(), style: Theme.of(context).textTheme.subtitle1),
                  //                           IconButton(
                  //                             onPressed: () {
                  //                               _con.incrementQuantity();
                  //                             },
                  //                             iconSize: 30,
                  //                             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  //                             icon: Icon(Icons.add_circle_outline),
                  //                             color: Theme.of(context).hintColor,
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        //  color: Colors.yellow,

                        margin: langCode == 'en'
                            ? EdgeInsets.only(
                                left: config.App(context).appWidth(78), top: 40)
                            : EdgeInsets.only(
                                right: config.App(context).appWidth(78),
                                top: 40),
                        child:

                        Row(children: <Widget>[
                          _con.favorite?.id != null
                              ? IconButton(
                                  onPressed: () {
                                    _con.removeFromFavoriteKitchens(
                                        _con.favorite);
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  //color: Theme.of(context).primaryColor,
                                  //shape: StadiumBorder(),
                                  // borderSide: BorderSide(color: Theme.of(context).accentColor),
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Theme.of(context).accentColor,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    if (currentUser.value.apiToken == null) {
                                      Navigator.of(context).pushNamed("/Login");
                                    } else {
                                      _con.addToFavoriteKitchens(
                                          _con.market.id);
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  color: Colors.transparent,
                                  // shape: StadiumBorder(),
                                  icon: Icon(
                                    Icons.bookmark_border_outlined,
                                    color: Theme.of(context).primaryColor,
                                  )),
                        ])),
                  )
                  // Spacer(),
                  // SizedBox(width: 2),
                  // Stack(
                  //   // fit: StackFit.,
                  //   alignment: AlignmentDirectional.bottomStart,
                  //   children: <Widget>[
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width - 180,

                  //     ),
                  //
                  //
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 9),
                  //       child: Helper.getPrice(
                  //         _productController.total,
                  //         context,
                  //         style: TextStyle(
                  //             color: Theme.of(context).primaryColor,
                  //             fontSize: 14),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  //     ],
                  //   ),
                  // ),
                  //
                  //                   SizedBox(height: 10),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //
                  //        // ),
                  //       ),
                  //     ],
                  //   ),
                  //
                  // )
                ],
              ),
            ),

      // bottomSheet: SolidBottomSheet(
      //   headerBar: Container(
      //     color: Theme.of(context).primaryColor,
      //     height: 50,
      //     child: Center(
      //       child: Text("Swipe me!"),
      //     ),
      //   ),
      //   body:
      //   Container(
      //     color: Colors.white,
      //     height: 30,
      //     child: Center(
      //       child: CartWidget(hideAppBar: true,),
      //     ),
      //   ),
      // ),
    );
  }
}

class SelectedOrderItem {
  String id;
  String name;
  double price;
  String imageUrl;

  SelectedOrderItem({this.id, this.name, this.price, this.imageUrl});
}
