import 'dart:convert';
import 'dart:io';
import 'package:markets/src/pages/pages.dart';
import 'package:markets/src/repository/user_repository.dart';

import '../models/user.dart' as userModel;
import '../repository/user_repository.dart' as userRepo;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markets/src/elements/BlockButtonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/l10n.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../elements/BlockButtonWidget.dart';
import '../../generated/l10n.dart';
import 'package:http/http.dart' as http;

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
  ValueNotifier<userModel.User> currentUser = new ValueNotifier(userModel.User());

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
                              //await service.signInwithGoogle();
                              await service.signInWithGoogle(context);

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
  //model.User user = new model.User();

  // Future<String> signInwithGoogle() async {
  //   try {
  //     final GoogleSignInAccount googleSignInAccount =
  //     await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     print("aadd");
  //     print(credential.token);
  //     print(credential.providerId);
  //     print(credential.signInMethod);
  //     // repository.login(user).then((value) {
  //     //   if (value != null && value.apiToken != null) {
  //     //     Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
  //     //   } else {
  //     //     print("wrong_email_or_password");
  //     //     // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //     //     //   content: Text(S.of(state.context).wrong_email_or_password),
  //     //     // ));
  //     //   }
  //     //
  //     // }
  //     // ).catchError((e) {
  //     //   print("this_account_not_exist");
  //     //   //loader.remove();
  //     //   // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //     //   //   content: Text(S.of(state.context).this_account_not_exist),
  //     //   //));
  //     // }).whenComplete(() {
  //     //  // Helper.hideLoader(loader);
  //     // });
  //     // if (credential.token != null && credential.token  != null) {
  //     //   Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
  //     // } else {
  //     //   print("wrong_email_or_password");
  //     //   // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //     //   //   content: Text(S.of(state.context).wrong_email_or_password),
  //     //   // ));
  //     // }
  //
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print(credential.accessToken);
    print(credential.idToken);
    print(googleUser.email);
    print(googleUser.id);
    login(googleUser.email,googleUser.id,context,googleUser);
    print(FirebaseAuth.instance.signInWithCredential(credential));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  void _showToast(BuildContext context,String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('$message'),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void login(String email,String pass,BuildContext context,GoogleSignInAccount userDetial) async {
    //loader = Helper.overlayLoader(state.context);
   // FocusScope.of(state.context).unfocus();
     // loginFormKey.currentState.save();
      //Overlay.of(state.context).insert(loader);
    model.User user = new model.User();
    print(email);
    print(pass);
    user.email = email;
    user.password= pass.toString();

      repository.login(user).then((value) {
        print("user emai is ${value.apiToken}");
        print("user emai is ${value.email}");
        print(user.email);
        if (value != null && value.apiToken != null) {
          print("user is login");
          Navigator.of(context).push( MaterialPageRoute(builder: (_) => PagesWidget(currentTab: 0)));

          //  Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
        } else {

          print(value.email);
        }
      }).catchError((e) {
        print("this_account_not_exist");

      //  _showToast(context,"This account not exist");
       // register(userDetial,context);
        model.User user = new model.User();
        print(userDetial.email);
        print(userDetial.id);
       // user.email = userDetial.email;
        // user.name = userDetial.displayName;
        // user.password = userDetial.id.toString();
        // user.phone = "";
        // user.deviceToken = "eIgcV8ESCU8_iqBjMzN8aL:APA91bFcyGCYlHc22cFooalmHdwziU2Czc-obP6NMb_hobPFxTvMoHRhUQ69XnOqyozDqm68UYm8ge9-JZ5iwAnVIZus_yqVqfonRWJ78NwKJjKbl_LRphspKvyY-tilWUZpISDhYR29";
        // user.address = "Islamabad";
        // print("karachi");
        print(user.toMap());
        register(userDetial, context);
       // loader.remove();
       //  ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
       //    content: Text(S.of(state.context).this_account_not_exist),
       //  ));
      }).whenComplete(() {
       // Helper.hideLoader(loader);
      });
  }


  Future<userModel.User> registers(userModel.User user) async {
    print("aabb " + user.email.toString());
    print("break point 1");
    final String url = '${GlobalConfiguration().getValue('api_base_url')}manager/register';
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(user.toMap()),
    );
    if (response.statusCode == 200) {
      print("break point 2");

      setCurrentUser(response.body);
      currentUser.value = userModel.User.fromJSON(json.decode(response.body)['data']);
    } else {
      print("break point 3");

      throw new Exception(response.body);
    }
    return currentUser.value;
  }

  void register(GoogleSignInAccount userDetial,BuildContext context) async {
    print("token is ${"abc"}");
  //  loader = Helper.overlayLoader(state.context);
  ///  FocusScope.of(state.context).unfocus();
   // Overlay.of(state.context).insert(loader);
    model.User user = new model.User();
    print(userDetial.email);
    print(userDetial.id);
    user.email = userDetial.email;
    user.name = userDetial.displayName;
    user.password = userDetial.id.toString();
    user.phone = "";
    user.deviceToken = "eIgcV8ESCU8_iqBjMzN8aL:APA91bFcyGCYlHc22cFooalmHdwziU2Czc-obP6NMb_hobPFxTvMoHRhUQ69XnOqyozDqm68UYm8ge9-JZ5iwAnVIZus_yqVqfonRWJ78NwKJjKbl_LRphspKvyY-tilWUZpISDhYR29";
    user.address = "Islamabad";
   // user.image = userDetial.photoUrl
    //user = userDetial.displayName;

    repository.register(user).then((value) {
      print("token is ${user.name}");
      print("token 2 is ${user.name}");
      if (value != null && value.apiToken != null) {
        Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
      } else {
        print("wrong_email_or_password");
        // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        //   content: Text(S.of(state.context).wrong_email_or_password),
        // ));
      }
    }).catchError((e) {
      print("this_email_account_exists");
      Navigator.of(context).push( MaterialPageRoute(builder: (_) => PagesWidget(currentTab: 0)));

     // Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);

    //  _showToast(context,"this email account already exists");
      // loader.remove();
     //  ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
     //    content: Text(S.of(state.context).this_email_account_exists),
     //  ));
    }).whenComplete(() {
     // Helper.hideLoader(loader);
    });
  }
}