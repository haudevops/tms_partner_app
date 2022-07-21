import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
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

import '../../../base/base_dialog.dart';

class DetailAcceptedOrderPage extends BasePage<DetailAcceptedOrderBloc> {
  DetailAcceptedOrderPage({Key? key, required this.arguments})
      : super(bloc: DetailAcceptedOrderBloc());

  static const routeName = '/DetailAcceptedOrderPage';

  final ScreenArguments arguments;

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _DetailNewOrderState();
}

class _DetailNewOrderState extends BasePageState<DetailAcceptedOrderPage> {
  late DetailAcceptedOrderBloc _bloc;
  String? _title;

  @override
  void onCreate() {
    _bloc = getBloc();
    _bloc.initData(orderModel: widget.arguments.arg1);
    _bloc.ordersStream.listen((value) {
      if (value != null) {
        _checkStatus(value.status);
      }
    });
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  void _checkStatus(int? status) {
    switch (status) {
      case OrderStatus.FINISHED_RETURNED:
      case OrderStatus.FINISHED:
        _showWarningDialog(
            content:
                'Bạn đã giao hoàn tất đơn hàng! Vào lịch sử đơn hàng đã giao để xem lại thông tin.',
            onBack: true);
        break;
      case OrderStatus.CANCELED_ADMIN:
        _showWarningDialog(
            content: 'Đơn hàng đã hủy bởi điều phối viên.', onBack: true);
        break;
      case OrderStatus.CANCELED_PARTNER:
        _showWarningDialog(
            content: 'Đơn hàng đã hủy bởi đối tác.', onBack: true);
        break;
      case OrderStatus.CANCELED_USER:
        _showWarningDialog(
            content: 'Đơn hàng đã hủy bởi người dùng.', onBack: true);
        break;
      case OrderStatus.INSTALL_FAILED:
        _showWarningDialog(
            content: 'Đơn hàng đã kết thúc do lắp đặt thất bại.', onBack: true);
        break;
      case OrderStatus.INCIDENT:
        // start DetailIncidentBillActivity;
        break;
    }
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
    return StreamBuilder<OrderModel?>(
      stream: _bloc.ordersStream,
      builder: (builderContext, snapshot) {
        if (snapshot.hasData) {
          OrderModel orderModel = snapshot.data!;
          PointTargetFinder pointTargetFinder =
              _bloc.findPointsAction(orderModel);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _checkTitleButton(pointTargetFinder.status, pointTargetFinder);
          });
          return Scaffold(
            backgroundColor: AppColor.colorWhiteDark,
            appBar: AppBar(
              title: Text(
                orderModel.isGrouped()
                    ? 'Nhóm đơn'
                    : 'Đơn hàng ${orderModel.code}',
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
                          _detailWidget(orderModel),
                          Container(
                              height:
                                  ScreenUtil.getInstance().getAdapterSize(8),
                              color: AppColor.lineLayout),
                          _locationWidget(orderModel),
                          SizedBox(
                              height:
                                  ScreenUtil.getInstance().getAdapterSize(90)),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _buttonWidget(pointTargetFinder, orderModel),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: AppColor.colorWhiteDark,
          );
        }
        return const NoOrderWidget(title: 'Không có đơn hàng');
      },
    );
  }

  Widget _detailWidget(OrderModel orderModel) {
    String? storeCode = OrderUtils.getStoreCode(orderModel);
    String? pointsExternalCode = OrderUtils.getPointsExternalCode(orderModel);
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
                  orderModel.serviceName ?? '',
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
                (storeCode != null && storeCode.isNotEmpty)
                    ? _itemInfoWidget(
                        title: '${S.of(context).store_code}: ',
                        content: storeCode)
                    : _tableRowNull(),
                (pointsExternalCode != null && pointsExternalCode.isNotEmpty)
                    ? _itemInfoWidget(
                        title: '${S.of(context).externalCode}: ',
                        content: pointsExternalCode,
                        onTap: () {
                          _showDialogCode();
                        },
                        showIcon: true,
                      )
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

  _showDialogCode() async{
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ScreenUtil.getInstance().getAdapterSize(16)),
          topRight: Radius.circular(ScreenUtil.getInstance().getAdapterSize(16)),
        ),
      ),
      backgroundColor: AppColor.colorWhiteDark,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(alignment: Alignment.topCenter,
                    child: const Text('Modal BottomSheet')),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
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

  Widget _pointsChildWidget(OrderModel orderModel) {
    List<Point>? points = orderModel.detail?.points;
    List<Widget> listPointsWidget = [];

    if (points != null) {
      for (int i = 0; i < points.length; i++) {
        if (i == 0) {
          listPointsWidget.add(_locationChildWidget(
              image: SizedBox(
                  width: ScreenUtil.getInstance().getAdapterSize(27),
                  height: ScreenUtil.getInstance().getAdapterSize(25),
                  child: SvgPicture.asset(
                      'assets/icon/svg/ic_location_start.svg')),
              point: points[i],
              position: 0,
              orderModel: orderModel));
        } else if (i == points.length - 1) {
          listPointsWidget.add(_locationChildWidget(
              point: points[i],
              image: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().getAdapterSize(10)),
                child: SvgPicture.asset('assets/icon/svg/ic_dot.svg'),
              ),
              position: 2,
              orderModel: orderModel));
        } else {
          listPointsWidget.add(_locationChildWidget(
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
      children: listPointsWidget,
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
                Navigator.pushNamed(context, DetailPointPage.routeName,
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

  Widget _buttonWidget(
      PointTargetFinder pointTargetFinder, OrderModel orderModel) {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().getAdapterSize(16),
          vertical: ScreenUtil.getInstance().getAdapterSize(8)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top:
                  BorderSide(color: const Color(0xFF101010).withOpacity(0.1)))),
      child: Row(
        children: [
          Expanded(
              child: ButtonSubmitWidget(
                  onPressed: () {
                    switch (pointTargetFinder.status) {
                      case PointStatus.NEW:
                      case PointStatus.IN_PROGRESS:
                        _bloc.arrived(pointTargetFinder, orderModel);
                        break;
                      case PointStatus.POINT_ARRIVED:
                        switch (pointTargetFinder.type) {
                          case PointType.PICK_POINT:
                            Navigator.pushNamed(
                                context, ConfirmPickGoodsSuccessPage.routeName,
                                arguments: ScreenArguments(
                                    arg1: orderModel, arg2: pointTargetFinder));

                            break;
                          case PointType.DELIVERY_POINT:
                          case PointType.DELIVERY_INSTALLATION_POINT:
                            // deliveryGoods();
                            _pickGoods(pointTargetFinder, orderModel,
                                'Giao hàng thành công', 'Giao hàng thất bại');
                            break;
                          case PointType.INSTALLATION_POINT:
                            // installation();
                            break;
                          case PointType.RETURN_POINT:
                            // returnGoods();
                            break;
                          case PointType.RETURN_WAREHOUSE:
                            //returnWarehouse();
                            break;
                        }
                        break;
                      default:
                        _showWarningDialog(
                            content: S
                                .of(context)
                                .something_went_wrong_please_try_again,
                            onBack: false);
                        break;
                    }
                  },
                  title: _title?.toUpperCase() ?? 'OK',
                  colorTitle: Colors.white)),
        ],
      ),
    );
  }

  void _checkTitleButton(int? status, PointTargetFinder pointTargetFinder) {
    if (mounted) {
      switch (status) {
        case PointStatus.NEW:
          setState(() {
            _title = 'Đến nơi lấy hàng';
          });
          break;
        case PointStatus.IN_PROGRESS:
          setState(() {
            _title = 'Đến nơi giao hàng';
          });
          break;
        case PointStatus.POINT_ARRIVED:
          switch (pointTargetFinder.type) {
            case PointType.PICK_POINT:
              setState(() {
                _title = 'Lấy hàng thành công';
              });
              break;
            case PointType.DELIVERY_POINT:
              setState(() {
                _title = 'Giao hàng thành công';
              });
              break;
          }
          break;
        default:
          setState(() {
            _title = 'Giao hàng';
          });
          break;
      }
    }
  }

  void _pickGoods(PointTargetFinder pointTargetFinder, OrderModel orderModel,
      String pickSuccess, String pickFail) {
    PickGoodsBottomSheet().showPickGoodsOption(
        buildContext: context,
        orderModel: orderModel,
        pointTargetFinder: pointTargetFinder,
        onSubmit: (value) {
          switch (value) {
            case PickGoodsOption.PICK_SUCCESS:
              Navigator.pushNamed(
                  context, ConfirmPickGoodsSuccessPage.routeName,
                  arguments: ScreenArguments(
                      arg1: orderModel, arg2: pointTargetFinder));
              break;
            case PickGoodsOption.PICK_FAILED:
              DebugLog.show('click PICK_SUCCESS');
              break;
            default:
              DebugLog.show('click default');
              break;
          }
        },
        pickSuccess: pickSuccess,
        pickFailed: pickFail);
  }
}
