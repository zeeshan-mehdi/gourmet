
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/restaurent_app/src/controllers/market_controller.dart';
import 'package:markets/restaurent_app/src/elements/BlockButtonWidget.dart';
import 'package:markets/restaurent_app/src/elements/CircularLoadingWidget.dart';
import 'package:markets/restaurent_app/src/helpers/dialogs.dart';

import  'package:markets/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OpenNewKitchenPage extends StatefulWidget {
  @override
  _OpenNewKitchenPageState createState() => _OpenNewKitchenPageState();
}

class _OpenNewKitchenPageState extends StateMVC<OpenNewKitchenPage> {

  MarketController _con;
  _OpenNewKitchenPageState():super(MarketController()){
    _con = controller;
    print('initialized controller $_con');
  }
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget progressBar = Row(
      children: <Widget>[
         Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                tabIndex = 0;
              });
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    S.of(context).about_kitchen
                    ,
                    style: TextStyle(
                        color: tabIndex == 0
                            ? Theme.of(context).accentColor
                            : Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                tabIndex >= 0
                    ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2.0),
                      bottomLeft: Radius.circular(2.0)),
                  child: Container(
                      height: 3.0,
                      color: Theme.of(context).accentColor),
                )
                    : Divider(
                    height: 2, color: Colors.black.withOpacity(0.7))
              ],
            ),
          ),
        ),


         Expanded(
          child: GestureDetector(
            onTap: () {
                if(_con.formKey1.currentState.validate()){
                  _con.formKey1.currentState.save();
                  setState(() {
                    tabIndex = 1;
                  });
                }
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    S.of(context).Kitchen_Detail,
                    style: TextStyle(
                        color: tabIndex == 1
                            ? Theme.of(context).accentColor
                            : Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                tabIndex >= 1
                    ? Container(
                    height: 3.0,
                    color: Theme.of(context).accentColor)
                    : Divider(
                    height: 2, color: Colors.black.withOpacity(0.7))
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {

              if(_con.formKey.currentState.validate()){
                _con.formKey.currentState.save();
                setState(() {
                  tabIndex = 2;
                });
              }
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    S.of(context).Kitchen_Media,
                    style: TextStyle(
                        color: tabIndex == 2
                            ? Theme.of(context).accentColor
                            : Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                tabIndex >= 2
                    ? Container(
                    height: 3.0,
                    color: Theme.of(context).accentColor)
                    : Divider(
                    height: 2, color: Colors.black.withOpacity(0.7))
              ],
            ),
          ),
        )
        // kPaymentConfig['EnableReview']
        //     ? Expanded(
        //   child: GestureDetector(
        //     onTap: () {
        //       if (cartModel.shippingMethod != null) {
        //         setState(() {
        //           tabIndex = 2;
        //         });
        //       }
        //     },
        //     child: Column(
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 13),
        //           child: Text(
        //             S.of(context).review.toUpperCase(),
        //             style: TextStyle(
        //               color: tabIndex == 2
        //                   ? Theme.of(context).primaryColor
        //                   : Theme.of(context).accentColor,
        //               fontSize: 12,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         tabIndex >= 2
        //             ? Container(
        //             height: 3.0,
        //             color: Theme.of(context).primaryColor)
        //             : Divider(
        //             height: 2, color: Theme.of(context).accentColor)
        //       ],
        //     ),
        //   ),
        // )
        //     : Container(),
        // Expanded(
        //   child: GestureDetector(
        //     onTap: () {
        //
        //         setState(() {
        //           tabIndex = 3;
        //         });
        //       }
        //
        //     child: Column(
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 13),
        //           child: Text(
        //             S.of(context).payment.toUpperCase(),
        //             style: TextStyle(
        //               color: tabIndex == 3
        //                   ? Theme.of(context).primaryColor
        //                   : Theme.of(context).accentColor,
        //               fontSize: 12,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         tabIndex >= 3
        //             ? ClipRRect(
        //           borderRadius: const BorderRadius.only(
        //               topRight: Radius.circular(2.0),
        //               bottomRight: Radius.circular(2.0)),
        //           child: Container(
        //               height: 3.0, color: Theme.of(context).primaryColor),
        //         )
        //             : Divider(height: 2, color: Theme.of(context).accentColor)
        //       ],
        //     ),
        //   ),
        // )
      ],
    );


    return Scaffold(
      appBar: AppBar(
        title: Text(
            S.of(context).add_kitchen), centerTitle: true,
        elevation: 0,

        automaticallyImplyLeading: false,
        leading:  new IconButton(
      icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
      onPressed: () => Navigator.of(context).pushNamed('/Pages',arguments: 3),
    ),
      ),
      key: _con.scaffoldKey,
      body: Container(
         margin: EdgeInsets.symmetric(horizontal: 20),
        // padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            // Container(
            //   child: Row(
            //     children: [
            //       Icon(Icons.)
            //       Text('Add Kitchen')
            //     ],
            //   ),
            // ),
            progressBar,
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10),
                children: <Widget>[renderContent()],
              ),
            )
          ],
        ),
      ),
    );
  }
  renderContent(){
    print(_con);
    return tabIndex==0? Page1(controller: _con,changePage: changePage,): tabIndex==1?Page2(controller: _con,changePage: changePage,):Page3(controller: _con,changePage: changePage,);
  }
  changePage(newPageIndex){
    tabIndex = newPageIndex;
    setState(() { });
  }
}


class Page1 extends StatefulWidget {
  final MarketController controller;
  final Function changePage;

  const Page1({Key key, this.controller,this.changePage}) : super(key: key);
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends StateMVC<Page1> {
  MarketController _con;
  bool isKitchenPaid = false;
  bool isKitchenClosed = false;
  bool isKitchenAvailableForDelivery = false;
  bool sameDayDelivery = false;
  List _selectedValues = [];
  List drivers;
  bool loading = true;
  String selectedCuisine;
  List<String> cuisines = ['Desert','Asian','Arabic','Pizza','Kuwaiti','Fast Food','European'];

  var vegetarianFood = false;
  @override
  void initState() {
    // TODO: implement initState
    _con = widget.controller;
    print('initstate page 1 ');
    print(_con);

    getDrivers();

    super.initState();
  }

  getDrivers()async{
    drivers = await _con.getDriversList();
    print('drivers response');
    print(drivers);

    List<MultipleSelectItem> lst = [];
    drivers.forEach((element) {
      lst.add(MultipleSelectItem.build(
        value: element['user']['id'],
        display: '${element['user']['name']}',
        content: '${element['user']['name']}',
      ));
    });


    elements = lst;
    loading = false;
    setState(() {});
  }

  List<MultipleSelectItem> elements = List.generate(
    5,
        (index) => MultipleSelectItem.build(
      value: index,
      display: '$index display',
      content: '$index content',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _con.formKey1,
        child: loading ?Container(child:CircularLoadingWidget(height: 300,)) : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.name = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              decoration: InputDecoration(
                labelText: S.of(context).full_name,

                labelStyle: TextStyle(color: Theme.of(context).accentColor),

                contentPadding: EdgeInsets.all(12),

                hintText: S.of(context).My_Kitchen,

                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.nameAr = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(



              labelText: 'Name (arabic)',

              labelStyle: TextStyle(color: Theme.of(context).accentColor),

              contentPadding: EdgeInsets.all(12),

              hintText:  S.of(context).My_Kitchen,

              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.description = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(

                labelText: 'Description',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText:  S.of(context).My_Kitchen,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),

            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.descriptionAr = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Description (arabic)',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText:S.of(context).My_Kitchen,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),


            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.kitchen.deliveryRange = double.parse(input),
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Delivery_Range_in_KM,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '20',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              keyboardType: TextInputType.number,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              onSaved: (input) => _con.kitchen.deliveryFee = double.parse(input),
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Delivery_Fee,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '20',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),

            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              onSaved: (input) => _con.kitchen.maximumOrdersPerDay = int.parse(input),
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Maximum_Orders_Per_Day,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '20',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            MultipleDropDown(
              placeholder: S.of(context).Select_Delivery_Boys,
              disabled: false,
              values: _selectedValues,

              elements:elements,

            ),

            SizedBox(height: 0),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(S.of(context).Select_Cuisine,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black.withOpacity(0.7)),),
                value: selectedCuisine,
                items:cuisines.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  print(val);
                  _con.kitchen.cuisine =  val;
                  selectedCuisine = val;
                  setState(() { });
                },
              ),
            ),

            Row(
              children: [
                Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    value: isKitchenPaid, onChanged: (newVal){
                      if(newVal &&_con.isPaid()) {
                        isKitchenPaid = newVal;
                        _con.kitchen.isPaidKitchen = newVal;
                        setState(() {});
                      }else if(newVal==false){
                        isKitchenPaid = newVal;
                        _con.kitchen.isPaidKitchen = newVal;
                        setState(() {});
                      }else {
                        showDialog(context: context, builder: (context)=>paidKitchenDialog(context));
                      }
                }),
                Text(S.of(context).Paid_Kitchen)
              ],
            ),
            SizedBox(height: 0),
            Row(
              children: [
                Checkbox(

                    activeColor: Theme.of(context).accentColor,
                    value: isKitchenClosed, onChanged: (newVal){
                  isKitchenClosed = newVal;
                  _con.kitchen.closed = newVal;
                  setState(() { });
                }),
                Text(S.of(context).Closed_Kitchen)
              ],
            ),
            SizedBox(height: 0),
            Row(
              children: [
                Checkbox(
                   activeColor: Theme.of(context).accentColor,
                    value: isKitchenAvailableForDelivery, onChanged: (newVal){
                  isKitchenAvailableForDelivery = newVal;
                  _con.kitchen.availableForDelivery = newVal;
                  setState(() { });
                }),
                Text(S.of(context).Kitchen_Available_For_Delivery)
              ],
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    value: sameDayDelivery, onChanged: (newVal){
                  sameDayDelivery = newVal;
                  _con.kitchen.sameDayDelivery = newVal;
                  setState(() { });
                }),
                Text(S.of(context).Same_Day_Delivery)
              ],
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    value: vegetarianFood, onChanged: (newVal){
                  vegetarianFood = newVal;
                  _con.kitchen.vegetarianFood = newVal;
                  setState(() { });
                }),
                Text(S.of(context).Vegetarian_Food)
              ],
            ),
            SizedBox(height: 10),
            BlockButtonWidget(
              text: Text(
                S.of(context).Next,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                print(_selectedValues);
                if( _con.formKey1.currentState.validate()) {
                  _con.formKey1.currentState.save();
                  _con.kitchen.drivers = _selectedValues?.map((e) => {'user_id':e})?.toList()??[];
                  widget.changePage(1);
                }
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}


class Page2 extends StatefulWidget {
  final MarketController controller;
  final Function changePage;
  const Page2({Key key, this.controller,this.changePage}) : super(key: key);
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends StateMVC<Page2> {
  MarketController _con;
  FocusNode _focusNode = FocusNode(canRequestFocus: true);
  @override
  void initState() {
    // TODO: implement initState
    _con = widget.controller;
  //  _focusNode.requestFocus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _con.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              validator: (input) => input==null||input=="" || input.length<9? S.of(context).invalid_field : null,
              onSaved: (input) => _con.kitchen.phone = input,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              decoration: InputDecoration(
                labelText: S.of(context).Phone,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '00965XXXXXXXX',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              keyboardType: TextInputType.phone,
              onSaved: (input) => _con.kitchen.mobile = input,
              validator: (input) => input==null||input=="" || input.length<9? S.of(context).invalid_field : null,
              decoration: InputDecoration(

                labelText: 'Mobile',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '00965XXXXXXXX',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.address = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,

              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Address,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: S.of(context).street_kuwait_city,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),

            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.kitchen.latitude = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Latitude,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '33.45444',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.kitchen.longitude = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Longitude,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '77.45444',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.information = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Information,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: S.of(context).My_Kitchen,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),

            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.informationAr = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Information,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: S.of(context).My_Kitchen,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.termsAndConditions = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Terms_and_Conditions,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: S.of(context).My_Kitchen,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),

            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.kitchen.termsAndConditionsAr = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: S.of(context).Terms_and_Conditions,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: S.of(context).My_Kitchen,
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),

            SizedBox(height: 30),
            BlockButtonWidget(
              text: Text(
                S.of(context).Next,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                if( _con.formKey.currentState.validate()) {
                  _con.formKey.currentState.save();
                  widget.changePage(2);
                }
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  final MarketController controller;
  final Function changePage;
  const Page3({Key key, this.controller,this.changePage}) : super(key: key);
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends StateMVC<Page3> {
  MarketController _con;
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    _con = widget.controller;
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );

  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,

        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Done",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Gourmet",
          allViewTitle: "All Photos",
          useDetailsView: false,

          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }



  @override
  Widget build(BuildContext context) {
    return  loading ?Center(child: CircularLoadingWidget(height: 300,),): Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
       //   Center(child: Text('Error: $_error')),

          InkWell(
            child: Container(
                width:  MediaQuery.of(context).size.width,
                height: 100,
                child: Image.asset('assets/upload.png')),
            onTap: loadAssets,
          ),
          // ElevatedButton(
          //   child: Text("Pick images"),
          //   onPressed: loadAssets,
          // ),
          Container(
            height: 400,
            child: buildGridView(),
          ),
          BlockButtonWidget(
            text: Text(
              S.of(context).submit,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () async{

              loading = true;
              setState(() {});
               Asset image = images[0];
               final filePath = await FlutterAbsolutePath.getAbsolutePath(image.identifier);
               File tempFile = File(filePath);

               String uuid = await _con.uploadImage1(tempFile);

               print(uuid);
              _con.kitchen.uuid = uuid;
              var resp =  await _con.addNewMarket();
              try {
                if (resp['success']) {
                  Fluttertoast.showToast(msg: resp['message']);
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(msg: resp['message']);
                }
              }catch(e){
                print(e);
                Fluttertoast.showToast(msg: S.of(context).something_went_wrong);
              }
              loading = false;
              setState(() {});

            },
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}