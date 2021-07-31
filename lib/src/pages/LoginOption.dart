import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markets/src/elements/BlockButtonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/l10n.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../elements/BlockButtonWidget.dart';
import '../../generated/l10n.dart';

import '../helpers/app_config.dart' as config;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/models/address.dart';
import 'package:markets/src/models/credit_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/market.dart';
import '../models/product.dart';
import '../repository/market_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import '../repository/user_repository.dart' as userRepo;
import '../helpers/helper.dart';
import '../models/category.dart';
import '../models/market.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/slide.dart';
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/slide.dart';
import '../models/user.dart' as model;
import '../pages/mobile_verification_2.dart';
import '../repository/slider_repository.dart';
import '../repository/user_repository.dart' as repository;
import '../models/user.dart' as userModel;
class LoginOption extends StatefulWidget {
  @override
  _LoginOptionState createState() => _LoginOptionState();
}

class _LoginOptionState extends State<LoginOption> {
  // LanguagesList languagesList;

  @override
  void initState() {
    //  languagesList = new LanguagesList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     S.of(context).languages,
      //     style: Theme.of(context)
      //         .textTheme
      //         .headline6
      //         .merge(TextStyle(letterSpacing: 1.3)),
      //   ),
      //   actions: <Widget>[
      //     new ShoppingCartButtonWidget(
      //         iconColor: Theme.of(context).hintColor,
      //         labelColor: Theme.of(context).accentColor),
      //   ],
      // ),
      backgroundColor: Color(0xFF1E232E),
      body: SingleChildScrollView(

        padding: EdgeInsets.symmetric(vertical: config.App(context).appHeight(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Positioned(
              top: config.App(context).appHeight(35),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                height: config.App(context).appHeight(70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "GOURMET \nSLOGEN\nCOMES\nHERE",
                      style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 40),
                    ),
                    Text(
                        S.of(context).find_the_food_that_you_deserve,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: config.App(context).appHeight(10),
                    ),

                    BlockButtonWidget(

                      text: Text(
                        S.of(context).login,
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: ()  {
                        // _con.login();
                        //SharedPreferences prefs = await SharedPreferences.getInstance();
                        // int counter = (prefs.getInt('counter') ?? 0) + 1;
                       // print('set boolean true.');
                      //  await prefs.setBool('welcome', true);
                        Navigator.of(context).pushReplacementNamed('/Login');
                      },
                    ),
                    SizedBox(
                      height: config.App(context).appHeight(1.2),
                    ),
                  Container(
                      //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                      //   BoxShadow(color: th.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                      // ],
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () async {
                        print("Sign in with Apple");
                          // setState(() {
                          //   isLoading = true;
                          // });

                          // setState(() {
                          //   isLoading = false;
                          // });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                      color: Colors.white,
                      shape: StadiumBorder(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/appleLogo.png',
                            height: 22,
                            width: 40,
                          ),
                          Text(
                            S.of(context).sign_in_with_Apple,
                            style: TextStyle(color: Colors.black,fontSize: 16),
                          ),
                        ],
                      )
                    ),
                  ),
                    SizedBox(
                      height: config.App(context).appHeight(1.2),
                    ),
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                        //   BoxShadow(color: th.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                        // ],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: MaterialButton(
                          elevation: 0,
                          onPressed: () async{
                            print("Connect with google");

                            FirebaseService service = new FirebaseService();
                            try {
                              await service.signInwithGoogle();
                              // Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
                            } catch(e){
                              if(e is FirebaseAuthException){
                                print(e.message);
                              }
                            }
                          },
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                          color: Colors.blueAccent,
                          shape: StadiumBorder(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/facebookLogo.png',
                                height: 22,
                                width: 40,
                              ),
                              Text(
                                S.of(context).sign_in_with_google,
                               // "Sign in with Google",
                                style: TextStyle(color: Colors.white,fontSize: 16),
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class FirebaseService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GlobalKey<ScaffoldState> scaffoldKey;
  model.User user = new model.User();

  Future<String> signInwithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      repository.login(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
        } else {
          print("wrong_email_or_password");
          // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          //   content: Text(S.of(state.context).wrong_email_or_password),
          // ));
        }

      }).catchError((e) {
        print("this_account_not_exist");
        //loader.remove();
        // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        //   content: Text(S.of(state.context).this_account_not_exist),
        //));
      }).whenComplete(() {
       // Helper.hideLoader(loader);
      });
      // if (credential.token != null && credential.token  != null) {
      //   Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
      // } else {
      //   print("wrong_email_or_password");
      //   // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   //   content: Text(S.of(state.context).wrong_email_or_password),
      //   // ));
      // }

    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}