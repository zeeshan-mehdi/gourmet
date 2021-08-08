import 'package:flutter_screenutil/screenutil.dart';
import 'package:markets/src/elements/CircularLoadingWidget.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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

import 'package:markets/src/repository/settings_repository.dart' as settingRepo;
class StaticMenuGridScreen extends StatefulWidget {
  RouteArgument routeArgument;
  StaticMenuGridScreen({this.routeArgument}) ;

  @override
  _StaticMenuGridScreenState createState() => _StaticMenuGridScreenState();
}

class _StaticMenuGridScreenState extends StateMVC<StaticMenuGridScreen> {
  MarketController _con;

  ProductController _productController;
  CartController _cartController;

  int cartIndex = 0;

  Function refreshCart;
  List<Product> products = List<Product>();
  bool cartLoading = false;
  _StaticMenuGridScreenState() : super(MarketController()) {
    _con = controller;
  }
  void initState() {

    _productController = ProductController();

_productController.listenForCartsCount();

    _con.listenForMarket(id: widget.routeArgument.param).then((value) {
      setState(() {
        _con.market = value as Market;
        print(_con.market.toMap());
      });
    });

    _con.listenForProducts(widget.routeArgument.param);
    _productController.listenForCart();

    // _con.listenForCart();
    // _con.listenForFavorite(productId: widget.routeArgument.id);
    super.initState();
  }
  int selectedIndex = null;

  @override
  Widget build(BuildContext context) {
    String langCode = settingRepo.setting.value.mobileLanguage.value.languageCode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(height);
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: false);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(

          onPressed: () {


          },
         // icon: Icon(Icons.save),
          label: Row(
            children: [
              Text( 'Empty Cart' ?? "Empty cart"),

              new Container(

                  child: new Stack(

                    children: <Widget>[
                      new IconButton(icon: new Icon(Icons.shopping_cart,
                        color: Colors.white,),
                        onPressed: null,
                      ),


                    ],
                  )
              ),

             // Text(_productController.quantity.toString() != '0.0' ?_productController.quantity.round().toString() : 'Empty Cart' ?? "Empty cart"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: _con.market == null || _con.market?.image == null || _productController.loading
            ? CircularLoadingWidget(height: 500)
            :  RefreshIndicator(
          onRefresh: _con.refreshMarket,
          child: Stack(
            children: [
              Container(
                height: ScreenUtil.screenHeight * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          // color: Colors.greenAccent,
                        ),
                        child: CachedNetworkImage(
                          height: ScreenUtil.screenHeight * 0.4,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: _con.market.image.url,
                          placeholder: (context, url) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),
                        )),
                    Container(
                      height: ScreenUtil.screenHeight * 0.35,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          stops: [0.2, 0.99],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          tileMode: TileMode.repeated,
                          // end: const Alignment(0.3, 0.2),
                          // begin: const Alignment(0.5, 0.6),
                          colors: <Color>[
                            Colors.white60.withOpacity(0.3),
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(top: ScreenUtil.screenHeight * 0.1, child: Header()),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: ScreenUtil.screenHeight * 0.72,
                  width: ScreenUtil.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: SingleChildScrollView(
                      child: Container(
                        height: ScreenUtil.screenHeight * 0.76,
                        width: ScreenUtil.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: ScreenUtil.screenHeight * 0.35,
                            ),
                            Text(
                              S.of(context).menu,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(17)),
                            ),
                            Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    //  maxCrossAxisExtent: 200,
                                      crossAxisCount: 3,
                                      childAspectRatio: height < 700 ? 0.7 : 0.55,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 5
                                  ),
                                  itemCount: _con.products.length,
                                  semanticChildCount: _con.products.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return
                                      Stack(
                                        children: [
                                          InkWell(
                                          onTap: (){


                                          },

                                          child: CardWidget(
                                            product: _con.products[index],
                                          ),
                                    ),
                                          Row(children: <Widget>[

                                            _con.checkFavourite(
                                                _con.products[index].id)
                                                ? IconButton(
                                                onPressed: () {

                                                },
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical: 0,
                                                    horizontal: 20),
                                                //color: Theme.of(context).primaryColor,
                                                //shape: StadiumBorder(),
                                                // borderSide: BorderSide(color: Theme.of(context).accentColor),
                                                icon: Icon(
                                                  Icons.bookmark,
                                                  color:
                                                  Theme.of(context)
                                                      .accentColor,
                                                ))
                                                : IconButton(
                                                onPressed: () {

                                                },
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    vertical: 0,
                                                    horizontal: 20),
                                                color:
                                                Colors.transparent,
                                                // shape: StadiumBorder(),
                                                icon: Icon(
                                                  Icons
                                                      .bookmark_border_outlined,
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                )),
                                          ])
                                        ],
                                      );
                                  }),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                  top: ScreenUtil.screenHeight * 0.23,
                  right: 10,
                  left: 10,
                  child: Container(
                    height: ScreenUtil.screenHeight * 0.4,
                    width: ScreenUtil.screenWidth,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(50),
                        ),
                        Text(
                          langCode=='en'? _con.market?.name??'' :_con.market?.nameAr  ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(20)),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.black
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
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(17),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Text(
                          S.of(context).restaurant_achievements,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(17)),
                        ),
                        if (_con.getKitchenFavourite()==true)
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  S.of(context).favorites,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      ScreenUtil().setSp(17)),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        if (_con.getKitchenFavourite()==true)
                          Container(
                            height: ScreenUtil.screenHeight * 0.15,
                            width: ScreenUtil.screenWidth,

                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _con.favorites.length,
                              itemBuilder: (context, i) {
                                print('idddss');
                                print(_con
                                    .favorites[i].product.market.id);
                                print(_con.market.id);

                                if (_con.favorites[i].product.market
                                    .id ==
                                    _con.market.id) {
                                  return InkWell(
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: ScreenUtil
                                                .screenHeight *
                                                0.07,
                                            width: ScreenUtil
                                                .screenWidth *
                                                0.2,
                                            alignment: Alignment
                                                .bottomCenter,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        _con
                                                            .favorites[
                                                        i]
                                                            .product
                                                            .image
                                                            .url)),
                                                borderRadius:
                                                BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                color: Colors.black
                                                    .withOpacity(
                                                    0.4)),
                                          ),
                                          Container(


                                            color: Colors.white
                                                .withOpacity(0.3),
                                            child: Padding(
                                              padding: EdgeInsets
                                                  .symmetric(
                                                  horizontal: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    langCode =='en'?        _con
                                                        .favorites[
                                                    i]
                                                        .product
                                                        .name ??'': _con
                                                        .favorites[
                                                    i]
                                                        .product
                                                        .nameAr ??
                                                        'Chicken'  ,
                                                    style: TextStyle(
                                                        fontSize:
                                                        ScreenUtil()
                                                            .setSp(
                                                            16)),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    ScreenUtil()
                                                        .setHeight(
                                                        5),
                                                  ),
                                                  Text(
                                                    _con
                                                        .favorites[
                                                    i]
                                                        .product
                                                        .price
                                                        .toString() ??
                                                        '\$100.00',
                                                    style: TextStyle(
                                                        fontSize:
                                                        ScreenUtil()
                                                            .setSp(
                                                            16)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil()
                                                .setHeight(10),
                                          ),
                                        ],
                                      ));
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  )),
              Positioned(
                top: ScreenUtil.screenHeight * 0.18,
                child: Center(
                  child: Container(
                    width: ScreenUtil.screenWidth,
                    child: Container(
                        width: ScreenUtil().setWidth(70),
                        height: ScreenUtil().setHeight(70),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black
                          // image: new DecorationImage(
                          //   image: new ExactAssetImage('assets/4.png'),
                          //   fit: BoxFit.cover,
                          // ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CardWidget extends StatelessWidget {
  Product product;
  CardWidget({
    this.product,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('g6');
    String langCode =
        settingRepo.setting.value.mobileLanguage.value.languageCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        product == null
            ?   Container(
          height: ScreenUtil.screenHeight * 0.13,
          width: ScreenUtil.screenWidth * 0.4,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.black.withOpacity(0.4)),
        ): Container(
          height: ScreenUtil.screenHeight * 0.13,
          width: ScreenUtil.screenWidth * 0.4,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image.url)),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.black.withOpacity(0.4)),
        ) ,
        Container(
          height: ScreenUtil.screenHeight * 0.1,
          width: ScreenUtil.screenWidth / 2.2,
          color: Colors.white.withOpacity(0.3),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product != null ? langCode == 'en'
                      ? product?.name ?? ''
                      : product?.nameAr ?? '':    'Chicken',
                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  product != null ? product.price.toString() :   '\$100.00',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16), color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },

              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white.withOpacity(0.4)),
                child: Center(child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.white.withOpacity(0.4)),
              child: Center(child: Icon(Icons.bookmark_border_sharp)),
            )
          ],
        ),
      ),
    );
  }

}