import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:markets/restaurent_app/src/pages/messages.dart';
import 'package:markets/restaurent_app/src/pages/settings_page.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/HomeScreen.dart';
import 'package:markets/src/pages/gridMenuScreen.dart';
import 'package:markets/src/pages/menuGridScreen.dart';
import 'package:markets/src/pages/product.dart';
import 'package:markets/src/pages/tabMenuScreen.dart';
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
import '../../restaurent_app/src/helpers/app_config.dart' as config;

import '../../restaurent_app/src/elements/CircularLoadingWidget.dart';
import '../../restaurent_app/src/helpers/helper.dart';

import 'package:markets/src/repository/settings_repository.dart' as settingRepo;
class NewKitchenDetailScreen extends StatefulWidget {
  RouteArgument routeArgument;
  final isSetting;
  NewKitchenDetailScreen({this.routeArgument
    ,
    isSetting }): isSetting = isSetting ?? false ;

  @override
  _NewKitchenDetailScreenState createState() => _NewKitchenDetailScreenState();
}

class _NewKitchenDetailScreenState extends StateMVC<NewKitchenDetailScreen> {
  MarketController _con;

  ProductController _productController;
  CartController _cartController;

  int cartIndex = 0;

  Function refreshCart;

  bool cartLoading = false;
  _NewKitchenDetailScreenState() : super(MarketController()) {
    _con = controller;
  }
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
  @override
  Widget build(BuildContext context) {
    String langCode = settingRepo.setting.value.mobileLanguage.value.languageCode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _con.scaffoldKey,

      body: _con.market == null || _con.market?.image == null || _productController.loading
          ? CircularLoadingWidget(height: 500)
          :   _con.market.design_type == 1 ? HomeScreen(routeArgument:  RouteArgument(param: _con.market.id, ),isSetting: false,)
        :  _con.market.design_type == 2 ? MenuGridScreen(routeArgument:  RouteArgument(param: _con.market.id ),isSetting: false)
        :  _con.market.design_type == 3 ? GridScreen(routeArgument:  RouteArgument(param: _con.market.id ),isSetting: false)
        :  _con.market.design_type == 4 ? TabsMenuScreen(routeArgument:  RouteArgument(param: _con.market.id ),isSetting: false)
          : ProductWidget(routeArgument:  RouteArgument(param: _con.market.id ))


    );
  }
}

class CardWidget extends StatelessWidget {
  Product product;
  Widget likeButton;
  CardWidget({
    this.product,
    this.likeButton,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String langCode =
        settingRepo.setting.value.mobileLanguage.value.languageCode;
    return Column(
      children: [
        Container(
          height: ScreenUtil.screenHeight * 0.33,
          width: ScreenUtil.screenWidth,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      product
                          .image
                          .url)
              ),
              color: Colors.black.withOpacity(0.4)),
          child: Container(
            height: ScreenUtil.screenHeight * 0.13,
            width: ScreenUtil.screenWidth,
            color: Colors.white.withOpacity(0.3),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        langCode == 'en'
                            ? product?.name ?? ''
                            : product?.nameAr ?? ''??  'Chicken',
                        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      Text(
                        product.price.toString() ?? '\$100.00',
                        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                      )
                    ],
                  ),
                  likeButton
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final isSetting;
  const Header({
    Key key,
    this.isSetting,
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
                if(isSetting == true){
                  Navigator.of(context).pushNamed('/Pages',arguments: RouteArgument(id: '3' ) );
                }else{
                  Navigator.pop(context);
                }

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