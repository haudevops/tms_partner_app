
import 'package:flutter/material.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/constants.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class NameAndStatusOderWidget extends StatelessWidget {
  const NameAndStatusOderWidget({Key? key, required this.orderModel})
      : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: !orderModel.isGrouped() &&
              orderModel.deliveryType != null &&
              orderModel.deliveryType!.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Constants.deliveryType[orderModel.deliveryType]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(orderModel.deliveryType ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.getInstance().getAdapterSize(12))),
            ),
          ),
        ),
        _nameOrderWidget(orderModel),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Constants.orderStatusColor[orderModel.status]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              Constants.orderStatus[orderModel.status] ?? '',
              style: TextStyle(
                  color: Constants.orderTextStatusColor[orderModel.status],
                  fontSize: ScreenUtil.getInstance().getAdapterSize(10)),
            ),
          ),
        )
      ],
    );
  }

  Widget _nameOrderWidget(OrderModel order) {
    String title = '';
    if (order.isGrouped()) {
      if (OrderUtils.isOrderWin(order)) {
        title =
            '${S.current.group.toUpperCase()} (${order.getPackageInGroup().totalPackage} ${S.current.package.toUpperCase()})';
      } else {
        title =
            '${S.current.group.toUpperCase()} (${order.groups?.length ?? 0} ${S.current.order_single.toUpperCase()})';
      }
    } else {
      if (OrderUtils.isOrderWin(order)) {
        title =
            '${order.code} (${(order.packages?.totalPackage != null && order.packages!.totalPackage! > 0) ? order.packages?.totalPackage : 1} ${S.current.package.toUpperCase()})';
      } else {
        title = '${order.code ?? 0}';
      }
    }

    return Text(title,
        style: TextStyle(
            fontSize: ScreenUtil.getInstance().getAdapterSize(15),
            color: AppColor.colorTitle,
          fontWeight: FontWeight.w800
        ));
  }
}
