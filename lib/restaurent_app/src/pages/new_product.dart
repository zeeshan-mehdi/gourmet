
import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/restaurent_app/src/controllers/product_controller.dart';
import 'package:markets/restaurent_app/src/elements/BlockButtonWidget.dart';
import 'package:markets/restaurent_app/src/elements/CircularLoadingWidget.dart';
import 'package:markets/restaurent_app/src/models/category.dart';
import 'package:markets/restaurent_app/src/models/market.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:multiselect_dropdown/multiple_select.dart';

import  'package:markets/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NewProductPage extends StatefulWidget {
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends StateMVC<NewProductPage> {

  ProductController _con;
  _NewProductPageState():super(ProductController()){
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
                    'About Product',
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
                    'Product Detail',
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
        // Expanded(
        //   child: GestureDetector(
        //     onTap: () {
        //
        //       if(_con.formKey.currentState.validate()){
        //         _con.formKey.currentState.save();
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
        //             'Kitchen Media',
        //             style: TextStyle(
        //                 color: tabIndex == 2
        //                     ? Theme.of(context).accentColor
        //                     : Colors.black.withOpacity(0.7),
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //         tabIndex >= 2
        //             ? Container(
        //             height: 3.0,
        //             color: Theme.of(context).accentColor)
        //             : Divider(
        //             height: 2, color: Colors.black.withOpacity(0.7))
        //       ],
        //     ),
        //   ),
        // )
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
            'Add Product'), centerTitle: true,
        elevation: 0,

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
    return tabIndex==0? Page1(controller: _con,changePage: changePage,): Page2(controller: _con,changePage: changePage,);
  }
  changePage(newPageIndex){
    tabIndex = newPageIndex;
    setState(() { });
  }
}


class Page1 extends StatefulWidget {
  final ProductController controller;
  final Function changePage;

  const Page1({Key key, this.controller,this.changePage}) : super(key: key);
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends StateMVC<Page1> {
  ProductController _con;
  bool isproductPaid = false;
  bool isproductClosed = false;
  bool isproductAvailableForDelivery = false;
  List _selectedValues = [];

  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    _con = widget.controller;
    print('initstate page 1 ');
    print(_con);



    super.initState();
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
              onSaved: (input) => _con.product.name = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: 'My product',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.product.nameAr = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Name (arabic)',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: 'My product',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.product.description = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: 'My product',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),

            TextFormField(
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.product.descriptionAr = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Description (arabic)',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: 'My product',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),


            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.product.price = double.parse(input),
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Price',
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
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              onSaved: (input) => _con.product.discountPrice = double.parse(input),
              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Discounted Price',
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

            SizedBox(height: 0),
            Row(
              children: [
                Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    value: isproductPaid, onChanged: (newVal){
                  isproductPaid = newVal;
                  _con.product.featured = newVal;
                  setState(() { });
                }),
                Text('Featured')
              ],
            ),
            SizedBox(height: 0),
            Row(
              children: [
                Checkbox(

                    activeColor: Theme.of(context).accentColor,
                    value: isproductClosed, onChanged: (newVal){
                  isproductClosed = newVal;
                  _con.product.deliverable = newVal;
                  setState(() { });
                }),
                Text('Deliverable Product')
              ],
            ),


            SizedBox(height: 10),
            BlockButtonWidget(
              text: Text(
                'Next',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                print(_selectedValues);
                if( _con.formKey1.currentState.validate()) {
                  _con.formKey1.currentState.save();
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
  final ProductController controller;
  final Function changePage;
  const Page2({Key key, this.controller,this.changePage}) : super(key: key);
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends StateMVC<Page2> {
  ProductController _con;
  List<Market> kitchens = [];
  List<Category> categories = [];
  bool loading = true;

  Market selectedKitchen;
  Category selectedCategory;
  List<Asset> images = <Asset>[];

  @override
  void initState() {
    // TODO: implement initState
    _con = widget.controller;
    getData();
    super.initState();
  }

  getData()async{
    kitchens = await _con.getKitchens();
    categories = await _con.getCategories();

    if(kitchens.length>0)
      selectedKitchen = kitchens[0];
    if(categories.length>0)
      selectedCategory = categories[0];

    loading = false;
    setState(() {});
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
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

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: _con.formKey,
        child: loading ? Center(child:CircularLoadingWidget(height: 300,)): Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              onSaved: (input) => _con.product.capacity= input,
              decoration: InputDecoration(
                labelText: 'Capacity',
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
              keyboardType: TextInputType.text,
              onSaved: (input) => _con.product.unit = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,
              decoration: InputDecoration(
                labelText: 'Unit',
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: 'KG,',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),

                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.product.packageItemsCount = input,
              validator: (input) => input==null||input=="" ? S.of(context).field_cannot_be_empty : null,

              // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
              decoration: InputDecoration(
                labelText: 'Package count',
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

            DropdownButton<Market>(
              hint: Text('Choose Kitchen'),
              value: selectedKitchen,
              items:kitchens.map((Market value) {
                return new DropdownMenuItem<Market>(
                  value: value,
                  child: new Text(value.name),
                );
              }).toList(),
              onChanged: (val) {
                print(val.name);
                _con.product.market =  val;
                selectedKitchen = val;
                setState(() { });
              },
            ),
            SizedBox(height: 30),
           DropdownButton<Category>(
             hint: Text('Choose Category'),
             value: selectedCategory,
             items:categories.map((Category value) {
            return new DropdownMenuItem<Category>(
              value: value,
              child: new Text(value.name),
            );
          }).toList(),
          onChanged: (val) {
            print(val.name);
            selectedCategory = val;
            _con.product.category = val;
            setState(() { });
          },
        ),

            SizedBox(height: 30),
            InkWell(
              child: Container(
                  width:  MediaQuery.of(context).size.width,
                  height: 100,

                  child: Image.asset('assets/upload.png')),
              onTap: loadAssets,
            ),
            SizedBox(height: 30),

            images!=null && images.length>0?Container(
              height: 200,
              child: buildGridView(),
            ):Container(),

            SizedBox(height: 30),

            BlockButtonWidget(
              text: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () async{
                if( _con.formKey.currentState.validate()) {
                  _con.formKey.currentState.save();
                  loading = true;
                  setState(() {});

                  List<String> uuids = [];

                  for(int i=0;i<images.length;i++){
                    Asset image = images[i];
                    final filePath = await FlutterAbsolutePath.getAbsolutePath(image.identifier);
                    File tempFile = File(filePath);

                    String uuid = await _con.uploadImage1(tempFile);
                    uuids.add(uuid);
                  }

                  _con.product.uuid = uuids;

                  var resp =  await _con.addNewProduct();

                  if(resp['success']) {
                    Fluttertoast.showToast(msg:resp['message']);
                    Navigator.of(context).pop();
                  }else{
                    Fluttertoast.showToast(msg:resp['message']);
                  }
                  loading = false;
                  setState(() {});


                }
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );

  }


}
