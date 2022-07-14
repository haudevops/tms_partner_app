
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'detail_new_order_bloc.dart';

class DetailNewOrderPage extends BasePage<DetailNewOrderBloc>{
  static const routeName = '/DetailNewOrderPage';

  DetailNewOrderPage({Key? key});

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _DetailNewOrderState();

}

class _DetailNewOrderState extends BasePageState<DetailNewOrderPage>{
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
