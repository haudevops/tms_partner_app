import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget getLoadingWidget() {
  return Center(
    child: SizedBox(
      width: 80,
      height: 80,
      child: Lottie.asset('assets/image/loading_lottie.json')
    )
  );
}