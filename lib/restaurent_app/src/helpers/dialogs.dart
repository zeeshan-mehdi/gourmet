

import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/pages/pages.dart';

paidKitchenDialog(context){

  return Container(
    height: 200,
    child: AlertDialog(
      title: Text('Upgrade your Membership',style: TextStyle(fontSize: 20),),
      content: Text('You are on free membership you need to upgrade to premium membership to list paid kitchen'),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Cancel'),),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PagesTestWidget(currentTab: 5,)));
        }, child: Text('Upgrade'))
      ],
    ),
  );

}