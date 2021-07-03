import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

import '../../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/coupon.dart';
import '../models/credit_card.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/payment.dart';
import '../models/product_order.dart';
import '../repository/order_repository.dart' as orderRepo;
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;
import 'cart_controller.dart';

class MyFatoorahController extends CartController {
  Payment payment;
  CreditCard creditCard = new CreditCard();
  bool loading = true;


  MyFatoorahController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCreditCard();
  }



  void listenForCreditCard() async {
    creditCard = await userRepo.getCreditCard();
    setState(() {});
  }

  @override
  void onLoadingCartDone(){

   // if (payment != null) {
      loadPayment();
  //  }


      print('i am in');
    //setState(() {loading=false;});


    super.onLoadingCartDone();
  }

  void addOrder(List<Cart> carts) async {
    Order _order = new Order();
    _order.productOrders = <ProductOrder>[];
    _order.tax = carts[0].product.market.defaultTax;
    _order.deliveryFee = payment.method == 'Pay on Pickup' ? 0 : carts[0].product.market.deliveryFee;
    OrderStatus _orderStatus = new OrderStatus();
    //if(carts[0].product.market.autoAccept==1||carts[0].product.market.isPaid==0)
      _orderStatus.id = '1';
    // else
    //   _orderStatus.id = '6';// TODO default order status Id

    _order.orderStatus = _orderStatus;
    _order.deliveryAddress = settingRepo.deliveryAddress.value;
    _order.hint = ' ';
    carts.forEach((_cart) {
      ProductOrder _productOrder = new ProductOrder();
      _productOrder.quantity = _cart.quantity;
      _productOrder.price = _cart.product.price;
      _productOrder.product = _cart.product;
      _productOrder.options = _cart.options;
      _order.productOrders.add(_productOrder);
    });
    orderRepo.addOrder(_order, this.payment).then((value) async {
      settingRepo.coupon = new Coupon.fromJSON({});
      return value;
    }).then((value) {
      if (value is Order) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    userRepo.setCreditCard(creditCard).then((value) {
      setState(() {});
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).payment_card_updated_successfully),
      ));
    });
  }

  void loadPayment() async {
    print('i am loading payment');
    var lang = settingRepo.setting.value.mobileLanguage.value.languageCode;
    await MyFatoorah.startPayment(
      context: scaffoldKey?.currentContext,
      errorChild: const Center(
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
        invoiceAmount: 100 * 100.0,
        language: lang == 'en' ? ApiLanguage.English : ApiLanguage.Arabic,
      ),
    ).then((PaymentResponse response) async {
      if (response.isSuccess) {
          addOrder(carts);
        // user.memebership = 1;
        // user.trialEnds = DateTime.now().add(Duration(days: 30)).toString();
        // update(user);
      } else if (response.isError) {
        // setState(() {
        //   loading = false;
        // });
        Navigator.of(scaffoldKey?.currentContext).pushNamed('/Pages', arguments: 3);
        Fluttertoast.showToast(msg: 'Payment Failed please try again!!');
        return;
      } else if (response.status == PaymentStatus.None) {
        Navigator.of(scaffoldKey?.currentContext).pushNamed('/Pages', arguments: 3);

        Fluttertoast.showToast(msg: 'Payment Failed please try again!!');
        return;
      }
    }).catchError((e) {
      Navigator.of(scaffoldKey?.currentContext).pushNamed('/Pages', arguments: 3);

      Fluttertoast.showToast(msg: 'Payment Failed please try again!! ${e}');
    });
  }
}
