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
  final Completer<GoogleMapController> _controller = Completer();
  late HomeBloc _bloc;

  double? _latitude;
  double? _longitude;
  late Set<Marker> markers = {};


  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo_supra_black.png',
            width: ScreenUtil.getInstance().getWidth(100),
            height: ScreenUtil.getInstance().getHeight(30)),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: Container(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        color: AppColor.colorWhiteDark,
        child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          zoomControlsEnabled: true,
          tiltGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(_latitude ?? 0, _longitude ?? 0),
            zoom: 14,
          ),
          onMapCreated: onMapCreated,
          onTap: (LatLng location) {},
          markers: markers,
        ),
      ),
    );
  }

  @override
  void onCreate() {
    _bloc = getBloc();

    _bloc.locationStream.listen((position) async {
      _latitude = position.latitude;
      _longitude = position.longitude;

      markers = {
        Marker(
          markerId: MarkerId('aaaa'),
          position: LatLng(_latitude ?? 0, _longitude ?? 0),
          infoWindow: const InfoWindow(
            //popup info
            title: 'My Custom Title ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker,
        )
      };
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
