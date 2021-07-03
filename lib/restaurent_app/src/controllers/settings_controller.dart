import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:shared_preferences/shared_preferences.dart';

import  'package:markets/generated/l10n.dart';
import '../models/credit_card.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  CreditCard creditCard = new CreditCard();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  SharedPreferences sp;
  bool autoAccept = false;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    initSharePreferences();
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
        user.memebership = 1;
        user.trialEnds = DateTime.now().add(Duration(days: 30)).toString();
        update(user);
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

  void initSharePreferences()async{
    sp = await SharedPreferences.getInstance();
    autoAccept = await sp.getBool('auto_accept')??false;

    setState(() {});
  }

  void update(User user) async {
    user.deviceToken = null;
    repository.update(user).then((value) {
      setState(() {
        //this.favorite = value;
      });
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).profile_settings_updated_successfully),
      ));
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

  Future updateAutoAccept(bool val)async{
    await sp.setBool('auto_accept', val);
    autoAccept = await sp.getBool('auto_accept');
    setState(() { });
  }
}
