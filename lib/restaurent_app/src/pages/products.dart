import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/controllers/product_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import  'package:markets/generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CardWidget.dart';
import '../elements/EmptyMarketsWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/route_argument.dart';
import 'new_product.dart';
import 'open_new_kitchen.dart';

class ProductsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProductsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ProductsWidgetState createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends StateMVC<ProductsWidget> {
  ProductController _con;

  _ProductsWidgetState() : super(ProductController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).products,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshProducts,
        child: _con.products.isEmpty
            ? EmptyProductsWidget()
            : ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: _con.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed('/Details',
                      //     arguments: RouteArgument(
                      //       id: _con.markets.elementAt(index).id,
                      //       heroTag: 'my_markets',
                      //     ));
                    },
                    child: CardWidgetProduct(product: _con.products.elementAt(index), heroTag: 'my_products'),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () async{
        await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewProductPage()));
        _con.refreshProducts();
      },

      ),
    );
  }
}
