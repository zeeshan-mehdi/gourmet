import 'package:flutter/material.dart';
import 'package:markets/src/models/market.dart';
import 'package:markets/src/pages/product.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:markets/generated/l10n.dart';
import '../controllers/search_controller.dart';
import '../elements/CardWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../models/route_argument.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class SearchResultWidget extends StatefulWidget {
  final String heroTag;
  int searchTag;

  SearchResultWidget({Key key, this.heroTag,this.searchTag}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
  SearchController _con;

  _SearchResultWidgetState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.searchTag == 1
          ? Color(0xFF878A92)
          : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.of(context).pushNamed('/Pages', arguments: 0);

                  // Navigator.pop(context);
                },
              ),
              // title: Text(
              //   S.of(context).search,
              //   style: Theme.of(context).textTheme.headline4,
              // ),
              // subtitle: Text(
              //   S.of(context).ordered_by_nearby_first,
              //   style: Theme.of(context).textTheme.caption,
              // ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).focusColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(40)),
                child: TextField(
                  onChanged: (txt){
                    widget.searchTag = 0;
                  },

                  onSubmitted: (text) async {
                    await _con.refreshSearch(text);
                    widget.searchTag = 0;
                    _con.saveSearch(text);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                          fontSize: 16,
                          color: Colors.grey.withOpacity(0.8)),
                    ),
                    prefixIcon:
                    Icon(Icons.search, color: Colors.grey.withOpacity(0.8)),
                    border: InputBorder.none,
                    // border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                    // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                    // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),
              )
          ),
          // Container(
          //   height: 500,
          //
          //   color: Color(0xFF878A92),
          //   child: Column(
          //     children: [
          //       Spacer(),
          //       InkWell(
          //         child: Text("Scan the OR code",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.black),),
          //         onTap:() async {
          //           //  Navigator.of(context).pushReplacementNamed('/qr_code');
          //            String cameraScanResult = await scanner.scan();
          //            print(cameraScanResult);
          //            Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: cameraScanResult, heroTag: 'menu_tab'));
          //
          //           //
          //         },
          //       ),
          //       SizedBox(height: 10,),
          //       Text("Use image Library",style: TextStyle(fontSize: 20,color: Colors.orangeAccent),),
          //       SizedBox(height: 30,),
          //     ],
          //   ),
          // ),
          _con.markets.isEmpty && _con.products.isEmpty
              ? Container(
            height: 500,
            width: 375,
            color: Color(0xFF878A92),
            child: Column(
              children: [
                Spacer(),
                InkWell(
                  child: Text("Scan the OR code",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.black),),
                  onTap:() async {
                    //  Navigator.of(context).pushReplacementNamed('/qr_code');
                    String cameraScanResult = await scanner.scan();
                    print(cameraScanResult);
                    Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: cameraScanResult, heroTag: 'menu_tab'));

                    //
                  },
                ),
                SizedBox(height: 10,),
                Text("Use image Library",style: TextStyle(fontSize: 20,color: Colors.orangeAccent),),
                SizedBox(height: 30,),
                // Text(
                //   "Use image Library",
                //   style:
                //   TextStyle(fontSize: 20, color: Colors.orangeAccent),
                // ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          )
              : Expanded(
            child: ListView(
              children: <Widget>[
                widget.searchTag == 1? SizedBox() : Row(
                  children: [
          Padding(
          padding: const EdgeInsets.only(right: 0, left: 12),
          child:ElevatedButton(
                      style:  ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                          // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
                      child: const Text('Cuisines'),
                      onPressed:(){
                        Navigator.of(context).pushNamed('/Coisines');
                      },
                    ),),
                    Spacer(),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12, left: 0),
                          child: Icon(Icons.sort, color: Colors.grey),
                        ),
                        onTap:()  {
                          print("hello");
                          //  Navigator.of(context).pushNamed('/Coisines');
                          Navigator.of(context).pushNamed('/FilterPage');
                        }
                    ),
                  ],
                ),
                widget.searchTag == 1? SizedBox(): Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    title: Text(
                      S.of(context).products_results,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                widget.searchTag == 1? SizedBox(): ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _con.products.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return ProductItemWidget(
                      heroTag: 'search_list',
                      product: _con.products.elementAt(index),
                    );
                  },
                ),
                widget.searchTag == 1? SizedBox(): Padding(
                  padding:
                  const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    title: Text(
                      S.of(context).markets_results,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                widget.searchTag == 1? Container(
                  height: 500,
                  color: Color(0xFF878A92),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Row(
                      //     children: [
                      //       ElevatedButton(
                      //         style:  ButtonStyle(
                      //             backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                      //             // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      //             textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
                      //         child: const Text('Cuisines'),
                      //         onPressed:(){},
                      //       ),
                      //       Spacer(),
                      //     ],
                      //   ),
                      //
                      // ),
                      Spacer(),
                            InkWell(
                              child: Text("Scan the OR code",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.black),),
                              onTap:() async {
                                //  Navigator.of(context).pushReplacementNamed('/qr_code');
                                 String cameraScanResult = await scanner.scan();
                                 print(cameraScanResult);
                                 Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: cameraScanResult, heroTag: 'menu_tab'));

                                //
                              },
                            ),
                            SizedBox(height: 10,),
                            Text("Use image Library",style: TextStyle(fontSize: 20,color: Colors.orangeAccent),),
                            SizedBox(height: 30,),
                      // InkWell(
                      //   child: Text(
                      //     "Scan the QR code",
                      //     style: TextStyle(
                      //         fontSize: 24,
                      //         fontWeight: FontWeight.w800,
                      //         color: Theme.of(context).accentColor),
                      //   ),
                      //   onTap: () async {
                      //     //  Navigator.of(context).pushReplacementNamed('/qr_code');
                      //     String cameraScanResult = await scanner.scan();
                      //     print(cameraScanResult);
                      //     Navigator.of(context).pushNamed('/Pages',
                      //         arguments: RouteArgument(
                      //             id: '4',
                      //             param: cameraScanResult,
                      //             heroTag: 'menu_tab'));
                      //
                      //     //
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   "Use image Library",
                      //   style:
                      //   TextStyle(fontSize: 20, color: Colors.orangeAccent),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),
                ): ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _con.markets.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductWidget(routeArgument: RouteArgument(param: _con.markets.elementAt(index).id),)));

                        // Navigator.of(context).pushNamed('/roduct',
                        //     arguments: RouteArgument(
                        //       id: '0',
                        //       param: _con.markets.elementAt(index).id,
                        //       heroTag: widget.heroTag,
                        //     ));
                      },
                      child: CardWidget(
                          market: _con.markets.elementAt(index),
                          heroTag: widget.heroTag),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class SearchResultByFitlerWidget extends StatefulWidget {
   String heroTag;
   List<Market> filterMarket;
   SearchResultByFitlerWidget({ this.heroTag,this.filterMarket}) ;

  @override
  _SearchResultByFitlerWidgetState createState() => _SearchResultByFitlerWidgetState(filterMarket: filterMarket);
}

class _SearchResultByFitlerWidgetState extends StateMVC<SearchResultByFitlerWidget> {
  List<Market> filterMarket;
  //SearchController _con;
  _SearchResultByFitlerWidgetState({this.filterMarket});
  // _SearchResultByFitlerWidgetState() : super(SearchController()) {
  //   _con = controller;
  // }

  @override
  void initState() {
    super.initState();
    //_con.markets = filterMarket;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: filterMarket.isEmpty
          ? Color(0xFF878A92)
          : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.of(context).pushNamed('/Pages', arguments: 0);

                  // Navigator.pop(context);
                },
              ),
              // leading: IconButton(
              //   icon: Icon(Icons.sort),
              //   color: Theme.of(context).hintColor,
              //   onPressed: () async {
              //   //  Navigator.of(context).pushNamed('/Pages', arguments: 0);
              //     String cameraScanResult = await scanner.scan();
              //     print(cameraScanResult);
              //     Navigator.of(context).pushNamed('/Pages',
              //         arguments: RouteArgument(
              //             id: '4',
              //             param: cameraScanResult,
              //             heroTag: 'menu_tab'));
              //     // Navigator.pop(context);
              //   },
              // ),

              // title: Text(
              //   S.of(context).search,
              //   style: Theme.of(context).textTheme.headline4,
              // ),
              // subtitle: Text(
              //   S.of(context).ordered_by_nearby_first,
              //   style: Theme.of(context).textTheme.caption,
              // ),
            ),
          ),
          // Padding(
          //     padding: const EdgeInsets.all(12),
          //     child: Container(
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           border: Border.all(
          //             color: Theme.of(context).focusColor.withOpacity(0.2),
          //           ),
          //           borderRadius: BorderRadius.circular(40)),
          //       child: TextField(
          //         onSubmitted: (text) async {
          //           await _con.refreshSearch(text);
          //           _con.saveSearch(text);
          //         },
          //         autofocus: true,
          //         decoration: InputDecoration(
          //           contentPadding: EdgeInsets.all(12),
          //           hintText: "Search",
          //           hintStyle: Theme.of(context).textTheme.caption.merge(
          //             TextStyle(
          //                 fontSize: 16,
          //                 color: Colors.grey.withOpacity(0.8)),
          //           ),
          //           prefixIcon:
          //           Icon(Icons.search, color: Colors.grey.withOpacity(0.8)),
          //           border: InputBorder.none,
          //           // border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
          //           // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
          //           // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
          //         ),
          //       ),
          //     )),
          // Container(
          //   height: 500,
          //
          //   color: Color(0xFF878A92),
          //   child: Column(
          //     children: [
          //       Spacer(),
          //       InkWell(
          //         child: Text("Scan the QR code",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.black),),
          //         onTap:() async {
          //           //  Navigator.of(context).pushReplacementNamed('/qr_code');
          //            String cameraScanResult = await scanner.scan();
          //            print(cameraScanResult);
          //            Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: cameraScanResult, heroTag: 'menu_tab'));
          //
          //           //
          //         },
          //       ),
          //       SizedBox(height: 10,),
          //       Text("Use image Library",style: TextStyle(fontSize: 20,color: Colors.orangeAccent),),
          //       SizedBox(height: 30,),
          //     ],
          //   ),
          // ),
          filterMarket.isEmpty
              ? Container(
            height: 500,
            color: Color(0xFF878A92),
            child: Column(
              children: [
                Spacer(),
                InkWell(
                  child: Text(
                    "No data Found",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  onTap: () async {
                    //  Navigator.of(context).pushReplacementNamed('/qr_code');
                    // String cameraScanResult = await scanner.scan();
                    // print(cameraScanResult);
                    // Navigator.of(context).pushNamed('/Details',
                    //     arguments: RouteArgument(
                    //         id: '0',
                    //         param: cameraScanResult,
                    //         heroTag: 'menu_tab'));

                    //
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   "Use image Library",
                //   style:
                //   TextStyle(fontSize: 20, color: Colors.orangeAccent),
                // ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
              : Expanded(
            child: ListView(
              children: <Widget>[
                // Row(
                //   children: [
                //     Spacer(),
                //     InkWell(
                //         child: Padding(
                //           padding: const EdgeInsets.only(right: 12, left: 0),
                //           child: Icon(Icons.sort, color: Colors.grey),
                //         ),
                //         onTap:()  {
                //           print("hello");
                //           //  Navigator.of(context).pushNamed('/Coisines');
                //           Navigator.of(context).pushNamed('/FilterPage');
                //         }
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, right: 20),
                //   child: ListTile(
                //     dense: true,
                //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                //     title: Text(
                //       S.of(context).products_results,
                //       style: Theme.of(context).textTheme.subtitle1,
                //     ),
                //   ),
                // ),
                // ListView.separated(
                //   scrollDirection: Axis.vertical,
                //   shrinkWrap: true,
                //   primary: false,
                //   itemCount: _con.products.length,
                //   separatorBuilder: (context, index) {
                //     return SizedBox(height: 10);
                //   },
                //   itemBuilder: (context, index) {
                //     return ProductItemWidget(
                //       heroTag: 'search_list',
                //       product: _con.products.elementAt(index),
                //     );
                //   },
                // ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    title: Text(
                      S.of(context).markets_results,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: filterMarket.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Details',
                            arguments: RouteArgument(
                              id: '0',
                              param: filterMarket.elementAt(index).id,
                              heroTag: widget.heroTag,
                            ));
                      },
                      child: CardWidget(
                          market: filterMarket.elementAt(index),
                          heroTag: widget.heroTag),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
