import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markets/restaurent_app/src/controllers/market_controller.dart';
import 'package:markets/restaurent_app/src/models/route_argument.dart';
import 'package:markets/restaurent_app/src/pages/details.dart';
import 'package:markets/restaurent_app/src/pages/open_new_kitchen.dart';
import 'package:markets/restaurent_app/src/pages/orders.dart' as restOrders;
import 'package:markets/restaurent_app/src/pages/settings.dart' as restSettings;
import 'package:markets/restaurent_app/src/pages/markets.dart';
import 'package:markets/src/pages/favorites.dart';
import 'package:markets/src/pages/kitchen_profile.dart';
import 'package:markets/src/pages/profile.dart';
import 'package:markets/src/pages/settings.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../helpers/helper.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/notifications.dart';
import '../pages/orders.dart';
import 'messages.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {


  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage = FavoritesWidget(); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage = KitchenProfile();
          break;
        case 4:
          widget.currentPage =
          widget.currentPage =  DetailsWidget(routeArgument: RouteArgument(param: null),);
          break;
        case 5:
          widget.currentPage = restOrders.OrdersWidget(parentScaffoldKey: widget.scaffoldKey,);
          break;

        case 6:
          widget.currentPage =  ProfileWidget();
          break;
        case 7:
          widget.currentPage =  SettingsWidget();
          break;

        case 8:
          widget.currentPage =  OpenNewKitchenPage();
          break;


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(mounted)
      _selectTab(widget.currentTab);
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 22),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab>=4? 3 : widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [

            BottomNavigationBarItem(
              label: '',
              icon: Column(
                children: [
                  new Icon(FontAwesomeIcons.compass),
                  SizedBox(height: 3,),
                  Text('Explore',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12,color: widget.currentTab==0? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(pi),child: new Icon(FontAwesomeIcons.file)),
                  SizedBox(height: 3,),
                  Text('Orders',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12,color: widget.currentTab==1? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(FontAwesomeIcons.bookmark),
                  SizedBox(height: 3,),
                  Text('Favorite',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12,color:widget.currentTab==2? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
                ],
              ),
              label: '',
            ),


            BottomNavigationBarItem(
              icon: Column(
                children: [
                  new Icon(FontAwesomeIcons.addressBook),
                  SizedBox(height: 3,),
                  Text('Profile',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12, color:widget.currentTab==3? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
                ],
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
