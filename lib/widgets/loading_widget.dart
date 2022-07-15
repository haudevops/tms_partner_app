import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget getLoadingWidget() {
  return Center(
    child: SizedBox(
      width: 200,
      height: 200,
      child: Lottie.asset('assets/images/delivery_lottie.json')
    )
  );
}