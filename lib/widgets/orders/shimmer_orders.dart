
import 'package:flutter/material.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

import '../shimmer.dart';

class ShimmerOrders extends StatelessWidget {
  const ShimmerOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [_itemWidget(), _itemWidget()],
      ),
    );
  }

  Widget _itemWidget() {
    return Container(
      margin: EdgeInsets.all(ScreenUtil.getInstance().getPadding()),
      padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().getAdapterSize(12),
          bottom: ScreenUtil.getInstance().getAdapterSize(12),
          left: ScreenUtil.getInstance().getAdapterSize(12)),
      decoration: BoxDecoration(
          color: AppColor.colorBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _childItemWidget(percentOne: 0.3, percentTwo: 0.2),
            _paddingWidget(height: 10),
            _childItemWidget(percentOne: 0.15, percentTwo: 0.3),
            _paddingWidget(height: 10),
            _childItemWidget(percentOne: 0.25, percentTwo: 0.4),
            _paddingWidget(height: 10),
            Container(
              width: ScreenUtil.getInstance().screenWidth * 0.7,
              height: ScreenUtil.getInstance().getAdapterSize(20),
              color: Colors.white,
            ),
            _paddingWidget(height: 10),
            Container(
              width: ScreenUtil.getInstance().screenWidth * 0.4,
              height: ScreenUtil.getInstance().getAdapterSize(20),
              color: Colors.white,
            ),
            _paddingWidget(height: 10),
            Row(
              children: [
                Container(
                  width: ScreenUtil.getInstance().getAdapterSize(30),
                  height: ScreenUtil.getInstance().getAdapterSize(30),
                  color: Colors.white,
                ),
                _paddingWidget(width: 20),
                Container(
                  width: ScreenUtil.getInstance().screenWidth * 0.7,
                  height: ScreenUtil.getInstance().getAdapterSize(20),
                  color: Colors.white,
                ),
              ],
            ),
            _paddingWidget(height: 10),
            Row(
              children: [
                Container(
                  width: ScreenUtil.getInstance().getAdapterSize(30),
                  height: ScreenUtil.getInstance().getAdapterSize(30),
                  color: Colors.white,
                ),
                _paddingWidget(width: 20),
                Container(
                  width: ScreenUtil.getInstance().screenWidth * 0.7,
                  height: ScreenUtil.getInstance().getAdapterSize(20),
                  color: Colors.white,
                ),
              ],
            ),
            _paddingWidget(height: 10),
            Row(
              children: [
                Container(
                  width: ScreenUtil.getInstance().getAdapterSize(30),
                  height: ScreenUtil.getInstance().getAdapterSize(30),
                  color: Colors.white,
                ),
                _paddingWidget(width: 20),
                Container(
                  width: ScreenUtil.getInstance().screenWidth * 0.7,
                  height: ScreenUtil.getInstance().getAdapterSize(20),
                  color: Colors.white,
                ),
              ],
            ),
            _paddingWidget(height: 10),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: ScreenUtil.getInstance().screenWidth * 0.5,
                height: ScreenUtil.getInstance().getAdapterSize(20),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _childItemWidget(
      {required double percentOne, required double percentTwo}) {
    return Row(children: [
      Container(
        width: ScreenUtil.getInstance().screenWidth * percentOne,
        height: ScreenUtil.getInstance().getAdapterSize(20),
        color: Colors.white,
      ),
      const Spacer(),
      Container(
        width: ScreenUtil.getInstance().screenWidth * percentTwo,
        height: ScreenUtil.getInstance().getAdapterSize(20),
        color: Colors.white,
      )
    ]);
  }

  Widget _paddingWidget({double? height, double? width}) {
    return SizedBox(
        height: height != null
            ? ScreenUtil.getInstance().getAdapterSize(height)
            : 0,
        width:
            width != null ? ScreenUtil.getInstance().getAdapterSize(width) : 0);
  }
}
