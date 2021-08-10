import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/src/controllers/market_controller.dart';
import 'package:markets/src/models/market.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/StaticScreens/staticGridMenuScreen.dart';
import 'package:markets/src/pages/StaticScreens/StaticHomeScreen.dart';
import 'package:markets/src/pages/StaticScreens/StaticmenuGridScreen.dart';
import 'package:markets/src/pages/StaticScreens/StaticTabMenuScreen.dart';
import 'package:markets/src/pages/menuGridScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KitchenSettingsPage extends StatefulWidget {
  String market;
  Market marketData;
  KitchenSettingsPage({this.market,this.marketData});
  @override
  _KitchenSettingsPageState createState() => _KitchenSettingsPageState();
}

class _KitchenSettingsPageState extends State<KitchenSettingsPage> {
  TextEditingController _myFatoorahController =
      TextEditingController(text: 'skdfjsdfkjsdf-sdlkfjsdflksjdf-sdf');
  SharedPreferences instance;
  String key = 'lksdjflkjsdflkjsdflkjsdflk-sldfkjsdlfkjsljsdflkjsdfsdflkjsdf';

  bool edit = false;
  MarketController marketController= MarketController();
  @override
  var styleID ;

  var loader= false;
  void initState() {
    // TODO: implement initState
    if(widget.marketData.design_type != null ) {
      styleID= widget.marketData.design_type ??0;
    }
    getKey();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          showModalBottomSheet(
              context: context,
              enableDrag: true,
              isScrollControlled: true,
              builder: (context) {
                return StatefulBuilder(
                    builder: (context, StateSetter setState) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    styleID = 1;
                                  });
                                },
                                title: Text('Card Menu'),
                                trailing:
                                    styleID == 1 ? Icon(Icons.check) : IconButton(icon: Icon(Icons.remove_red_eye_outlined), onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StaticHomeScreen(routeArgument: RouteArgument(param:
                                     widget.market
                                        ),
                                        )));

                                    }),

                                leading: Image.asset(
                                  'assets/1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    styleID = 2;
                                  });
                                },
                                title: Text('GridView Menu'),
                                trailing:
                                    styleID == 2 ? Icon(Icons.check) :  IconButton(icon: Icon(Icons.remove_red_eye_outlined), onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StaticMenuGridScreen(routeArgument: RouteArgument(param:
                                      widget.market
                                      ),
                                      )));
                      }),
                                leading: Image.asset(
                                  'assets/2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    styleID = 3;
                                  });
                                },
                                title: Text('Grid Menu 2'),
                                trailing:
                                    styleID == 3 ? Icon(Icons.check) :  IconButton(icon: Icon(Icons.remove_red_eye_outlined), onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StaticGridScreen(routeArgument: RouteArgument(param:
                                      widget.market
                                      ),
                                      )));
                      }),
                                leading: Image.asset(
                                  'assets/3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    styleID = 4;
                                  });
                                },
                                title: Text('ListTile Menu'),
                                trailing:
                                    styleID == 4 ? Icon(Icons.check) :  IconButton(icon: Icon(Icons.remove_red_eye_outlined), onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StaticTabsMenuScreen(routeArgument: RouteArgument(param:
                                      widget.market
                                      ),
                                      )));
                      }),
                                leading: Image.asset(
                                  'assets/4.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                       loader? CircularProgressIndicator(backgroundColor: Colors.orange,):   FlatButton(
                              color: Colors.orange,
                              onPressed: () {
                                setState((){
                                  loader= true;
                                });

                                print(styleID.toString());
                                widget.marketData.design_type= styleID;
                                marketController.
                                listenForMarketDesign(market: widget.marketData,context: context);


                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  );
                });
              }).whenComplete(() {
            //do whatever you want after closing the bottom sheet
          });
        },
        // icon: Icon(Icons.save),
        label: Row(
          children: [
            Text('Change Style' ?? "Empty cart"),

            // Text(_productController.quantity.toString() != '0.0' ?_productController.quantity.round().toString() : 'Empty Cart' ?? "Empty cart"),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 2 - 40,
        margin: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kitchen Settings',
                  style: Theme.of(context).textTheme.headline4,
                ),

                SizedBox(
                  height: 10,
                ),

                Text('My Fatoorah Api Key'),
                SizedBox(
                  height: 10,
                ),

                // TextField(
                //
                //   controller: _myFatoorahController,
                // ),
                edit ? Container() : Text('$key'),

                edit
                    ? TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter New Api Key',
                            border: UnderlineInputBorder(),
                            fillColor: Theme.of(context).accentColor,
                            focusColor: Theme.of(context).accentColor),
                        controller: _myFatoorahController,
                      )
                    : Container(),

                SizedBox(
                  height: 100,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      if (!edit) {
                        setState(() {
                          edit = true;
                        });
                      } else {
                        edit = false;
                        saveKey();
                      }
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: edit ? Colors.green : Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        !edit ? 'Edit' : 'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveKey() async {
    if (instance == null) instance = await SharedPreferences.getInstance();

    if (_myFatoorahController.text != null &&
        _myFatoorahController.text != "") {
      instance.setString('key', _myFatoorahController.text);
      key = _myFatoorahController.text;
      setState(() {
        Fluttertoast.showToast(msg: 'My Fatoorah Api Key Updated');
      });
    }
  }

  void getKey() async {
    if (instance == null) instance = await SharedPreferences.getInstance();

    key = instance.get('key');
  }
}
