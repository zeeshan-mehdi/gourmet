
import 'package:flutter/material.dart';
import 'package:markets/src/controllers/user_controller.dart';
import 'package:markets/restaurent_app/src/models/market.dart';
import 'package:markets/restaurent_app/src/models/route_argument.dart';
import 'package:markets/src/pages/pages.dart';

class ProfileKitchenSection extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final Market market;

  const ProfileKitchenSection({Key key, this.parentScaffoldKey,this.market}) : super(key: key);
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
            Navigator.of(context).pushNamed('/Pages',arguments: RouteArgument(id: '4',param: widget.market.id  ) );
          },),

          ListItem(color:Colors.lightBlue , title: 'Restaurant Membership',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 10);



          },),

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

          ListItem(color:Colors.lightBlue , title: 'My Addresses',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: 11);//my addresses
          },),

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



class DriverProfileSection extends StatefulWidget {
  @override
  _DriverProfileSectionState createState() => _DriverProfileSectionState();
}

class _DriverProfileSectionState extends State<DriverProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          // ListItem(color:Colors.red , title: 'Driver Profile',onPressed: (){
          //   Navigator.of(context).pushNamed('/Pages',arguments: NavPages.values.indexOf(NavPages.DriverProfile));
          // },),

          ListItem(color:Colors.lightBlue , title: 'Driver Orders',onPressed: (){
            Navigator.of(context).pushNamed('/Pages',arguments: NavPages.values.indexOf(NavPages.DriverOrders));//my addresses
          },),

          // ListItem(color:Colors.indigo, title: 'Order History',onPressed: (){
          //   Navigator.of(context).pushNamed('/Pages',arguments: NavPages.values.indexOf(NavPages.OrderHistory));
          // },),
          //
          // ListItem(color:Colors.orange , title: 'Driver Map',onPressed: (){
          //   Navigator.of(context).pushNamed('/Pages',arguments: NavPages.values.indexOf(NavPages.DriverMap) );
          // },),

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
    return InkWell(
      child: Container(
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
            IconButton(icon: Icon(Icons.arrow_forward_ios_outlined,size: 20,),color: Colors.black.withOpacity(0.3), onPressed: (){})

          ],),
      ),
      onTap: this.onPressed,
    );
  }
}

class KitchenLoadingWidget extends StatelessWidget {
  final double height;
  final double width;

  const KitchenLoadingWidget({Key key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover
          )
      ),
    ) ;
  }
}


class ProfileDriverSection extends StatefulWidget {

  @override
  State<ProfileDriverSection> createState() => _ProfileDriverSectionState();
}

class _ProfileDriverSectionState extends State<ProfileDriverSection> {
  bool load = false;




  @override
  Widget build(BuildContext context) {
    return Container(
      child: load ?  Center(child:CircularProgressIndicator()) :Column(
        children: [
          Text('Do you know ?',style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),textAlign: TextAlign.center,),
          SizedBox(height: 10,),
          Container(child: Text( 'You can become a driver and work at Gourmet',style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24),textAlign: TextAlign.center,)),
          SizedBox(height: 20,),
          MaterialButton(
            elevation: 0,
            onPressed: becomeDriver,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
            color: Colors.blueAccent.withOpacity(1),
            shape: StadiumBorder(),
            child: Text( 'Become Driver' ,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
            ),
          )
        ],
      ),
    );
  }

  becomeDriver()async{
    var controller = UserController();
    controller.becomeDriver();
    setState(() {
      load = true;
    });

    await Future.delayed(Duration(milliseconds: 30),(){
      Navigator.of(context).pushReplacementNamed('/Pages',arguments: NavPages.values.indexOf(NavPages.Profile));
    });
  }
}


