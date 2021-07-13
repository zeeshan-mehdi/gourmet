import 'package:flutter/material.dart';
import 'package:markets/src/models/conversation.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/GlobalPopup.dart';

import '../../generated/l10n.dart';
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

class CheckoutController extends CartController {
  Payment payment;
  CreditCard creditCard = new CreditCard();
  bool loading = true;
  bool isPaid;
  bool autoAccept;

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCreditCard();
  }

  void listenForCreditCard() async {
    creditCard = await userRepo.getCreditCard();
    setState(() {});
  }

  @override
  void onLoadingCartDone() {
    if (payment != null) addOrder(carts);
    super.onLoadingCartDone();
  }

  void addOrder(List<Cart> carts) async {
    bool isOrderRequest = false;
    Order _order = new Order();
    _order.productOrders = <ProductOrder>[];
    _order.tax = carts[0].product.market.defaultTax;
    _order.deliveryFee = payment.method == 'Pay on Pickup' ? 0 : carts[0].product.market.deliveryFee;
    OrderStatus _orderStatus = new OrderStatus();
    if(carts[0].product.market.autoAccept==1||carts[0].product.market.isPaidKitchen==false)
      _orderStatus.id = '1';
    else {
      isOrderRequest = true;
      _orderStatus.id = '6'; // TODO default order status Id
    }

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
           if(isOrderRequest) {

             Navigator.of(scaffoldKey?.currentContext).pushNamed('/Chat',
                 arguments: RouteArgument(
                     param: new Conversation(
                         carts[0].product.market.users.map((e) {
                           e.image = carts[0].product.market.image;
                           return e;
                         }).toList(),
                         name: carts[0].product.market.name)));


             //Navigator.of(scaffoldKey?.currentContext).pushNamed('/Pages', arguments: 4);
           }else{
             showDialog(
                 context: scaffoldKey.currentState.context,
                 builder: (_) => Container(
                     color: Color(0xFF8E9198),
                     child: GlobalPopup(
                       //for Forgot password case
                       // title: "Your password has \n been reset",
                       // subTitle:
                       // "You'll shortly receive an email with a \n code to setup a new password",
                       // imageName: "LockIconWithArrow.png",
                       // popupType: PopupType.forgotPassword,
                       // btnTitle: "Done",
                       // bottombtnTitle: "",

                       //for Enable Location case
                       // title: "Enable Your Location",
                       // subTitle:
                       // "Please allow to use your location to\n show nearby resturant on the map ",
                       // imageName: "EnablelocaitonIcon.png",
                       // popupType: PopupType.enableLocation,
                       // btnTitle: "Enable Location",
                       // bottombtnTitle: "",


                       //incase of order success
                       title: "Your order has \n been Placed!",
                       subTitle: "You can track the delivery in the \n \"Orders\" section"  ,
                       imageName: "OrderSuceccfullIcon.png",
                       popupType: PopupType.orderSucessfull,
                       btnTitle: "Check on Order",
                       bottombtnTitle: "Go to orders",
                     )));
           }
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
}
