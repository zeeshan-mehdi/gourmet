import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/favorite_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/FavoriteGridItemWidget.dart';
import '../elements/FavoriteListItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends StateMVC<FavoritesWidget> {
  String layout = 'list';

  FavoriteController _con;

  _FavoritesWidgetState() : super(FavoriteController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        // leading: new IconButton(
        //   icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Favourite ",
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3,color: Colors.black)),
        ),
        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Scaffold(
        body: SafeArea(
          child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                Container(
            //  color: Colors.black,
                height: 42,
                decoration  : BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                 //   border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),

              ),
                child:
                ButtonsTabBar(
                    backgroundColor: Colors.orangeAccent,
                    unselectedBackgroundColor: Colors.white,
                    labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5), fontWeight: FontWeight.bold),
                    borderWidth: 0,
                    unselectedBorderColor: Colors.orangeAccent,
                    radius: 100,
                    contentPadding: EdgeInsets.symmetric(horizontal: 40),
                    tabs: [
                      Tab(
                        //icon: Icon(Icons.directions_car),

                        text: "${ S.of(context).places}",
                      ),
                      Tab(
                        //  icon: Icon(Icons.directions_transit),
                        text: "${ S.of(context).food}",
                      ),
                    ],
                  ),),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        currentUser.value.apiToken == null
                            ? PermissionDeniedWidget()
                            : RefreshIndicator(
                          onRefresh: _con.refreshFavorites,
                          child:
                          SingleChildScrollView(

                            padding: EdgeInsets.symmetric(vertical: 10),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                                //   child: SearchBarWidget(onClickFilter: (e) {
                                //     Scaffold.of(context).openEndDrawer();
                                //   }),
                                // ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                                    // leading: Icon(
                                    //   Icons.favorite_outline,
                                    //   color: Theme.of(context).hintColor,
                                    // ),
                                    // title: Text(
                                    //   S.of(context).favorite_products,
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: Theme.of(context).textTheme.headline4,
                                    // ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              this.layout = 'list';
                                            });
                                          },
                                          icon: Icon(
                                            Icons.format_list_bulleted,
                                            color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              this.layout = 'grid';
                                            });
                                          },
                                          icon: Icon(
                                            Icons.apps,
                                            color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                _con.favoritesKitchen.isEmpty
                                    ? Center(
                                  child: Text("There is no favorite items"),
                                )

                                    : Offstage(
                                  offstage: this.layout != 'list',
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: _con.favoritesKitchen.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 10);
                                    },
                                    itemBuilder: (context, index) {
                                      return FavoriteKitchenListItemWidget(
                                        heroTag: 'favorites_list',
                                        favorite: _con.favoritesKitchen.elementAt(index),
                                      );
                                    },
                                  ),
                                ),
                                _con.favoritesKitchen.isEmpty
                                    ? CircularLoadingWidget(height: 500)
                                    : Offstage(
                                  offstage: this.layout != 'grid',
                                  child:   GridView.count(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    // Create a grid with 2 columns. If you change the scrollDirection to
                                    // horizontal, this produces 2 rows.
                                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                                    // Generate 100 widgets that display their index in the List.
                                    children: List.generate(_con.favoritesKitchen.length, (index) {
                                      return FavoriteGridItemWidget(
                                        heroTag: 'favorites_grid',
                                        favorite: _con.favoritesKitchen.elementAt(index),
                                        controller: _con,
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),


                        currentUser.value.apiToken == null
                            ? PermissionDeniedWidget()
                            : RefreshIndicator(
                          onRefresh: _con.refreshFavorites,
                          child:
                          SingleChildScrollView(

                            padding: EdgeInsets.symmetric(vertical: 10),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                                //   child: SearchBarWidget(onClickFilter: (e) {
                                //     Scaffold.of(context).openEndDrawer();
                                //   }),
                                // ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                                    // leading: Icon(
                                    //   Icons.favorite_outline,
                                    //   color: Theme.of(context).hintColor,
                                    // ),
                                    // title: Text(
                                    //   S.of(context).favorite_products,
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: Theme.of(context).textTheme.headline4,
                                    // ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              this.layout = 'list';
                                            });
                                          },
                                          icon: Icon(
                                            Icons.format_list_bulleted,
                                            color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              this.layout = 'grid';
                                            });
                                          },
                                          icon: Icon(
                                            Icons.apps,
                                            color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                _con.favorites.isEmpty
                                    ? Center(
                                  child: Text("There is no favourtie items"),
                                )

                                    : Offstage(
                                  offstage: this.layout != 'list',
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: _con.favorites.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 10);
                                    },
                                    itemBuilder: (context, index) {
                                      return FavoriteListItemWidget(
                                        heroTag: 'favorites_list',
                                        favorite: _con.favorites.elementAt(index),
                                      );
                                    },
                                  ),
                                ),
                                _con.favorites.isEmpty
                                    ? CircularLoadingWidget(height: 500)
                                    : Offstage(
                                  offstage: this.layout != 'grid',
                                  child:   GridView.count(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    // Create a grid with 2 columns. If you change the scrollDirection to
                                    // horizontal, this produces 2 rows.
                                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                                    // Generate 100 widgets that display their index in the List.
                                    children: List.generate(_con.favorites.length, (index) {
                                      return FavoriteProductGridItemWidget(
                                        heroTag: 'favorites_grid',
                                        favorite: _con.favorites.elementAt(index),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // _con.favoritesKitchen.isEmpty
                        //     ? CircularLoadingWidget(height: 500)
                        //     : Offstage(
                        //   offstage: this.layout != 'grid',
                        //   child:   GridView.count(
                        //     scrollDirection: Axis.vertical,
                        //     shrinkWrap: true,
                        //     primary: false,
                        //     crossAxisSpacing: 10,
                        //     mainAxisSpacing: 20,
                        //     padding: EdgeInsets.symmetric(horizontal: 20),
                        //     // Create a grid with 2 columns. If you change the scrollDirection to
                        //     // horizontal, this produces 2 rows.
                        //     crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                        //     // Generate 100 widgets that display their index in the List.
                        //     children: List.generate(_con.favoritesKitchen.length, (index) {
                        //       return FavoriteGridItemWidget(
                        //         heroTag: 'favorites_grid',
                        //         favorite: _con.favoritesKitchen.elementAt(index),
                        //       );
                        //     }),
                        //   ),
                        // )


                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
       // )
     // )

    );
  }
}
