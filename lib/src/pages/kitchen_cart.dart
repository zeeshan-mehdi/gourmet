

import 'package:flutter/material.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/elements/CartBottomDetailsWidget.dart';
import 'package:markets/src/elements/CartItemWidget.dart';
import 'package:markets/src/elements/EmptyCartWidget.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/product.dart';
import 'package:markets/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';

class KitchenCartWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  final bool hideAppBar;

  final Function callback;
  final Function removeFromCart;

  KitchenCartWidget({Key key, this.routeArgument,this.hideAppBar = false,this.callback,this.removeFromCart}) : super(key: key);

  @override
  _KitchenCartWidgetState createState() => _KitchenCartWidgetState();
}

class _KitchenCartWidgetState extends StateMVC<KitchenCartWidget> {
  CartController _con;

  _KitchenCartWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCarts();
    widget?.callback(_con.listenForCarts);
    super.initState();
  }
  SelectedOrderItem items;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        // bottomNavigationBar: CartBottomDetailsWidget(con: _con),
        // appBar: widget.hideAppBar ? null : AppBar(
        //   automaticallyImplyLeading: false,
        //   leading: IconButton(
        //     onPressed: () {
        //       if (widget.routeArgument != null) {
        //         Navigator.of(context).pushReplacementNamed(widget.routeArgument.param, arguments: RouteArgument(id: widget.routeArgument.id));
        //       } else {
        //         Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
        //       }
        //     },
        //     icon: Icon(Icons.arrow_back),
        //     color: Theme.of(context).hintColor,
        //   ),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text(
        //     S.of(context).cart,
        //     style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        //   ),
        // ),
        body: RefreshIndicator(
          onRefresh: _con.refreshCarts,
          child: _con.carts.isEmpty
              ? Container(
              child: EmptyKitchenCartWidget())
              : Container(
                height: (_con.carts.length*150.0)+150,
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 15, bottom: 0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _con.carts.length+1,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 0);
                  },
                  itemBuilder: (context, index) {
                    if(index == _con.carts.length){
                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical:18.0),
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Cart',arguments: RouteArgument(param: _con.scaffoldKey));
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20),
                            child: Text(
                              'View Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                  Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      );
                    }
                    return KitchenCartItemWidget(
                      cart: _con.carts.elementAt(index),
                      heroTag: 'cart',
                      increment: () {
                        _con.incrementQuantity(_con.carts.elementAt(index));
                        widget.removeFromCart();
                      },
                      decrement: () {
                        _con.decrementQuantity(_con.carts.elementAt(index));
                        widget.removeFromCart();
                      },
                      onDismissed: () {
                        _con.removeFromCart(_con.carts.elementAt(index));
                        widget.removeFromCart();
                      },
                    );
                  },
                  //   ),
                  // ],
                ),
              ),
        ),
      ),
    );
  }
}