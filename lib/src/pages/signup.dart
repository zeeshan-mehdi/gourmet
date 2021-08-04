import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../elements/MobileVerificationBottomSheetWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  UserController _con;

  _SignUpWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(29.5),
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(16),
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(29.5),
                child: Text(
                  // S.of(context).lets_start_with_register,
                  "Create an account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .merge(TextStyle(color: Colors.black)),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(22) - 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50,
                            color: Colors.transparent,
                          )
                        ]),
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
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius:
                                BorderRadius.all(Radius.circular(40)),
                                //  border: Border(),
                                // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (input) => _con.user.name = input,
                                validator: (input) => input.length < 3
                                    ? S
                                    .of(context)
                                    .should_be_more_than_3_letters
                                    : null,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  // labelText: S.of(context).email,
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(
                                      left: 14, right: 12, top: 6, bottom: 6),
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  //hintText: S.of(context).john_doe,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  // prefixIcon: Icon(Icons.person_outline,
                                  //     color: Theme.of(context).accentColor),
                                  // border: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.2))),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.5))),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.2))),
                                ),
                              )),
                          SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                              //  border: Border(),
                              // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) => _con.user.email = input,
                              validator: (input) => !input.contains('@')
                                  ? S.of(context).should_be_a_valid_email
                                  : null,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                // labelText: S.of(context).email,
                                labelStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                    left: 14, right: 12, top: 6, bottom: 6),
                                border: InputBorder.none,
                                //hintText: 'johndoe@gmail.com',
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                // prefixIcon: Icon(Icons.alternate_email,
                                //     color: Theme.of(context).accentColor),
                                // border: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.2))),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.5))),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.2))),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                              //  border: Border(),
                              // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              onSaved: (input) => _con.user.phone = input,
                              validator: (input) {
                                print(input.startsWith('\+'));
                                return !input.startsWith('\+') &&
                                    !input.startsWith('00')
                                    ? "Should be valid mobile number with country code"
                                    : null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                // labelText: S.of(context).email,
                                labelStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                    left: 14, right: 12, top: 6, bottom: 6),
                                border: InputBorder.none,
                                // hintText: '+1 623-648-8699',
                                hintText: "Phone",
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                // prefixIcon: Icon(Icons.phone_android,
                                //     color: Theme.of(context).accentColor),
                                // border: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.2))),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.5))),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.2))),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                              //  border: Border(),
                              // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) => _con.user.address = input,
                              validator: (input) => input.length < 3
                                  ? S
                                  .of(context)
                                  .should_be_more_than_3_letters
                                  : null,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                // labelText: S.of(context).email,
                                labelStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                    left: 14, right: 12, top: 6, bottom: 6),
                                border: InputBorder.none,
                                hintText: 'Date of birth',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                // prefixIcon: Icon(Icons.alternate_email,
                                //     color: Theme.of(context).accentColor),
                                // border: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.2))),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.5))),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Theme.of(context)
                                //             .focusColor
                                //             .withOpacity(0.2))),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius:
                                BorderRadius.all(Radius.circular(40)),
                                //  border: Border(),
                                // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                              ),
                              child: TextFormField(
                                obscureText: _con.hidePassword,
                                onSaved: (input) => _con.user.password = input,
                                validator: (input) => input.length < 6
                                    ? S
                                    .of(context)
                                    .should_be_more_than_6_letters
                                    : null,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  // labelText: S.of(context).email,
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(
                                      left: 14, right: 12, top: 14, bottom: 6),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  // prefixIcon: Icon(Icons.lock_outline,
                                  //     color: Theme.of(context).accentColor),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _con.hidePassword = !_con.hidePassword;
                                      });
                                    },
                                    color: Theme.of(context).focusColor,
                                    icon: Icon(_con.hidePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  // border: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.2))),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.5))),
                                  // enabledBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Theme.of(context)
                                  //             .focusColor
                                  //             .withOpacity(0.2))),
                                ),
                              )),
                          SizedBox(height: 30),
                          BlockButtonWidget(
                            text: Text(
                              S.of(context).register,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              if (_con.loginFormKey.currentState.validate()) {
                                ScaffoldMessenger.of(_con.scaffoldKey.currentContext).showSnackBar(SnackBar(
                                  content: Text("sending sms to ${_con.user.phone})"),
                                ));
                                _con.loginFormKey.currentState.save();
                                var bottomSheetController = _con
                                    .scaffoldKey.currentState
                                    .showBottomSheet(
                                      (context) =>
                                      MobileVerificationBottomSheetWidget(
                                          scaffoldKey: _con.scaffoldKey,
                                          user: _con.user),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                );
                                bottomSheetController.closed.then((value) {
                                  _con.register();
                                });
                              }
                            },
                          ),

                          SizedBox(height: 25),
                          Text(
                            // S.of(context).lets_start_with_register,
                            "By clicking Sign up you agree to the following",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(color: Colors.black)),
                          ),
                          Text(" Trems and Conditions",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(color: Colors.black)))
//                      MaterialButton(elevation:0,
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/MobileVerification');
//                        },
//                        padding: EdgeInsets.symmetric(vertical: 14),
//                        color: Theme.of(context).accentColor.withOpacity(0.1),
//                        shape: StadiumBorder(),
//                        child: Text(
//                          'Register with Google',
//                          textAlign: TextAlign.start,
//                          style: TextStyle(
//                            color: Theme.of(context).accentColor,
//                          ),
//                        ),
//                      ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // MaterialButton(
                  //   elevation: 0,
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/Login');
                  //   },
                  //   textColor: Theme.of(context).hintColor,
                  //   child: Text(S.of(context).i_have_account_back_to_login),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
