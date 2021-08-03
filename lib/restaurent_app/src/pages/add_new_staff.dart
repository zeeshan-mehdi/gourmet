
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:markets/generated/l10n.dart';
import 'package:markets/restaurent_app/src/controllers/staff_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddNewStaff extends StatefulWidget {
  final StaffController controller;
  final String marketId;

  const AddNewStaff({Key key, this.marketId,this.controller}) : super(key: key);
  @override
  _AddNewStaffState createState() => _AddNewStaffState();
}

class _AddNewStaffState extends StateMVC<AddNewStaff> {

  StaffController controller ;


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController staffController = TextEditingController();

  bool load = false;


  @override
  void initState() {
    // TODO: implement initState
    controller= widget.controller;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Restaurant Staff',
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).hintColor,
        ),

        automaticallyImplyLeading: false,

        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: load ?Center(child: CircularProgressIndicator(),)  :SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(

              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S
                        .of(context)
                        .staff_email,
                    style:  Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ),
               TextFormField(
                    controller: staffController,
                    validator: (val) {
                      return null;
                    },
                    decoration:
                    InputDecoration(labelText: S
                        .of(context)
                        .staff_email,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),

                    onSaved: (String value) {

                    }) ,


                Padding(
                  padding: const EdgeInsets.symmetric(vertical:18.0),
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();

                        setState(() {load = true;});

                        String email = staffController.text;

                        bool inserted = await controller.addNewStaff(widget.marketId,email);

                        if(inserted)
                          Navigator.of(context).pop();
                        else{
                          Fluttertoast.showToast(msg: 'Something Went Wrong');
                        }
                        setState(() {load = false;});
                        //_con.addAddress(address);
                        //Navigator.of(context).pushNamed('/Pages',arguments: 11);
                       // Navigator.of(context).pop();
                      }
                      //Navigator.of(context).pushNamed('/Cart',arguments: RouteArgument(param: _con.scaffoldKey));
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: Text(
                        S.of(context).save,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                            Theme.of(context).primaryColor),
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
}
