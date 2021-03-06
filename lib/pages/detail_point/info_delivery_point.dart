
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class InfoDeliveryPoint extends StatelessWidget {
  const InfoDeliveryPoint(
      {Key? key,
      required this.orderModel,
      required this.pointCurrent,
      required this.isPickPoint})
      : super(key: key);

  final OrderModel? orderModel;
  final Point? pointCurrent;
  final bool isPickPoint;

  bool _hideCustomerInfo() {
    return OrderUtils.isFindingOrder(orderModel?.status) ||
        OrderUtils.isCancelOrder(orderModel?.status) ||
        OrderUtils.isCompleteOrder(orderModel?.status) ||
        OrderUtils.isInstallFailedOrder(orderModel?.status) ||
        OrderUtils.isPendingOrder(orderModel?.status);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            _infoWidget(),
            // _getListServiceWidget().isNotEmpty
            //     ? Container(
            //         width: ScreenUtil.getInstance().screenWidth,
            //         height: ScreenUtil.getInstance().getAdapterSize(12),
            //         color: Color(0xFFEDEDED),
            //       )
            //     : SizedBox(),
            // _servicesWidget(),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(120))
          ],
        ),
      ],
    );
  }

  Widget _infoWidget() {
    return Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(5),
          },
          children: [
            (!_hideCustomerInfo() && pointCurrent?.contact?.name != null)
                ? _itemInfo(
                    title: 'Kh??ch h??ng: ', content: pointCurrent?.contact?.name)
                : _tableRowNull(),
            (!_hideCustomerInfo() && pointCurrent?.contact?.phone != null)
                ? _itemInfo(
                    title: '??i???n tho???i: ',
                    content: OrderUtils.isProcessOrder(orderModel?.status)
                        ? '${pointCurrent!.contact!.phone!.substring(0, pointCurrent!.contact!.phone!.length - 4)}xxxx'
                        : pointCurrent?.contact?.phone)
                : _tableRowNull(),
            _itemInfo(
                title: '?????a ch???: ', content: pointCurrent?.location?.address),
            isPickPoint
                ? _itemInfo(
                    title: 'Y??u c???u: ',
                    content: (orderModel?.detail?.goodsCheckRequired != null &&
                            orderModel!.detail!.goodsCheckRequired!)
                        ? 'Ki???m tra h??ng'
                        : 'Kh??ng ki???m tra h??ng')
                : _tableRowNull(),
            (pointCurrent?.note != null && pointCurrent!.note!.isNotEmpty)
                ? _itemInfo(title: 'Ghi ch??: ', content: pointCurrent?.note)
                : _tableRowNull(),
            _externalCodeWidget(),
          ],
        ));
  }

  Widget _servicesWidget() {
    List<Widget> _listService = _getListServiceWidget();
    return _listService.isNotEmpty
        ? Expanded(
            child: Container(
              width: ScreenUtil.getInstance().screenWidth,
              padding:
                  EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('D???ch v???',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                          fontWeight: FontWeight.w600)),
                  Container(
                      padding: EdgeInsets.all(
                          ScreenUtil.getInstance().getAdapterSize(12)),
                      margin: EdgeInsets.only(
                          top: ScreenUtil.getInstance().getAdapterSize(12)),
                      width: ScreenUtil.getInstance().screenWidth,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _listService,
                      ))
                ],
              ),
            ),
          )
        : SizedBox();
  }

  TableRow _itemInfo({required String title, required String? content}) {
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
        child: Text(content ?? '',
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                color: AppColor.colorBlack)),
      ),
    ]);
  }

  TableRow _tableRowNull() {
    return TableRow(children: [
      SizedBox(),
      SizedBox(),
    ]);
  }

  TableRow _externalCodeWidget() {
    int? _maxLine;
    String? _externalCode;
    bool _showButtonExternalCode;
    switch (pointCurrent?.type) {
      case PointType.PICK_POINT:
        _maxLine = 1;
        _externalCode =
            OrderUtils.collectExternalCode(orderModel, pointCurrent?.id);
        _showButtonExternalCode = true;
        break;
      case PointType.RETURN_POINT:
        _maxLine = 1;
        List<PickPointProductModel>? returnProducts = OrderUtils.collectProducts(orderModel, pointCurrent);
        _externalCode = OrderUtils.collectExternalCodeProduct(returnProducts);
        _showButtonExternalCode = true;
        break;
      default:
        _maxLine = null;
        _showButtonExternalCode = false;
        _externalCode = pointCurrent?.externalCode;
        break;
    }
    if (_externalCode != null) {
      return TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().getAdapterSize(4)),
          child: Text('M?? tham chi???u: ',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                  color: AppColor.colorGray)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().getAdapterSize(4)),
          child: Row(
            children: [
              Expanded(
                child: Text(_externalCode,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                        color: AppColor.colorBlack),
                    maxLines: _maxLine,
                    overflow: TextOverflow.ellipsis),
              ),
              // GestureDetector(
              //   onDoubleTap: () {},
              //   onTap: () {},
              //   child: _showButtonExternalCode
              //       ? SvgPicture.asset(
              //           'assets/icon/svg/ic_dots.svg',
              //           width: ScreenUtil.getInstance().getAdapterSize(24),
              //           height: ScreenUtil.getInstance().getAdapterSize(24),
              //         )
              //       : SizedBox(),
              // )
            ],
          ),
        ),
      ]);
    } else {
      return _tableRowNull();
    }
  }

  List<Widget> _getListServiceWidget() {
    List<Widget> _widgets = [];

    if (pointCurrent?.services != null) {
      for (int i = 0; i < pointCurrent!.services!.length; i++) {
        _widgets.add(Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    pointCurrent!.services![i].name ?? '',
                    style: TextStyle(
                        color: AppColor.colorGray,
                        fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Text(
                    OrderUtils.getCurrencyText(pointCurrent!.services![i].cost),
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
                  ),
                ),
                SizedBox(width: ScreenUtil.getInstance().getAdapterSize(12)),
                SvgPicture.asset('assets/icon/svg/ic_warning.svg')
              ],
            ),
            Visibility(
                child: Divider(),
                visible: i != pointCurrent!.services!.length - 1)
          ],
        ));
      }
    }

    return _widgets;
  }
}
