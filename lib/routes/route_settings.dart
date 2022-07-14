import 'package:flutter/material.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import 'screen_arguments.dart';
import 'slide_left_route.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    late ScreenArguments arg;
    final Object? arguments = settings.arguments;
    if (arguments != null) {
      arg = arguments as ScreenArguments;
    }
    switch (settings.name) {
      case SplashPage.routeName:
        return SlideLeftRoute( SplashPage());
      case NavigationPage.routeName:
        return SlideLeftRoute(NavigationPage());
      case LoginPage.routeName:
        return SlideLeftRoute(LoginPage());
      case SettingPage.routeName:
        return SlideLeftRoute(SettingPage());
      case ScanPage.routeName:
        return SlideLeftRoute(ScanPage(arguments: arg));
      case ChangePasswordPage.routerName:
        return SlideLeftRoute(ChangePasswordPage());
      case UserInfoPage.routeName:
        return SlideLeftRoute(UserInfoPage(data: arg));
      case OrderHistoryPage.routeName:
        return SlideLeftRoute(OrderHistoryPage());
      case DetailAcceptedOrderPage.routeName:
        return SlideLeftRoute(DetailAcceptedOrderPage(arguments: arg));
      case DetailIncidentOrderPage.routeName:
        return SlideLeftRoute(DetailIncidentOrderPage());
      case DetailNewOrderPage.routeName:
        return SlideLeftRoute(DetailNewOrderPage());
      case ShareCodePage.routeName:
        return SlideLeftRoute(ShareCodePage(
          data: arg,
        ));
      case OrderStatusFilterPage.routeName:
        return SlideLeftRoute(OrderStatusFilterPage(arg));
      case DetailPointPage.routeName:
        return SlideLeftRoute(DetailPointPage(data: arg));
      case ConfirmPickGoodsSuccessPage.routeName:
        return SlideLeftRoute(ConfirmPickGoodsSuccessPage(arguments: arg));
      default:
        throw ('this route name does not exist');
    }
  }
}