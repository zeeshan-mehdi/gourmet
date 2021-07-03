import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markets/restaurent_app/src/pages/markets.dart';
import 'package:markets/src/pages/favorites.dart';
import 'package:markets/src/pages/kitchen_profile.dart';

import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
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
      currentTab = 1;
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

        // case 1:
        //   widget.currentPage = MapWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: widget.routeArgument);
        //   break;
        case 0:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage = FavoritesWidget();
          break;
        case 3:
          widget.currentPage = KitchenProfile(); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;

        case 4:
          widget.currentPage = MarketsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 22),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          selectedLabelStyle: TextStyle(color: Theme.of(context).accentColor),
          currentIndex: widget.currentTab==4 ? widget.currentTab-1 :  widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            // BottomNavigationBarItem(
            //   icon: Icon(widget.currentTab == 0 ? Icons.notifications : Icons.notifications_outlined),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Column(
                children: [
                  new Icon(FontAwesomeIcons.compass),
                  SizedBox(height: 2,),
                  Text('Explore',style:TextStyle(color: widget.currentTab ==0? Theme.of(context).accentColor : Colors.black.withOpacity(0.5),fontSize: 12 ) ,)
                ],
              ),
            ),

            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Transform(transform:Matrix4.rotationX(pi),alignment: Alignment.center,child: new Icon(FontAwesomeIcons.file)),
                  SizedBox(height: 2,),
                  Text('Orders',style:TextStyle(color: widget.currentTab ==1 ? Theme.of(context).accentColor : Colors.black.withOpacity(0.5),fontSize: 12 ) ,)


                ],
              ),
              label: 'Orders',
            ),


            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(FontAwesomeIcons.bookmark),
                  SizedBox(height: 2,),
                  Text('Favourite',style:TextStyle(color: widget.currentTab ==2 ? Theme.of(context).accentColor : Colors.black.withOpacity(0.5),fontSize: 12 ) ,)
                ],
              ),
              label: 'Favourite',
            ),


            BottomNavigationBarItem(
              icon: Column(
                children: [
                  new Icon(FontAwesomeIcons.addressBook),
                  SizedBox(height: 2,),
                  Text('Profile',style:TextStyle(color: widget.currentTab ==3 ? Theme.of(context).accentColor : Colors.black.withOpacity(0.5),fontSize: 12 ) ,)

                ],
              ),
              label: 'Profile',

            ),




          ],
        ),
      ),
    );
  }
}
