import 'package:markets/restaurent_app/src/pages/HomeScreen.dart';
import 'package:markets/restaurent_app/src/pages/markets.dart';
import 'package:markets/restaurent_app/src/pages/menuGridScreen.dart';
import 'package:markets/restaurent_app/src/pages/notifications.dart';
import 'package:markets/restaurent_app/src/pages/order_edit.dart';
import 'package:markets/restaurent_app/src/pages/pages.dart';
import 'package:markets/src/pages/LoginOption.dart';
import 'package:markets/src/pages/MemberShip.dart';
import 'package:markets/src/pages/SplashForNewUser.dart';
import 'package:markets/src/pages/gridMenuScreen.dart';
import 'package:markets/src/pages/kitchen_profile.dart';
import 'package:markets/src/pages/my_fatoorah.dart';
import 'package:markets/src/pages/qr_code_scanner.dart';

import 'src/models/route_argument.dart';
import 'src/pages/Cuisines.dart';
import 'src/pages/CuisinesDetail.dart';
import 'src/pages/FilterPage.dart';
import 'src/pages/cart.dart';
import 'src/pages/category.dart';
import 'src/pages/chat.dart';
import 'src/pages/checkout.dart';
import 'src/pages/debug.dart';
import 'src/pages/delivery_addresses.dart';
import 'src/pages/delivery_pickup.dart';
import 'src/pages/details.dart';
import 'src/pages/favorites.dart';
import 'src/pages/forget_password.dart';
import 'src/pages/help.dart';
import 'src/pages/languages.dart';
import 'src/pages/login.dart';
import 'src/pages/menu_list.dart';
import 'src/pages/mobile_verification_2.dart';
import 'src/pages/order_success.dart';
import 'src/pages/pages.dart';
import 'src/pages/payment_methods.dart';
import 'src/pages/paypal_payment.dart';
import 'src/pages/product.dart';
import 'src/pages/profile.dart';
import 'src/pages/razorpay_payment.dart';
import 'src/pages/reviews.dart';
import 'src/pages/settings.dart';
import 'src/pages/signup.dart';
import 'src/pages/splash_screen.dart';
import 'src/pages/tracking.dart';
import 'package:flutter/material.dart';
// restaurent app imports

import 'restaurent_app/src/pages/details.dart' as restDetails;
import 'restaurent_app/src/pages/order.dart' as restOrders;
import 'restaurent_app/src/pages/order_edit.dart' as restOrderEdit;
import 'restaurent_app/src/pages/chat.dart' as restChat;




class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Debug':
        return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification2':
        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/qr_code':
        return MaterialPageRoute(builder: (_) => QRCodeScanner());
      case '/Profile':
         return MaterialPageRoute(builder: (_) => KitchenProfile());
      // case '/Profile':
      //   return MaterialPageRoute(builder: (_) => ProfileWidget());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Favorites':
        return MaterialPageRoute(builder: (_) => FavoritesWidget());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => ChatWidget(routeArgument: args as RouteArgument));
      case '/Details':
        return MaterialPageRoute(builder: (_) => DetailsWidget(currentTab: args));
      case '/Menu':
        return MaterialPageRoute(builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
      case '/Product':
        return MaterialPageRoute(builder: (_) => ProductWidget(routeArgument: args as RouteArgument));
      case '/HomeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen(routeArgument: args as RouteArgument));
      case '/menuGrid':
        return MaterialPageRoute(builder: (_) => MenuGridScreen(routeArgument: args as RouteArgument));
      case '/GridMenu':
        return MaterialPageRoute(builder: (_) => GridScreen(routeArgument: args as RouteArgument));
      case '/Category':
        return MaterialPageRoute(builder: (_) => CategoryWidget(routeArgument: args as RouteArgument));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget(routeArgument: args as RouteArgument));
      case '/Tracking':
        return MaterialPageRoute(builder: (_) => TrackingWidget(routeArgument: args as RouteArgument));
      case '/Reviews':
        return MaterialPageRoute(builder: (_) => ReviewsWidget(routeArgument: args as RouteArgument));
      case '/PaymentMethod':
        return MaterialPageRoute(builder: (_) => PaymentMethodsWidget(routeArgument: args as RouteArgument));
      case '/DeliveryAddresses':
        return MaterialPageRoute(builder: (_) => DeliveryAddressesWidget());
      case '/DeliveryPickup':
        return MaterialPageRoute(builder: (_) => DeliveryPickupWidget(routeArgument: args as RouteArgument));
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());
      case '/CashOnDelivery':
        return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: RouteArgument(param: 'Cash on Delivery')));
      case '/PayOnPickup':
        return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: RouteArgument(param: 'Pay on Pickup')));
      case '/PayPal':
        return MaterialPageRoute(builder: (_) => PayPalPaymentWidget(routeArgument: args as RouteArgument));
      case '/RazorPay':
        return MaterialPageRoute(builder: (_) => RazorPayPaymentWidget(routeArgument: args as RouteArgument));
      case '/OrderSuccess':
        return MaterialPageRoute(builder: (_) => OrderSuccessWidget(routeArgument: args as RouteArgument));
      case '/myFatoorah':
        return MaterialPageRoute(builder: (_) => MyFatoorah(routeArgument: args as RouteArgument));
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      case '/LoginOption':
        return MaterialPageRoute(builder: (_) => LoginOption());
      case '/SplashForNewUser':
        return MaterialPageRoute(builder: (_) => SplashForNewUserScreen());
      case '/RestaurantsMemberShip':
        return MaterialPageRoute(builder: (_) => RestaurantsMemberShip());
        // case '/Coisines':
        // return MaterialPageRoute(builder: (_) => Coisines(cuisinesItems: ,));

        case '/CoisinesDetail':
        return MaterialPageRoute(builder: (_) => CoisinesDetail());
        case '/FilterPage':
        return MaterialPageRoute(builder: (_) => FilterPage());


      //***************************************Restaurent App Routes ***********************************************//


      case '/RestaurantDetails':
        return MaterialPageRoute(builder: (_) => restDetails.DetailsWidget(routeArgument: args));
      case '/RestaurantOrderDetails':
        return MaterialPageRoute(builder: (_) => restOrders.OrderWidget(routeArgument: args));
      case '/RestaurantOrderEdit':
        return MaterialPageRoute(builder: (_) => restOrderEdit.OrderEditWidget(routeArgument: args ));
      case '/RestaurantChat':
        return MaterialPageRoute(builder: (_) => restChat.ChatWidget(routeArgument: args ));
      case '/KitchenNotifications':
        return MaterialPageRoute(builder: (_) => NotificationsWidget());
      // case '/RestaurantPages':
      //   return MaterialPageRoute(builder: (_) => MarketsWidget(parentScaffoldKey: args));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
