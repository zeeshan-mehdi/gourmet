import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/pages/restaurant_staff.dart';
import 'package:markets/restaurent_app/src/models/market.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import  'package:markets/generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../elements/StatisticsCarouselWidget.dart';
import 'package:markets/src/repository/settings_repository.dart' as settingsRepo;

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  Market market;

  OrdersWidget({Key key, this.parentScaffoldKey,this.market}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrders();
    _con.listenForStatistics();
    _con.listenForOrderStatus(insertAll: true);
    _con.selectedStatuses = ['0'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pushNamed('/Pages',arguments: 3),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: settingsRepo.setting,
          builder: (context, value, child) {
            return Text(
              value.appName ?? S.of(context).home,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3),),
            );
          },
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: ListView(
          children: [

            StatisticsCarouselWidget(statisticsList: _con.statistics),
            SizedBox(height: 5,),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Text('Restaurant Staff',style:Theme.of(context).textTheme.headline3,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black.withOpacity(0.7),))
                  ],
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantStaff(marketId: widget.market.id,)));
              },
            ),
            SizedBox(height: 5,),
            Stack(
              children: [
                _con.orderStatuses.isEmpty
                    ? SizedBox(height: 90)
                    : Container(
                        height: 90,
                        child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(_con.orderStatuses.length, (index) {
                            var _status = _con.orderStatuses.elementAt(index);
                            var _selected = _con.selectedStatuses.contains(_status.id);
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(start: 20),
                              child:
                              RawChip(
                                elevation: 0,
                                label: Text(_status.status),
                                labelStyle: _selected
                                    ? Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).primaryColor))
                                    : Theme.of(context).textTheme.bodyText2,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                backgroundColor: Theme.of(context).focusColor.withOpacity(0.1),
                                selectedColor: Theme.of(context).accentColor,
                                selected: _selected,
                                //shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.05))),
                                showCheckmark: false,
                                onSelected: (bool value) {
                                  setState(() {
                                    if (_status.id == '0') {
                                      _con.selectedStatuses = ['0'];
                                    } else {
                                      _con.selectedStatuses.removeWhere((element) => element == '0');
                                    }
                                    if (value) {
                                      _con.selectedStatuses.add(_status.id);
                                    } else {
                                      _con.selectedStatuses.removeWhere((element) => element == _status.id);
                                    }
                                    _con.selectStatus(_con.selectedStatuses);
                                  });
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                if (_con.orders.isEmpty)
                  EmptyOrdersWidget()
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.orders.length,
                      itemBuilder: (context, index) {
                        var _order = _con.orders.elementAt(index);
                        return OrderItemWidget(
                          expanded: index == 0 ? false : false,
                          order: _order,
                          onCanceled: (e) {
                            _con.doCancelOrder(_order);
                          },

                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
