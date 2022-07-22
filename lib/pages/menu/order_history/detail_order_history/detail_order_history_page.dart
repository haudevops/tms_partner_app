import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/base/base_dialog.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/confirm/pick_goods_success/confirm_pick_goods_success_page.dart';
import 'package:tms_partner_app/pages/detail_point/detail_point_page.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/common_utils/date_util.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/order/point_status_enum.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class DetailOrderHistoryPage extends BasePage {
  DetailOrderHistoryPage({Key? key, required this.data});

  static const routeName = '/DetailOrderHistoryPage';
  final ScreenArguments data;

  @override
  BasePageState<BasePage<BaseBloc>> getState() =>
      _DetailOrderHistoryPageState();
}

class _DetailOrderHistoryPageState
    extends BasePageState<DetailOrderHistoryPage> {
  late OrderModel _orderModel;
  String? _data;

  // late PointTargetFinder pointTargetFinder;

  @override
  void onCreate() {
    _orderModel = widget.data.arg1;
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }


  void _showWarningDialog({required String content, required bool onBack}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (buildContext) {
          return BaseDialog(
            onClose: () {
              Navigator.pop(buildContext);
              if (onBack) {
                Navigator.pop(context, true);
              }
            },
            detailWidget: Column(
              children: [
                Text('Thông báo',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                        color: AppColor.colorBlack,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenUtil.getInstance().getAdapterSize(12)),
                Text(content,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
                    textAlign: TextAlign.center),
                SizedBox(height: ScreenUtil.getInstance().getAdapterSize(25)),
                ButtonSubmitWidget(
                  title: 'ĐÓNG',
                  colorTitle: Colors.white,
                  marginHorizontal: ScreenUtil.getInstance().getAdapterSize(32),
                  onPressed: () {
                    Navigator.pop(buildContext);
                    if (onBack) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
                SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
              ],
            ),
          );
        });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.menu_history,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        color: AppColor.colorWhiteDark,
        child: Stack(
          children: [
            SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _detailWidget(_orderModel),
                    Container(
                        height: ScreenUtil.getInstance().getAdapterSize(8),
                        color: AppColor.lineLayout),
                    _locationWidget(_orderModel),
                    SizedBox(
                        height: ScreenUtil.getInstance().getAdapterSize(90)),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: _buttonWidget(pointTargetFinder, _orderModel),
            // )
          ],
        ),
      ),
    );
  }

  Widget _detailWidget(OrderModel orderModel) {
    String? _storeCode = OrderUtils.getStoreCode(orderModel);
    String? _pointsExternalCode = OrderUtils.getPointsExternalCode(orderModel);
    return Container(
      color: AppColor.colorWhiteDark,
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().getAdapterSize(14),
          top: ScreenUtil.getInstance().getAdapterSize(14),
          bottom: ScreenUtil.getInstance().getAdapterSize(14)),
      child: Column(
        children: [
          NameAndStatusOderWidget(orderModel: orderModel),
          Padding(
            padding: EdgeInsets.only(
                right: ScreenUtil.getInstance().getAdapterSize(14),
                top: ScreenUtil.getInstance().getAdapterSize(8)),
            child: Row(
              children: [
                Text(
                  '${orderModel.serviceName ?? ''}',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(15),
                      color: AppColor.colorGray),
                ),
                const Spacer(),
                Text(
                  DateUtil.convertTimeStamp(orderModel.expectedTime) ?? '',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                      color: AppColor.orderGreenLight),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().getAdapterSize(4),
                right: ScreenUtil.getInstance().getAdapterSize(14)),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(34),
              },
              children: [
                (_storeCode != null && _storeCode.isNotEmpty)
                    ? _itemInfoWidget(
                        title: '${S.of(context).store_code}: ',
                        content: _storeCode)
                    : _tableRowNull(),
                (_pointsExternalCode != null && _pointsExternalCode.isNotEmpty)
                    ? _itemInfoWidget(
                        title: '${S.of(context).externalCode}: ',
                        content: _pointsExternalCode,
                        onTap: () {})
                    : _tableRowNull(),
                orderModel.isGrouped()
                    ? _itemInfoWidget(
                        title: 'Danh sách đơn: ',
                        content: OrderUtils.getPackageCodeChildOrderGroup(
                                orderModel) ??
                            '',
                        showIcon: true,
                        onTap: () {})
                    : _tableRowNull(),
                _itemInfoWidget(
                    title: 'Cân nặng: ',
                    content: orderModel.weight != null
                        ? '${OrderUtils.round(orderModel.weight!, 3)} kg'
                        : ''),
              ],
            ),
          )
        ],
      ),
    );
  }

  TableRow _itemInfoWidget(
      {required String title,
      required String content,
      GestureTapCallback? onTap,
      bool showIcon = false}) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().getAdapterSize(4)),
        child: Text(title,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                color: AppColor.colorGray)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().getAdapterSize(4)),
        child: Text(content,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                color: AppColor.colorBlack)),
      ),
      GestureDetector(
        onDoubleTap: () {},
        onTap: onTap,
        child: showIcon
            ? SvgPicture.asset(
                'assets/icon/svg/ic_dots.svg',
                width: ScreenUtil.getInstance().getAdapterSize(24),
                height: ScreenUtil.getInstance().getAdapterSize(24),
              )
            : const SizedBox(),
      )
    ]);
  }

  TableRow _tableRowNull() {
    return const TableRow(children: [
      SizedBox(),
      SizedBox(),
      SizedBox(),
    ]);
  }

  Widget _locationWidget(OrderModel orderModel) {
    return Container(
      color: AppColor.colorWhiteDark,
      padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(14)),
      width: ScreenUtil.getInstance().screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: [
            Text('Lộ trình:',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                    color: AppColor.colorGray)),
            Align(
              alignment: Alignment.center,
              child: Text('${orderModel.detail?.distance ?? 0} km',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                      color: AppColor.colorBlack)),
            )
          ]),
          SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
          _pointsChildWidget(orderModel),
        ],
      ),
    );
  }

  Widget _pointsChildWidget(OrderModel orderModel) {
    List<Point>? points = orderModel.detail?.points;
    List<Widget> _listPointsWidget = [];

    if (points != null) {
      for (int i = 0; i < points.length; i++) {
        if (i == 0) {
          _listPointsWidget.add(_locationChildWidget(
              image: SizedBox(
                  width: ScreenUtil.getInstance().getAdapterSize(27),
                  height: ScreenUtil.getInstance().getAdapterSize(25),
                  child: SvgPicture.asset(
                      'assets/icon/svg/ic_location_start.svg')),
              point: points[i],
              position: 0,
              orderModel: orderModel));
        } else if (i == points.length - 1) {
          _listPointsWidget.add(_locationChildWidget(
              point: points[i],
              image: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().getAdapterSize(10)),
                child: SvgPicture.asset('assets/icon/svg/ic_dot.svg'),
              ),
              position: 2,
              orderModel: orderModel));
        } else {
          _listPointsWidget.add(_locationChildWidget(
              point: points[i],
              image: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().getAdapterSize(10)),
                child: SvgPicture.asset('assets/icon/svg/ic_dot.svg'),
              ),
              position: 1,
              orderModel: orderModel));
        }
      }
    }

    return Column(
      children: _listPointsWidget,
    );
  }

  Widget _locationChildWidget(
      {required Widget image,
      required Point point,
      required int position,
      required OrderModel orderModel}) {
    Color? textColor;
    int actionType = PointStatusEnum.parse(point.status, point.type).actionType;
    switch (actionType) {
      case -1:
        textColor = Colors.red;
        break;
      case 0:
      case 1:
        textColor = AppColor.colorTextGray;
        break;
      default:
        textColor = AppColor.colorTextGray;
        break;
    }
    return Column(
      children: [
        Row(
          children: [
            image,
            SizedBox(
                width: ScreenUtil.getInstance()
                    .getAdapterSize(position == 0 ? 10 : 20)),
            Text(
              position == 0 ? 'Điểm lấy hàng' : 'Điểm giao hàng',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
            ),
            const Spacer(),
            GestureDetector(
              onDoubleTap: () {},
              onTap: () {
                Navigator.pushNamed(context, DetailPointHistoryPage.routeName,
                    arguments: ScreenArguments(arg1: point, arg2: orderModel));
              },
              child: Text('Chi tiết',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(11),
                      color: AppColor.colorBlue)),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().getAdapterSize(13)),
                child: Dash(
                    direction: Axis.vertical,
                    length: ScreenUtil.getInstance().getAdapterSize(45),
                    dashLength: position != 2 ? 5 : 0,
                    dashColor: Colors.grey)),
            SizedBox(width: ScreenUtil.getInstance().getAdapterSize(23)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().getAdapterSize(5)),
                child: Text(point.location?.address ?? '',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(12),
                        color: textColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        )
      ],
    );
  }
}
