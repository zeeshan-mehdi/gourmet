
import 'package:flutter/material.dart';

class ProfileKitchenSection extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  const ProfileKitchenSection({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _ProfileKitchenSectionState createState() => _ProfileKitchenSectionState();
}

class _ProfileKitchenSectionState extends State<ProfileKitchenSection> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          ListItem(color:Colors.red , title: 'Manage Restaurant',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 4 );
          },),

          ListItem(color:Colors.lightBlue , title: 'Restaurant Membership',onPressed: (){},),

          ListItem(color:Colors.indigo, title: 'Restaurant Orders',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 5 );
          },),

          ListItem(color:Colors.orange , title: 'Help from Gourmet',),

        ],
      ),
    );
  }
}

class UserProfileSection extends StatefulWidget {
  @override
  _UserProfileSectionState createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          ListItem(color:Colors.red , title: 'My Account',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 6);
          },),

          ListItem(color:Colors.lightBlue , title: 'My Addresses',),

          ListItem(color:Colors.indigo, title: 'Orders',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 1);
          },),

          ListItem(color:Colors.orange , title: 'Settings',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 7);
          },),

        ],
      ),
    );
  }
}



class ListItem extends StatelessWidget {
  final title;
  final Color color;
  final onPressed;

  const ListItem({Key key, this.title, this.color, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: color),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: color
                ),
              ),
              SizedBox(width: 20,),
              Text('$title',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black,fontSize: 20),),

            ],
          ),
          IconButton(icon: Icon(Icons.arrow_forward_ios_outlined,size: 20,),color: Colors.black.withOpacity(0.3), onPressed: this.onPressed)

        ],),
    );
  }
}

