import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';

import 'detail_incident_order_bloc.dart';

class DetailIncidentOrderPage extends BasePage<DetailIncidentOrderBloc> {
  static const routeName = '/DetailIncidentOrderPage';

  const DetailIncidentOrderPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _DetailIncidentOrderState();
}

class _DetailIncidentOrderState extends BasePageState<DetailIncidentOrderPage, BaseBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    throw UnimplementedError();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
