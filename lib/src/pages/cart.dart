import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/pages/product.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/CartItemWidget.dart';
import '../elements/EmptyCartWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class CartWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  final bool hideAppBar;


  CartWidget({Key key, this.routeArgument,this.hideAppBar = false}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends StateMVC<CartWidget> {
  CartController _con;

  _CartWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCarts();
    super.initState();
  }
  SelectedOrderItem items;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        bottomNavigationBar: CartBottomDetailsWidget(con: _con),
        appBar: widget.hideAppBar ? null : AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              if (widget.routeArgument != null) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
              }
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).my_order,
            style: Theme.of(context).textTheme.headline3.merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _con.refreshCarts,
          child: _con.carts.isEmpty
              ? EmptyCartWidget()
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView(
                      primary: true,
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20, right: 10),
                        //   child: ListTile(
                        //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                        //     leading: Icon(
                        //       Icons.shopping_cart_outlined,
                        //       color: Theme.of(context).hintColor,
                        //     ),
                        //     title: Text(
                        //       S.of(context).shopping_cart,
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: Theme.of(context).textTheme.headline4,
                        //     ),
                        //     subtitle: Text(
                        //       S.of(context).verify_your_quantity_and_click_checkout,
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: Theme.of(context).textTheme.caption,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            elevation: 5,
                            child: ListView.separated(
                              padding: EdgeInsets.only(top: 0, bottom: 0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _con.carts.length+2,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 0);
                              },
                              itemBuilder: (context, index) {


                                if(index ==0){
                                  return CartHeader(market: _con.carts[0].product.market.name,marketAddress: _con.carts[0].product.market.address,);
                                }else if(index == _con.carts.length+1){
                                  return CartFooter();
                                }


                                return CartItemWidget(
                                  cart: _con.carts.elementAt(index-1),
                                  heroTag: 'cart',
                                  increment: () {
                                    _con.incrementQuantity(_con.carts.elementAt(index-1));
                                  },
                                  decrement: () {
                                    _con.decrementQuantity(_con.carts.elementAt(index-1));
                                  },
                                  onDismissed: () {
                                    _con.removeFromCart(_con.carts.elementAt(index-1));
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      margin: EdgeInsets.only(bottom: 0),

                      height: 0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, 2), blurRadius: 5.0)]),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        onSubmitted: (String value) {
                          _con.doApplyCoupon(value);
                        },
                        cursorColor: Theme.of(context).accentColor,
                        controller: TextEditingController()..text = coupon?.code ?? '',
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          suffixText: coupon?.valid == null ? '' : (coupon.valid ? S.of(context).validCouponCode : S.of(context).invalidCouponCode),
                          suffixStyle: Theme.of(context).textTheme.caption.merge(TextStyle(color: _con.getCouponIconColor())),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Icons.confirmation_number_outlined,
                              color: _con.getCouponIconColor(),
                              size: 28,
                            ),
                          ),
                          hintText: S.of(context).haveCouponCode,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
