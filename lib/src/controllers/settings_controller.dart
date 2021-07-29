import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/src/models/general_settings.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/user_repository.dart' as userRepo;

import  'package:markets/generated/l10n.dart';
import '../models/credit_card.dart';
import '../models/user.dart' as userModel;
import '../pages/mobile_verification_2.dart';
import '../repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  CreditCard creditCard = new CreditCard();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  String key;
  GeneralSettings generalSettings;
  SharedPreferences instance;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    generalSettings = GeneralSettings('sdfjsldkf sldkf asflkjsdfsdf', 5);
    getKey();
  }

  saveKey(newKey,time)async{
    if(instance==null) instance = await SharedPreferences.getInstance();

      instance.setString('key', newKey);
      instance.setInt('time', time);
      key = newKey;
      generalSettings.myFatoorahApiKey = key;
      generalSettings.time = time;
      setState(() {
        try {
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(
              SnackBar(
                content: Text('General Settings Updated'),
              ));
        }catch(e) {
           Fluttertoast.showToast(msg: 'General Settings Updated');
        }
      });

  }

  void getKey() async{
    if(instance==null) instance = await SharedPreferences.getInstance();

    key = instance.get('key');
    generalSettings.time = instance.get('time')??5;


    generalSettings.myFatoorahApiKey = key??'sdkfjsdf sdlfjsdfksdf sldjfs dfsldkfj';
    setState(() { });
  }

  Future<void> verifyPhone(userModel.User user) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      repository.currentUser.value.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      repository.currentUser.value.verificationId = verId;
      Navigator.push(
        scaffoldKey.currentContext,
        MaterialPageRoute(
            builder: (context) => MobileVerification2(
                  onVerified: (v) {
                    Navigator.of(scaffoldKey.currentContext).pushNamed('/Settings');
                  },
                )),
      );
    };
    final PhoneVerificationCompleted _verifiedSuccess = (AuthCredential auth) {
      Navigator.of(scaffoldKey.currentContext).pushNamed('/Settings');
    };
    final PhoneVerificationFailed _verifyFailed = (FirebaseAuthException e) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
      print(e.toString());
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: user.phone,
      timeout: const Duration(seconds: 5),
      verificationCompleted: _verifiedSuccess,
      verificationFailed: _verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  void update(userModel.User user) async {
    user.deviceToken = null;
    repository.update(user).then((value) {
      setState(() {});
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).profile_settings_updated_successfully),
      ));
    });
  }
  updateMembership(User user,lang,context)async{
    await MyFatoorah.startPayment(
      context: context,
      errorChild:const Center(
        child: Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 50,
        ),
      ),
      succcessChild: const Center(
        child: Icon(
          Icons.done_all,
          color: Colors.greenAccent,
          size: 50,
        ),
      ),
      request: MyfatoorahRequest.test(

        token:
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
        currencyIso: Country.Kuwait,
        successUrl:
        'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
        errorUrl:
        'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
        invoiceAmount: 100*100.0,
        language: lang=='en'? ApiLanguage.English : ApiLanguage.Arabic,
      ),
    ).then((PaymentResponse response) async{

      if(response.isSuccess){
        userRepo.currentUser.value.memebership = 1;
        userRepo.currentUser.value.trialEnds = DateTime.now().add(Duration(days: 30)).toString();
        update(userRepo.currentUser.value);
      }else if(response.isError){
        Fluttertoast.showToast(msg: 'Payment Failed please try again!!');
        return;
      }else if(response.status==PaymentStatus.None){
        Fluttertoast.showToast(msg: 'Payment Failed please try again!!');
        return;
      }


    }).catchError((e){
      Fluttertoast.showToast(msg: 'Payment Failed please try again!! ${e}');
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    repository.setCreditCard(creditCard).then((value) {
      setState(() {});
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).payment_settings_updated_successfully),
      ));
    });
  }

  void listenForUser() async {
    creditCard = await repository.getCreditCard();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    creditCard = new CreditCard();
  }
}
