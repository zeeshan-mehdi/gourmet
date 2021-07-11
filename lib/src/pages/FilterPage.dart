import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'MultiSelectListView.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

class FilterPage extends StatefulWidget {
  FilterPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "Asian"),
    Animal(id: 2, name: "Middle Eastren"),
    Animal(id: 3, name: "Chiness"),
    Animal(id: 4, name: "Desert"),
    Animal(id: 5, name: "East Asian"),
    Animal(id: 6, name: "Caribbean"),
    Animal(id: 7, name: "German"),
    Animal(id: 8, name: "Desert"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }
  double _starValue = 0;
  double _endValue = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        leading:
        InkWell(
          child:Container(
            margin: EdgeInsets.only(top: 18, left: 8),
            child:  Text("Reset",style: TextStyle(fontSize: 17,)),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[

          InkWell(
            child:  Container(
              margin: EdgeInsets.only(top: 18, right: 8),
              child:  Text("Done",style: TextStyle(fontSize: 17,color: Colors.orange)),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/Coisines');
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
                initialValue: [_animals[4], _animals[7], _animals[6]],
                title: Text("CUISINES"),
                headerColor: Colors.white.withOpacity(0.6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0),
                ),
                selectedChipColor: Colors.grey.withOpacity(0.2),
                selectedTextStyle: TextStyle(color: Colors.orangeAccent),
                onTap: (values) {
                  //_selectedAnimals4 = values;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("  Sort",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 20),),
                  Spacer()
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 150,
                width: 370,
                child: MultiSelectItemsWidget(mainList :[{"key":"Top Rated"},{"key" :"Nearest"},{"key": "Cost High to Low"},{"key" :"Most Popular"}]),

              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("  Filter",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 20),),
                  Spacer()
                ],
              ),
              SizedBox(height: 12),

              Container(
                height: 120,
                width: 370,
                child: MultiSelectItemsWidget(mainList :[{"key":"Order Taking"},{"key" :"Same Day Delivery"},{"key": "Vegetarian Food"},]),

              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("  Price",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 20),),
                  Spacer()
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text("KD $_starValue",style: TextStyle(color: Colors.grey,fontSize: 20),),
                  SizedBox(width: 40,),
                  Text("KD  $_endValue",style: TextStyle(color: Colors.grey,fontSize: 20),),
                ],
              ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 7,
            ),
          child:
          RangeSlider(

            values: RangeValues(_starValue, _endValue),
            inactiveColor: Colors.grey.withOpacity(0.25),
            //divisions : 8,
            activeColor: Colors.orange,
            min: 0.0,
            max: 100.0,
            onChanged: (values){
              setState(() {
                _starValue = values.start.roundToDouble();
                _endValue = values.end.roundToDouble();
                print(_starValue);
                print(_endValue);
              });
            },
          ),),

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