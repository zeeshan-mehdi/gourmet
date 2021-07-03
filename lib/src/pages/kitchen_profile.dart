import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/elements/ProfileKitchenSection.dart';

import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../../generated/l10n.dart';
class KitchenProfile extends StatefulWidget {
  @override
  _KitchenProfileState createState() => _KitchenProfileState();
}

class _KitchenProfileState extends State<KitchenProfile> {
  final GlobalKey<ScaffoldState> parentScaffoldKey  = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: parentScaffoldKey ,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
             currentUser.value.apiToken != null
                ? Container(
               height: 200,
               padding: EdgeInsets.all(20),
               color: Color(0xFFF7F8FA),

               child: Row(
                 children: [
                   CircleAvatar(

                     backgroundImage: NetworkImage(currentUser.value.image.url),
                     radius: 50,
                   ),

                   SizedBox(width: 10,),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left:18.0),
                           child: Text(currentUser.value.name.toUpperCase(),style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 26,fontWeight: FontWeight.bold),),
                         ),
                         InkWell(child: Icon(Icons.arrow_forward_ios_outlined,size: 15,color:Colors.black.withOpacity(0.3)), onTap: (){})

                       ],
                     ),

                       SizedBox(height: 5,),
                       Container(


                         child: Padding(
                           padding: const EdgeInsets.only(left:16,right:16,top:3.0,bottom: 3),
                           child: Text('VIP KITCHEN',style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 12,color: Colors.white),),
                         ),
                         decoration: BoxDecoration(
                             border: Border.all(color: Color(0xFFFF2E55)),
                             borderRadius: BorderRadius.all(Radius.circular(3)),
                             color: Color(0xFFFF2E55)
                         ),
                       ),
                   ],)
                 ],
               ),

             )
                : Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).welcome, style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).accentColor))),
                  SizedBox(height: 5),
                  Text(S.of(context).loginAccountOrCreateNewOneForFree, style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    children: <Widget>[
                      MaterialButton(
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Login');
                        },
                        color: Theme.of(context).accentColor,
                        height: 40,
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 9,
                          children: [
                            Icon(Icons.exit_to_app_outlined, color: Theme.of(context).primaryColor, size: 24),
                            Text(
                              S.of(context).login,
                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                        shape: StadiumBorder(),
                      ),
                      MaterialButton(
                        elevation: 0,
                        color: Theme.of(context).focusColor.withOpacity(0.2),
                        height: 40,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/SignUp');
                        },
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 9,
                          children: [
                            Icon(Icons.person_add_outlined, color: Theme.of(context).hintColor, size: 24),
                            Text(
                              S.of(context).register,
                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).hintColor)),
                            ),
                          ],
                        ),
                        shape: StadiumBorder(),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            ProfileKitchenSection(parentScaffoldKey:parentScaffoldKey),

            SizedBox(height: 50,),

            UserProfileSection(),

          ],
        ),
      ),
    );
  }
}


