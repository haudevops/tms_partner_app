import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/prefs_const.dart';
import 'package:tms_partner_app/utils/prefs_util.dart';
import 'package:tms_partner_app/widgets/keep_alive_page.dart';

import '../../base/base_bloc.dart';
import '../../base/base_page.dart';
import '../pages.dart';

class NavigationPage extends BasePage {
  NavigationPage({Key? key}) : super(key: key, bloc: NavigationBloc());
  static const routeName = '/NavigationPage';


  @override
  State<StatefulWidget> createState() => _NavigationPageState();
}

class _NavigationPageState extends BasePageState<NavigationPage, BaseBloc> {
  late PageController _pageController;
  late NavigationBloc _bloc;
  int _selectedIndex = 0;
  Location _location = Location();

  void _updateTabSelection(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 10), curve: Curves.ease);
    });
  }

  void _pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void onCreate() {
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    // _bloc = getBloc();
    _locationRequest();
  }

  Future<void> _locationRequest() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        _location.changeNotificationOptions(
            channelName: 'Kênh thông báo EtonX',
            title: 'Vị trí được sử dụng để nhận đơn hàng mới',
            description: 'EtonX đang sử dụng vị trí của bạn',
            iconName: 'assets/icon/etonx_logo_white.png');
        _location.enableBackgroundMode(enable: true);
      } else {
        return;
      }
    }

    int? _timeInterval = PrefsUtil.getInt(PrefsCache.LOCATION_INTERVAL);
    _location.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: (_timeInterval != null && _timeInterval > 0)
            ? _timeInterval * 10000
            : Constants.UPDATE_INTERVAL_IN_MILLISECONDS);

    _location.onLocationChanged.listen((LocationData currentLocation) {
      // _bloc.sendLocation(currentLocation);
    });
  }

  @override
  void onDestroy() {
    _pageController.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBarWidget(),
      body: _pageView(),
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _navigationBarItem(
            icon: 'assets/icon/ic_navigation_orders.svg',
            label: S.of(context).navigation_order),
        _navigationBarItem(
            icon: 'assets/icon/ic_navigation_home.svg',
            label: S.of(context).navigation_home),
        _navigationBarItem(
            icon: 'assets/icon/ic_navigation_notifications.svg',
            label: S.of(context).navigation_notification),
        _navigationBarItem(
            icon: 'assets/icon/ic_navigation_menu.svg',
            label: S.of(context).navigation_more)
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColor.colorPrimaryButton,
      onTap: _updateTabSelection,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      backgroundColor: AppColor.colorWhiteDark,
    );
  }

  Widget _pageView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: _pageChanged,
      children: <Widget>[
        KeepAlivePage(child: OrdersPage()),
        KeepAlivePage(child: HomePage()),
        KeepAlivePage(child: NotificationPage()),
        KeepAlivePage(child: MenuPage())
      ],
    );
  }

  BottomNavigationBarItem _navigationBarItem(
      {required String icon, required String label}) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(icon, color: Colors.grey),
        label: label,
        activeIcon: SvgPicture.asset(icon, color: AppColor.colorPrimaryButton));
  }
}
