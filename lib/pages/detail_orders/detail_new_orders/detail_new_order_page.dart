
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'detail_new_order_bloc.dart';

class DetailNewOrderPage extends BasePage<DetailNewOrderBloc>{
  static const routeName = '/DetailNewOrderPage';

  const DetailNewOrderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailNewOrderState();

}

class _DetailNewOrderState extends BasePageState<DetailNewOrderPage, BaseBloc>{
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
