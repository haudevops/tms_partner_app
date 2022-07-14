
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/common_utils/date_util.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/order/point_status_enum.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

import '../dash/dash_widget.dart';
import 'name_status_oder_widget.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget(
      {Key? key,
      required this.order,
      required this.globalKey,
      required this.onTapOrder,
      this.onTapExpand,
      this.onTapChild})
      : super(key: key);

  final OrderModel order;
  final GlobalKey globalKey;
  final GestureTapCallback? onTapExpand;
  final Function(OrderModel) onTapOrder;
  final Function(OrderModel)? onTapChild;

  @override
  Widget build(BuildContext context) {
    String? pointsExternalCode = OrderUtils.getPointsExternalCode(order);
    return Container(
      key: globalKey,
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().getPadding(),
          vertical: ScreenUtil.getInstance().getAdapterSize(5)),
      padding:
          EdgeInsets.only(bottom: ScreenUtil.getInstance().getAdapterSize(8)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.colorWhiteDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapOrder(order);
            },
            onDoubleTap: () {},
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().getAdapterSize(12),
                  left: ScreenUtil.getInstance().getAdapterSize(12)),
              child: Column(
                children: [
                  NameAndStatusOderWidget(orderModel: order),
                  _itemPadding(),
                  _titleWidget(
                      title: order.serviceName,
                      contentLeft: order.serviceType != ServiceType.INSTALL
                          ? '${order.detail?.distance}km - '
                          : '',
                      contentRight:
                          '${OrderUtils.getCurrencyText((order.groups != null && order.groups!.length > 1) ? OrderUtils.getTotalCost(order.groups!) : order.servicerCost)}'),
                  _itemPadding(),
                  _titleWidget(
                      title: DateUtil.convertTimeStamp(order.expectedTime),
                      color: AppColor.orderGreenLight,
                      contentLeft: '${S.of(context).collection} - ',
                      contentRight: OrderUtils.getTotalCod(order) != null
                          ? OrderUtils.getCurrencyText(OrderUtils.getTotalCod(order))
                          : null,
                      colorContentRight: AppColor.colorBlack),
                  _nameStoreAndExternalCode(
                      title: '${S.of(context).store_code}: ',
                      value: OrderUtils.getStoreCode(order)),
                  _nameStoreAndExternalCode(
                      title: '${S.of(context).externalCode}: ',
                      value: !order.isGrouped() &&
                              pointsExternalCode != null &&
                              pointsExternalCode.isNotEmpty
                          ? pointsExternalCode
                          : ''),
                  _nameStoreAndExternalCode(
                      title: '${S.of(context).number_of_so}: ',
                      value:
                          order.countSO <= 1 ? '' : order.countSO.toString()),
                  _itemPadding(),
                  _pointsWidget(order),
                  Visibility(
                      visible: order.isGrouped(),
                      child: Divider(
                          color: Colors.grey,
                          endIndent: ScreenUtil.getScaleW(context, 10))),
                ],
              ),
            ),
          ),
          Visibility(
            visible: order.isGrouped() && order.expandGroup,
            child: Column(
              children: _childOrder(order.groups, context),
            ),
          ),
          Visibility(
              visible: order.isGrouped(),
              child: GestureDetector(
                  onTap: onTapExpand,
                  child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).grouped_order_list,
                            style: TextStyle(
                                color: AppColor.colorBlue,
                                fontSize: ScreenUtil.getInstance()
                                    .getAdapterSize(12)),
                          ),
                          Icon(
                            order.expandGroup
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down_sharp,
                            color: AppColor.colorBlue)
                        ],
                      ))))
        ],
      ),
    );
  }

  Widget _titleWidget(
      {String? title,
      Color? color,
      String? contentLeft,
      String? contentRight,
      Color? colorContentRight}) {
    return Row(
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(14),
              color: color ?? AppColor.colorGray),
        ),
        const Spacer(),
        contentRight != null
            ? RichText(
                text: TextSpan(children: [
                TextSpan(
                    text: contentLeft ?? '',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                        color: AppColor.colorGray)),
                TextSpan(
                    text: contentRight,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                        color: colorContentRight ?? Colors.red,
                        fontWeight: FontWeight.bold))
              ]))
            : Container(),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget _nameStoreAndExternalCode({String? title, String? value}) {
    return value != null && value.isNotEmpty
        ? Container(
            width: ScreenUtil.getInstance().screenWidth,
            margin: const EdgeInsets.only(top: 8),
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: title ?? '',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                          color: Colors.black)),
                  TextSpan(
                      text: value.length > 13
                          ? '${value.substring(0, 13)}...'
                          : value,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          )
        : Container();
  }

  Widget _pointsWidget(OrderModel orderModel) {
    List<Point>? points = OrderUtils.getOrderPoints(orderModel);
    List<Widget> _listPointsWidget = [];

    if (points != null) {
      for (int i = 0; i < points.length; i++) {
        if (i == 0) {
          _listPointsWidget.add(_locationWidget(
              image: SvgPicture.asset('assets/icon/svg/ic_location_start.svg'),
              point: points[i]));
        } else if (i == points.length - 1) {
          _listPointsWidget.add(_locationWidget(
              point: points[i],
              image: SvgPicture.asset('assets/icon/svg/ic_flag.svg'),
              isLast: true));
        } else {
          _listPointsWidget.add(_locationWidget(
              point: points[i],
              image: SvgPicture.asset(
                'assets/icon/svg/ic_location.svg',
                color: Colors.grey,
              )));
        }
      }
    }

    return Column(
      children: _listPointsWidget,
    );
  }

  Widget _locationWidget(
      {required Widget image, required Point point, bool? isLast}) {
    Color? textColor;
    int actionType = PointStatusEnum.parse(point.status, point.type).actionType;
    switch (actionType) {
      case -1:
        textColor = Colors.red;
        break;
      case 0:
        textColor = AppColor.colorTextLocation;
        break;
      case 1:
        textColor = Colors.grey;
        break;
      default:
        textColor = AppColor.colorTextLocation;
        break;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            image,
            Dash(
                direction: Axis.vertical,
                length: 15,
                dashLength: isLast == null ? 2 : 0,
                dashColor: Colors.grey),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(point.location?.address ?? '',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(12),
                    color: textColor),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ),
        )
      ],
    );
  }

  List<Widget> _childOrder(
      List<OrderGroup>? orderGroups, BuildContext context) {
    List<Widget> _widgets = [];
    if (orderGroups == null) {
      return _widgets;
    }
    for (final item in orderGroups) {
      _widgets.add(_childOrderWidget(new OrderModel(
          isChildOrder: true,
          expandGroup: false,
          countSO: 0,
          id: item.id,
          detail: item.detail,
          servicerCost: item.servicerCost,
          externalCode: item.externalCode,
          deliveryType: item.deliveryType,
          packages: item.packages,
          code: item.code,
          status: item.status,
          expectedTime: item.expectedTime,
          serviceName: item.serviceName,
          groupPoints: item.points)));
    }
    return _widgets;
  }

  Widget _childOrderWidget(OrderModel order) {
    String? pointsExternalCode = OrderUtils.getPointsExternalCode(order);
    return GestureDetector(
      onTap: () {
        if (onTapChild != null) {
          onTapChild!(order);
        }
      },
      onDoubleTap: () {},
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().getAdapterSize(3),
            horizontal: ScreenUtil.getInstance().getAdapterSize(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            NameAndStatusOderWidget(orderModel: order),
            const SizedBox(height: 5),
            _titleWidget(
                title: order.serviceName,
                contentLeft: order.serviceType != ServiceType.INSTALL
                    ? '${order.detail?.distance}km - '
                    : '',
                contentRight:
                    '${OrderUtils.getCurrencyText((order.groups != null && order.groups!.length > 1) ? OrderUtils.getTotalCost(order.groups!) : order.servicerCost)}'),
            const SizedBox(height: 5),
            _titleWidget(
                title: DateUtil.convertTimeStamp(order.expectedTime),
                color: AppColor.orderGreenLight,
                contentLeft: '${S.current.collection} - ',
                contentRight: OrderUtils.getTotalCod(order) != null
                    ? OrderUtils.getCurrencyText(OrderUtils.getTotalCod(order))
                    : null,
                colorContentRight: AppColor.colorBlack),
            _nameStoreAndExternalCode(
                title: '${S.current.store_code}: ',
                value: OrderUtils.getStoreCode(order)),
            _nameStoreAndExternalCode(
                title: '${S.current.externalCode}: ',
                value: !order.isGrouped() &&
                        pointsExternalCode != null &&
                        pointsExternalCode.isNotEmpty
                    ? pointsExternalCode
                    : ''),
            _nameStoreAndExternalCode(
                title: '${S.current.number_of_so}: ',
                value: order.countSO <= 1 ? '' : order.countSO.toString()),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(8)),
            _pointsChildWidget(order),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(5)),
            Divider(
                color: Colors.grey,
                endIndent: ScreenUtil.getInstance().getAdapterSize(10))
          ],
        ),
      ),
    );
  }

  Widget _pointsChildWidget(OrderModel orderModel) {
    List<OrderGroupPoint>? points = orderModel.groupPoints;
    List<Widget> _listPointsWidget = [];

    if (points != null) {
      for (int i = 0; i < points.length; i++) {
        if (i == 0) {
          _listPointsWidget.add(_locationChildWidget(
              image: SvgPicture.asset('assets/icon/svg/ic_location_start.svg'),
              point: points[i]));
        } else if (i == points.length - 1) {
          _listPointsWidget.add(_locationChildWidget(
              point: points[i],
              image: SvgPicture.asset('assets/icon/svg/ic_flag.svg'),
              isLast: true));
        } else {
          _listPointsWidget.add(_locationChildWidget(
              point: points[i],
              image: SvgPicture.asset(
                'assets/icon/svg/ic_location.svg',
                color: Colors.grey,
              )));
        }
      }
    }

    return Column(
      children: _listPointsWidget,
    );
  }

  Widget _locationChildWidget(
      {required Widget image, required OrderGroupPoint point, bool? isLast}) {
    Color? textColor;
    int actionType = PointStatusEnum.parse(point.status, point.type).actionType;
    switch (actionType) {
      case -1:
        textColor = Colors.red;
        break;
      case 0:
        textColor = AppColor.colorTextLocation;
        break;
      case 1:
        textColor = Colors.grey;
        break;
      default:
        textColor = AppColor.colorTextLocation;
        break;
    }
    return Row(
      children: [
        Column(
          children: [
            image,
            Dash(
                direction: Axis.vertical,
                length: 20,
                dashLength: isLast == null ? 5 : 0,
                dashColor: Colors.grey),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(point.location?.address ?? '',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(12),
                  color: textColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        )
      ],
    );
  }

  Widget _itemPadding() {
    return SizedBox(height: ScreenUtil.getInstance().getAdapterSize(5));
  }
}
