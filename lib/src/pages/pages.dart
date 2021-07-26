import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markets/driver_app/src/pages/map.dart';
import 'package:markets/driver_app/src/pages/orders.dart';
import 'package:markets/driver_app/src/pages/orders_history.dart';
import 'package:markets/driver_app/src/pages/profile.dart';
import 'package:markets/restaurent_app/src/controllers/market_controller.dart';
import 'package:markets/restaurent_app/src/models/route_argument.dart';
import 'package:markets/restaurent_app/src/pages/details.dart';
import 'package:markets/restaurent_app/src/pages/new_product.dart';
import 'package:markets/restaurent_app/src/pages/open_new_kitchen.dart';
import 'package:markets/restaurent_app/src/pages/orders.dart' as restOrders;
import 'package:markets/restaurent_app/src/pages/product.dart';
import 'package:markets/restaurent_app/src/pages/settings.dart' as restSettings;
import 'package:markets/restaurent_app/src/pages/markets.dart';
import 'package:markets/src/pages/MemberShip.dart';
import 'package:markets/src/pages/delivery_addresses.dart';
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


enum NavPages {
  Home,
  MyOrders,
  Favorites,
  Profile,
  RestaurantManagement,
  RestaurantOrders,
  MyAccount,
  MySettings,
  BecomeKitchen,
  AddProduct,
  RestaurantMembership,
  MyAddresses,  DriverProfile,DriverOrders,OrderHistory,DriverMap
}


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

        int index= int.parse(currentTab.id);

        currentTab =  NavPages.values.elementAt(index);
      }
    } else {
      currentTab = NavPages.Home;
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

  void _selectTab(tabItem) {

    if(tabItem is int){
      tabItem = NavPages.values.elementAt(tabItem);
    }


    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case NavPages.Home:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case NavPages.MyOrders:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case NavPages.Favorites:
          widget.currentPage = FavoritesWidget(); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case NavPages.Profile:
          widget.currentPage = KitchenProfile();
          break;
        case NavPages.RestaurantManagement:
          widget.currentPage = ProductWidget(routeArgument: widget.routeArgument,);
          //widget.currentPage =  DetailsWidget(routeArgument: RouteArgument(param: null),);
          break;
        case NavPages.RestaurantOrders:
          widget.currentPage = restOrders.OrdersWidget(parentScaffoldKey: widget.scaffoldKey,);
          break;

        case NavPages.MyAccount:
          widget.currentPage =  ProfileWidget();
          break;
        case NavPages.MySettings:
          widget.currentPage =  SettingsWidget();
          break;

        case NavPages.BecomeKitchen:
          widget.currentPage =  OpenNewKitchenPage();
          break;

        case NavPages.AddProduct:
          widget.currentPage =  NewProductPage();
          break;

        case NavPages.RestaurantMembership:
          widget.currentPage = RestaurantsMemberShip();
          break;
        case NavPages.MyAddresses :
          widget.currentPage = DeliveryAddressesWidget();
          break;
        case NavPages.DriverProfile:
          widget.currentPage = DriverProfileWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case NavPages.DriverOrders:
          widget.currentPage = DriverOrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case NavPages.OrderHistory:
          widget.currentPage = OrdersHistoryWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case NavPages.DriverMap:
          widget.currentPage = DriverMapWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: widget.routeArgument);
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
          currentIndex: NavPages.values.indexOf( widget.currentTab)>=4? 3 : NavPages.values.indexOf( widget.currentTab),
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
                  Text('Explore',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12,color: widget.currentTab==NavPages.Home? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
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
                  Text('Orders',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12,color: widget.currentTab==NavPages.MyOrders? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(FontAwesomeIcons.bookmark),
                  SizedBox(height: 3,),
                  Text('Favorite',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12,color:widget.currentTab==NavPages.Favorites? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
                ],
              ),
              label: '',
            ),


            BottomNavigationBarItem(
              icon: Column(
                children: [
                  new Icon(FontAwesomeIcons.addressBook),
                  SizedBox(height: 3,),
                  Text('Profile',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12, color:widget.currentTab==NavPages.Profile? Theme.of(context).accentColor:Colors.black.withOpacity(0.5) ),),
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
