import 'package:flutter/material.dart';
import 'package:markets/driver_app/src/controllers/map_controller.dart';
import 'package:markets/src/controllers/search_controller.dart';
import 'package:markets/src/elements/SearchResultsWidget.dart';
import 'package:markets/src/elements/SearchWidget.dart';
import 'package:markets/src/models/market.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/user_repository.dart' as userRepo;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/maps_util.dart';
import '../models/address.dart';
import '../models/coupon.dart';
import '../models/setting.dart';
import 'package:markets/generated/l10n.dart';
import '../elements/CardWidget.dart';
import 'MultiSelectListView.dart';

class Animal {
  final int id;
  final String name;
  final String searchName;

  Animal({
    this.id,
    this.name,
    this.searchName
  });
}

class FilterPage extends StatefulWidget {
  FilterPage({Key key, this.title}) : super(key: key);
  final String title;
  static List<String> sortValues =  List<String>();
  static List<String> filterValues =  List<String>();
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends StateMVC<FilterPage> {
  // Animal(id: 1, name: "Desert"),
  // Animal(id: 2, name: "Asian"),
  // Animal(id: 3, name: "Arabic"),
  // Animal(id: 4, name: "Pizza"),
  // Animal(id: 5, name: "Kuwaiti"),
  // Animal(id: 6, name: "Fast Food"),
  // Animal(id: 7, name: "European"),

   List<Animal> _animals;


  //List<Animal> _selectedAnimals = [];
  List<Animal> selectedCuisine = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  SearchController _con;
  _FilterPageState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }
  double _starValue = 0;
  double _endValue = 40;

  @override
  Widget build(BuildContext context) {
   _animals = [
    Animal(id: 1, name: "${S.of(context).desert}",searchName: "desert"),
    Animal(id: 2, name: "${S.of(context).asian}",searchName: "Asian"),
    Animal(id: 3, name: "${S.of(context).arabic}",searchName: "aArabic"),
    Animal(id: 4, name:"${S.of(context).pizza}",searchName: "Pizza"),
    Animal(id: 5, name: "${S.of(context).kuwaiti}",searchName: "Kuwaiti"),
    Animal(id: 6, name: "${S.of(context).fast_food}",searchName: "Fast Food"),
    Animal(id: 7, name: "${S.of(context).european}",searchName: "European"),
    // Animal(id: 4, name: "Pizza"),
    // Animal(id: 5, name: "East Asian"),
    // Animal(id: 6, name: "Caribbean"),
    // Animal(id: 7, name: "German"),
    // Animal(id: 8, name: "Desert"),
    ];
   var _items = _animals
       .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
       .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${S.of(context).filter}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orange)),
        automaticallyImplyLeading: false,
        leading:
        InkWell(
          child:Container(
            //color: Colors.black,
            margin: EdgeInsets.only(top: 0, left: 0,right: 0),
            child:  IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 20,
                onPressed: () {
                  Navigator.of(context).pop();
                //  _onLike(currentLikes);
                }),
            //Text("${S.of(context).back}",style: TextStyle(fontSize: 15,color: Colors.orange)),
          ),
          onTap: () {

          },
        ),
        actions: <Widget>[
          InkWell(
            child:  Container(
              //color: Colors.black,
              margin: EdgeInsets.only(top: 18, right: 8,left: 8),
              child:  Text("${S.of(context).done}",style: TextStyle(fontSize: 17,color: Colors.orange)),
            ),
            onTap: () async {
              print("Filtered items is");
              print(FilterPage.sortValues);
              print(FilterPage.filterValues);
              print(_con.markets.map((e) => e.rate));

              List<Market> filterItems = List<Market>();

              // print(_con.markets.map((element) => element.cuisine));
              // print(selectedCuisine.map((e) => e.name));

              if (selectedCuisine.length != 0){
                // print("hello");
                // print("selected cuisine $selectedCuisine");
                // print(_con.markets.map((e) => e.cuisine));
                // print(_con.markets.where((element) => element.cuisine == selectedCuisine.map((e) => e.name).last));
                //Market mark = _con.markets.firstWhere((element) =>
               //  element == selectedCuisine.map((e) => e.name),orElse: () {
               //    return null;
               //  });
               // / print(mark.name);
               //  print(mark.id);
                filterItems.addAll(_con.markets.where((element) {
                      print(element.cuisine.trim().toLowerCase());
                      print(selectedCuisine.last.name.trim().toLowerCase());
                      print(selectedCuisine.last.id);
                     return selectedCuisine.where((e) => e.searchName.trim().toLowerCase()==element.cuisine.trim().toLowerCase()).length>0?true:false;

                    }));

                print('cusine result');

                print(filterItems);

              }else{}
              if(FilterPage.sortValues.length != 0){
                if (FilterPage.sortValues.firstWhere((element) =>
                element == "Top Rated",orElse: () {
                  return null;
                }) == "Top Rated"){
                  print(_con.markets.map((e) => e.rate));
                  print("sort Value is Top Rated");
                  filterItems = _con.markets;
                }else{}

                if (FilterPage.sortValues.firstWhere((element) =>
                element == "Nearest",orElse: () {
                  return null;
                }) == "Nearest"){
                  // print(_con.markets.map((e) => e.distance));
                  // filterItems.addAll(_con.markets.where((element) => element.distance >= 0.0));
                  // print("sort Value Nearest");
                }else{}

                if (FilterPage.sortValues.firstWhere((element) =>
                element == "Cost High to Low",orElse: () {
                  return null;
                }) == "Cost High to Low"){
                 // User _user =
                 // print(userRepo.currentUser.value.address);
                  print(_con.markets.map((e) => e.longitude));

                  Address aa = await _con.getCurrentLocation();
                  print( aa.address);
                  // print( aa.then((value) => value.latitude));
                  // print( aa.then((value) => value.latitude));
                 print(_con.markets.map((e) => e.latitude));
                  print("sort Value Cost High to Low");
                }else{}

                if (FilterPage.sortValues.firstWhere((element) =>
                element == "Most Popular",orElse: () {
                  return null;
                }) == "Most Popular"){
                  filterItems = _con.markets;
                  print("sort Value Most Popular");
                }else{}
                print("sort result is");
                var elements = filterItems.where((element) => element.cuisine == selectedCuisine.map((e) => e.name));
                filterItems.addAll(elements);
              }else {}
              if(FilterPage.filterValues.length != 0){
                if (FilterPage.filterValues.firstWhere((element) =>
                element == "Order Taking",orElse: () {
                  return null;
                }) == "Order Taking"){
                  print("filter value is Order Taking");
                 // print(_con.markets.map((element) => element.maximumOrdersPerDay));
                  var elements = filterItems.where((element) => element.maximumOrdersPerDay > 0);

                //  print('element adding $elements');


                 // print('filtered items $filterItems');

                  filterItems= [...filterItems,...elements];


                }else{}

                if (FilterPage.filterValues.firstWhere((element) =>
                element == "Same Day Delivery",orElse: () {
                  return null;
                }) == "Same Day Delivery"){
                  print("sort Value Same Day Delivery");
                  print(filterItems.map((element) => element.sameDayDelivery));
                  filterItems.addAll(filterItems.where((element) => element.sameDayDelivery == true));
                }else{}

                if (FilterPage.filterValues.firstWhere((element) =>
                element == "Vegetarian Food",orElse: () {
                  return null;
                }) == "Vegetarian Food"){
                  print(filterItems.where((element) => element.vegetarianFood ));
                  filterItems.addAll(filterItems.where((element) => element.vegetarianFood == true));
                  print("sort Value Vegetarian Food");
                }else{}
              }else{}

              print("Filtered items is ${filterItems.map((e) => e).toSet()}");
              var item =  filterItems.map((e) => e).toSet().toList();
              //var
             // Navigator.of(context).push(SearchResultByFitlerWidget(filterMarket: filterItems,heroTag: "search",));
              Navigator.of(context).push(SearchFilterModal(marketFilteredList: item));

               //Navigator.of(context).pu
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => SearchResultByFitlerWidget(filterMarket: filterItems,heroTag: "search",)));
             // Navigator.of(context).pushNamed('/Coisines');
              //  Navigator.of(context).pop();
            },
          ),
        ],


      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              // SizedBox(height: 40),
              MultiSelectChipField(
                scroll: false,
                //scrollBar: VerticalScrollBar(isAlwaysShown: true),
                items: _items,
                // initialValue: [_animals[4], _animals[7], _animals[6]],
                title: Text("${S.of(context).cuisines}"),

                headerColor: Colors.white.withOpacity(0.6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0),
                ),
                selectedChipColor: Colors.grey.withOpacity(0.2),
                selectedTextStyle: TextStyle(color: Colors.orangeAccent),
                onTap: (values) {
                  selectedCuisine = values;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("  ${S.of(context).sort}",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 20),),
                  Spacer()
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 150,
                width: 370,

                child: MultiSelectItemsWidget(mainList :[{"key":"${S.of(context).top_rated}","name":"Top Rated"},
                  {"key" :"${S.of(context).nearest}","name":"Nearest"},{"key" :"${S.of(context).most_popular}","name":"Most Popular"}], filterby: FilterType.sort,),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(" ${S.of(context).filter} ",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 20),),
                  Spacer()
                ],
              ),
              SizedBox(height: 12),

              Container(
                height: 120,
                width: 370,

                child: MultiSelectItemsWidget(mainList :[{"key":"${S.of(context).order_taking}","name":"Order Taking"},
                  {"key" :"${S.of(context).same_day_delivery}","name":"Same Day Delivery"},{"key": "${S.of(context).vegetarian_food}","name":"Vegetarian Food"}],filterby: FilterType.filter),

              ),
              SizedBox(height: 20),
              // Row(
              //   children: [
              //     Text("  Price",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 20),),
              //     Spacer()
              //   ],
              // ),
              SizedBox(height: 20,),
              // Row(
              //   children: [
              //     SizedBox(width: 10,),
              //     Text("KD $_starValue",style: TextStyle(color: Colors.grey,fontSize: 20),),
              //     SizedBox(width: 40,),
              //     Text("KD  $_endValue",style: TextStyle(color: Colors.grey,fontSize: 20),),
              //   ],
              // ),
              // SliderTheme(
              //   data: SliderThemeData(
              //     trackHeight: 7,
              //   ),
              //   child:
              //   RangeSlider(
              //
              //     values: RangeValues(_starValue, _endValue),
              //     inactiveColor: Colors.grey.withOpacity(0.25),
              //     //divisions : 8,
              //     activeColor: Colors.orange,
              //     min: 0.0,
              //     max: 100.0,
              //     onChanged: (values){
              //       setState(() {
              //         _starValue = values.start.roundToDouble();
              //         _endValue = values.end.roundToDouble();
              //         print(_starValue);
              //         print(_endValue);
              //       });
              //     },
              //   ),),

              // RangeSlider(
              //     values: RangeValues(0.0,40.0),
              //     min: 0,
              //     max: 100,
              //     onChanged: (RangeValues values) {
              //       setState(() {
              //         if (values.end - values.start >= 20) {
              //           values = values;
              //         } else {
              //           if (values.start == values.start) {
              //             values = RangeValues(values.start, values.start + 20);
              //           } else {
              //             values = RangeValues(values.end - 20, values.end);
              //           }
              //         }
              //       });
              //     }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
enum FilterType { filter, sort }
