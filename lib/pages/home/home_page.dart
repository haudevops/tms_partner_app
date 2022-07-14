import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/providers/theme_provider.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/utils/style_google_map.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class HomePage extends BasePage<HomeBloc> {
  HomePage({Key? key}) : super(bloc: HomeBloc());

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  bool _isOnline = false;
  Completer<GoogleMapController> _controller = Completer();
  HomeBloc? _bloc;

  @override
  Widget buildWidget(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo_supra_white.png',
            width: ScreenUtil.getInstance().getWidth(100),
            height: ScreenUtil.getInstance().getHeight(30)),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
        actions: [
          Switch(
              value: _isOnline,
              activeColor: Colors.lightGreen,
              onChanged: (value) {
                setState(() {
                  _isOnline = !_isOnline;
                  provider.toggleTheme(value);
                });
              })
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        zoomControlsEnabled: false,
        tiltGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 14,
        ),
        onMapCreated: onMapCreated,
        onTap: (LatLng location) {},
      ),
    );
  }

  @override
  void onCreate() {
    _bloc = getBloc();

    _bloc?.locationStream.listen((position) async {
      final GoogleMapController controller = await _controller.future;
      controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      )));
    });
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(MapStyle.mapStyles);
    _controller.complete(controller);
  }

  @override
  void onDestroy() {}
}
