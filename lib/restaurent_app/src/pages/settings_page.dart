
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class KitchenSettingsPage extends StatefulWidget {
  @override
  _KitchenSettingsPageState createState() => _KitchenSettingsPageState();
}

class _KitchenSettingsPageState extends State<KitchenSettingsPage> {

  TextEditingController _myFatoorahController = TextEditingController(text: 'skdfjsdfkjsdf-sdlkfjsdflksjdf-sdf');
  SharedPreferences instance;
  String key = 'lksdjflkjsdflkjsdflkjsdflk-sldfkjsdlfkjsljsdflkjsdfsdflkjsdf';

  bool edit = false;
  @override
  void initState() {
    // TODO: implement initState
    getKey();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: Container(
        height: MediaQuery.of(context).size.height/2-40,
        margin: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kitchen Settings',style: Theme.of(context).textTheme.headline4,),

                SizedBox(height: 10,),

                Text('My Fatoorah Api Key'),
                SizedBox(height: 10,),

                // TextField(
                //
                //   controller: _myFatoorahController,
                // ),
                edit ? Container() :Text('$key'),

                edit ? TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter New Api Key',
                    border: UnderlineInputBorder(

                    ),
                    fillColor: Theme.of(context).accentColor,
                    focusColor: Theme.of(context).accentColor
                  ),
                  controller: _myFatoorahController,
                ):Container(),

              SizedBox(height: 100,),

              Padding(
              padding: const EdgeInsets.symmetric(vertical:18.0),
              child: MaterialButton(
                elevation: 0,
                onPressed: () {
                 if(!edit){
                   setState(() {
                     edit = true;
                   });
                 }else{
                   edit = false;
                   saveKey();
                 }
                },
                padding: EdgeInsets.symmetric(vertical: 14),
                color: edit ? Colors.green :Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20),
                  child: Text(
                    !edit ?  'Edit' : 'Save',
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

  saveKey()async{
    if(instance==null) instance = await SharedPreferences.getInstance();

    if(_myFatoorahController.text!=null && _myFatoorahController.text!=""){
      instance.setString('key', _myFatoorahController.text);
      key = _myFatoorahController.text;
      setState(() {
        Fluttertoast.showToast(msg: 'My Fatoorah Api Key Updated');
      });
    }
  }

  void getKey() async{
    if(instance==null) instance = await SharedPreferences.getInstance();

    key = instance.get('key');
  }
}
