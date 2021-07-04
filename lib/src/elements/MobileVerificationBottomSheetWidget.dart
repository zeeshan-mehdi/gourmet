import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;
import '../models/user.dart' as userModel;
import '../repository/user_repository.dart';
import 'BlockButtonWidget.dart';

class MobileVerificationBottomSheetWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final userModel.User user;

  MobileVerificationBottomSheetWidget({Key key, this.scaffoldKey, this.user})
      : super(key: key);

  @override
  _MobileVerificationBottomSheetWidgetState createState() =>
      _MobileVerificationBottomSheetWidgetState();
}

class _MobileVerificationBottomSheetWidgetState
    extends State<MobileVerificationBottomSheetWidget> {
  String smsSent;
  String errorMessage;

  @override
  void initState() {
    verifyPhone();
    super.initState();
  }

  verifyPhone() async {
    print('sending sms to ${widget.user.phone}');
    currentUser.value.verificationId = '';
    smsSent = '';
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {};
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      print('code sent');
      currentUser.value.verificationId = verId;
    };
    final PhoneVerificationCompleted _verifiedSuccess =
        (AuthCredential auth) { };
    final PhoneVerificationFailed _verifyFailed = (FirebaseAuthException e) {
      print('code sending falied $e');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.user.phone,
      timeout: const Duration(seconds: 5),
      verificationCompleted: _verifiedSuccess,
      verificationFailed: _verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: config.App(context).appHeight(100),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.4),
              blurRadius: 30,
              offset: Offset(0, -30)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListView(
              padding:
                  EdgeInsets.only(top: 40, bottom: 15, left: 20, right: 20),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 70),
                    Text(
                      "Phone Verification",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 34,
                      ),
                      //  style: Theme.of(context).textTheme.headline1.merge(Fo),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    errorMessage == null
                        ? Text(
                            "Enter your OTP code here",
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            errorMessage ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(color: Colors.redAccent)),
                            textAlign: TextAlign.center,
                          ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  // color: Colors.grey,
                 // height: 70,
                 // width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    //  border: Border(),
                    // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 32),
                      child: PinCodeTextField(
                        appContext: context,

                        pastedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: false,
                        obscuringCharacter: '*',

                        animationType: AnimationType.fade,
                        // validator: (v) {
                        //   if (v.length < 3) {
                        //     return "I'm from validator";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(40),
                          fieldHeight: config.App(context).appWidth(15),
                          fieldWidth:config.App(context).appWidth(15),
                          activeFillColor: Colors.grey.withOpacity(0.3),
                          activeColor: Colors.grey.withOpacity(0.3),
                          selectedFillColor: Colors.grey.withOpacity(0.3),
                          selectedColor: Colors.grey.withOpacity(0.3),
                          inactiveFillColor : Colors.grey.withOpacity(0.3),
                          inactiveColor : Colors.grey.withOpacity(0.3),

                          //activeFillColor: hasError ? Colors.white : Colors.white,
                        ),
                        cursorColor: Colors.white,
                        //  animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 24,
                            color: Colors.white,
                            height: 1.6),
                        backgroundColor: Colors.white,
                        enableActiveFill: false,
                        enablePinAutofill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.phone,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.grey.withOpacity(0.3),
                            //blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");

                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )
                  ),
                  // TextField(
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline1
                  //       .merge(TextStyle(letterSpacing: 15)),
                  //   textAlign: TextAlign.center,
                  //   // decoration: new InputDecoration(
                  //   //                     //   enabledBorder: UnderlineInputBorder(
                  //   //                     //     borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2)),
                  //   //                     //   ),
                  //   //                     //   focusedBorder: new UnderlineInputBorder(
                  //   //                     //     borderSide: new BorderSide(
                  //   //                     //       color: Theme.of(context).focusColor.withOpacity(0.3),
                  //   //                     //     ),
                  //   //                     //   ),
                  //   //                     //
                  //   //                     //   hintText: '------',
                  //   //                     // ),
                  //   decoration: InputDecoration(
                  //     fillColor: Colors.red,
                  //     // labelText: S.of(context).email,
                  //     labelStyle: TextStyle(color: Colors.grey),
                  //     contentPadding: EdgeInsets.only(
                  //         left: 14, right: 12, top: 14, bottom: 6),
                  //     border: InputBorder.none,
                  //   ),
                  //   onChanged: (value) {
                  //     this.smsSent = value;
                  //   },
                  // ),
                ),
                SizedBox(height: 50),
                Text(
                  "Did you received any code?",
                  //widget.user.phone,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Center(
                  child: InkWell(
                    onTap: () async {
                      User user = FirebaseAuth.instance.currentUser;
                      print(user.toString());
                      print(currentUser.value.verificationId);
                      final AuthCredential credential =
                      
                      PhoneAuthProvider.credential(
                          verificationId: currentUser.value.verificationId,
                          smsCode: smsSent);

                      await FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((user) {
                        currentUser.value.verifiedPhone = true;
                        widget.user.verifiedPhone = true;
                        Navigator.of(widget.scaffoldKey.currentContext).pop();
                      }).catchError((e) {
                        setState(() {
                          errorMessage = e.toString().split('\]').last;
                        });
                        print(e.toString());
                      });
                    },
                    //color: Theme.of(context).accentColor,
                    child: Text("Resend a new Code",
                        style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(color: Theme.of(context).accentColor))),
                  ),
                )


              ],
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: 13, horizontal: config.App(context).appWidth(42)),
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
