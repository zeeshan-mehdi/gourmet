import 'package:flutter/material.dart';
import 'package:markets/src/elements/BlockButtonWidget.dart';
import '../../generated/l10n.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;

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
      backgroundColor: Colors.black,
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
                      "GOURMET \n SLOGEN \n COMES \n HERE",
                      style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 40),
                    ),
                    Text(
                      "Find the food that you deserve",
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
                      onPressed: () {
                        // _con.login();
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
                      onPressed: (){
                        print("Sign in with Apple");
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
                            "Sign in with Apple",
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
                          onPressed: (){
                            print("Connect with facebook");
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
                                "Sign in with facebook",
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
