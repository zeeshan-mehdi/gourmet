import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';

class ForgetPasswordWidget extends StatefulWidget {
  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends StateMVC<ForgetPasswordWidget> {
  UserController _con;

  _ForgetPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(37),
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(37) - 120,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(37),
                child: Column(
                  children: [
                    Text(
                      "Forgot password",
                      textAlign: TextAlign.center,
                      style: (TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Please enter your email address. You\n will receive a link to create a new \n password via email",
                      textAlign: TextAlign.center,
                      style: (TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 16)),
                    ),
                  ],
                )

              ),
            ),
            Positioned(
              top: config.App(context).appHeight(37) - 0,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(20)),
                    //boxShadow: [
                  // BoxShadow(
                  //   blurRadius: 50,
                  //   color: Theme.of(context).hintColor.withOpacity(0.2),
                  // )
                //]
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(100),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                  borderRadius:
                  BorderRadius.all(Radius.circular(40)),
                  //  border: Border(),
                  // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                ),
                child:
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          // labelText: S.of(context).email,
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.only(
                              left: 24, right: 24, top: 12, bottom: 12),
                          hintText: 'Your email',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          //   prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                          // border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),),
                      SizedBox(height: 40),
                      BlockButtonWidget(
                        text: Text(
                          "Send",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          _con.resetPassword();
                        },
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Use Your Phone instead?",
                        textAlign: TextAlign.center,
                        style: (TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Positioned(
            //   bottom: 10,
            //   child: Column(
            //     children: <Widget>[
            //       MaterialButton(
            //         elevation: 0,
            //         onPressed: () {
            //           Navigator.of(context).pushReplacementNamed('/Login');
            //         },
            //         textColor: Theme.of(context).hintColor,
            //         child: Text(S.of(context).i_remember_my_password_return_to_login),
            //       ),
            //       MaterialButton(
            //         elevation: 0,
            //         onPressed: () {
            //           Navigator.of(context).pushReplacementNamed('/SignUp');
            //         },
            //         textColor: Theme.of(context).hintColor,
            //         child: Text(S.of(context).i_dont_have_an_account),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
