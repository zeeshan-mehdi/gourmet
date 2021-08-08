import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/controllers/market_controller.dart';
import 'package:markets/restaurent_app/src/models/market.dart';
import 'package:markets/restaurent_app/src/models/media.dart';
import 'package:markets/src/elements/ProfileKitchenSection.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';
class KitchenProfile extends StatefulWidget {
  @override
  _KitchenProfileState createState() => _KitchenProfileState();
}

class _KitchenProfileState extends StateMVC<KitchenProfile> {

  MarketController _marketController;

  Market myMarket;

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    _marketController = MarketController();
    getFirstMarket();
    super.initState();
  }
  getFirstMarket()async{

    setState(() {loading=true;});

    myMarket = await _marketController.getFirstMarket();

    setState(() {loading = false;});
  }




  @override
  Widget build(BuildContext context) {
    var url = currentUser.value?.image?.thumb??'';

    print('current user');
    print(currentUser.value);

    if(url!=null && !url.contains("https")){
      url = url.replaceFirst('http', 'https');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
               currentUser.value.apiToken != null
                  ? Container(
                 padding: EdgeInsets.only(top: 58,left: 15),
                 height: 200,
                    color: Color(0xFFF7F8FA),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                     Stack(
                       children: [
                         SizedBox(
                           width: 80,
                           height: 80,
                           child: ClipRRect(
                             borderRadius: BorderRadius.all(Radius.circular(80)),
                             child: CachedNetworkImage(
                               height: 80,
                               width: double.infinity,
                               fit: BoxFit.cover,
                               imageUrl:url,
                               placeholder: (context, url) => Image.asset(
                                 'assets/img/loading.gif',
                                 fit: BoxFit.cover,
                                 width: double.infinity,
                                 height: 80,
                               ),
                               errorWidget: (context, url, error) => Icon(Icons.error_outline),
                             ),
                           ),
                         ),
                         Positioned(
                           top: 0,
                           right: 0,
                           child: currentUser.value.verifiedPhone ?? false
                               ? Icon(
                             Icons.check_circle,
                             color: Theme.of(context).accentColor,
                             size: 24,
                           )
                               : SizedBox(),
                         )
                       ],
                     ),

                     SizedBox(width: 25,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text(myMarket!=null && myMarket.name!=null ? myMarket.name.toUpperCase() :currentUser.value.name?.toUpperCase()??'',style: Theme.of(context).textTheme.headline1.copyWith(fontWeight: FontWeight.bold,fontSize: 20)),
                             SizedBox(width: 5,),
                             InkWell(child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black.withOpacity(0.3),),onTap: (){},),
                           ],
                         ),
                         SizedBox(height: 5,),
                         Container(
                           height: 25,
                           margin: EdgeInsets.all(0),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal:12.0,),
                             child: Center(child: Text( myMarket!=null? myMarket.isPaidKitchen ?  'VIP KITCHEN' : 'FREE KITCHEN'  :'FREE USER', style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 12,color: Colors.white))),
                           ),
                           decoration: BoxDecoration(
                               border: Border.all(color:myMarket!=null&&myMarket.isPaidKitchen ?  const Color(0xFFFF2E55):  Theme.of(context).accentColor),
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                               color:myMarket!=null&&myMarket.isPaidKitchen ?  const Color(0xFFFF2E55) :  Theme.of(context).accentColor
                           ),
                         ),
                       ],
                     ),

                 ],
               ),
                  )
                  : Container(
                 width: MediaQuery.of(context).size.width,
                height: 200,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            Navigator.of(context).pushNamed('/LoginOption');
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



              Container(
                height: currentUser.value.isDriver !=null &&currentUser.value.isDriver ==true ? 310: 500,
                color: Colors.white,
                child: Column(
                  children: [
                   loading  ? KitchenLoadingWidget(width: MediaQuery.of(context).size.width-50.0,height: 200, )  : myMarket==null ? Container(
                     padding: EdgeInsets.all(8),
                     child: Column(
                       children: [
                         Text(currentUser.value.apiToken != null?S.of(context).do_you_know:S.of(context).food_options,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),textAlign: TextAlign.center,),
                         SizedBox(height: 10,),
                         Container(child: Text( currentUser.value.apiToken != null? S.of(context).you_can_become_kitchen_and_work_at_gourmet: S.of(context).gourmet_benefits,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24),textAlign: TextAlign.center,)),
                         SizedBox(height: 20,),
                         MaterialButton(
                           elevation: 0,
                           onPressed: () async{
                             if(currentUser.value.apiToken != null) {
                               await Navigator.of(context).pushNamed(
                                   '/Pages', arguments: 8);
                               getFirstMarket();
                             }else{
                               Navigator.of(context).pushNamed('/LoginOption');
                             }
                           },
                           padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                           color: Theme.of(context).accentColor.withOpacity(1),
                           shape: StadiumBorder(),
                           child: Text(
                             currentUser.value.apiToken != null ? S.of(context).become_kitchen : S.of(context).login,
                             style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                           ),
                         ),
                         SizedBox(height: 20,),

                       ],
                     ),
                   )    : ProfileKitchenSection(market: myMarket,),

                    SizedBox(height: 30,),

                    //currentUser.value.apiToken != null ? UserProfileSection() : Container(),
                    currentUser.value.apiToken != null  ? currentUser.value.isDriver !=null &&currentUser.value.isDriver ==true ? DriverProfileSection() :   ProfileDriverSection():Container(),
                  ],
                ),
              ),

              currentUser.value.apiToken != null ?  UserProfileSection():Container(),

            ],
          ),
        ),
      ),
    );
  }
}


