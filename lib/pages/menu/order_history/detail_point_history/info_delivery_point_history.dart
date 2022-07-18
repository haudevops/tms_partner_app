import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class InfoDeliveryPointHistory extends StatelessWidget {
  const InfoDeliveryPointHistory(
      {Key? key,
      required this.orderModel,
      required this.pointCurrent,
      required this.isPickPoint})
      : super(key: key);

  final OrderModel? orderModel;
  final Point? pointCurrent;
  final bool isPickPoint;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            _infoWidget(context),
            _getListServiceWidget().isNotEmpty
                ? Container(
                    width: ScreenUtil.getInstance().screenWidth,
                    height: ScreenUtil.getInstance().getAdapterSize(12),
                    color: Color(0xFFEDEDED),
                  )
                : SizedBox(),
            _servicesWidget(),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(120))
          ],
        ),
      ],
    );
  }

  Widget _infoWidget(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(5),
          },
          children: [
            _itemInfo(
                title: 'Khách hàng: ', content: pointCurrent?.contact?.name),
            _itemInfo(
                title: 'Điện thoại: ',
                content: OrderUtils.isProcessOrder(orderModel?.status)
                    ? '${pointCurrent!.contact!.phone!.substring(0, pointCurrent!.contact!.phone!.length - 4)}xxxx'
                    : pointCurrent?.contact?.phone),
            _itemInfo(
                title: 'Địa chỉ: ', content: pointCurrent?.location?.address),
            isPickPoint
                ? _itemInfo(
                    title: 'Yêu cầu: ',
                    content: (orderModel?.detail?.goodsCheckRequired != null &&
                            orderModel!.detail!.goodsCheckRequired!)
                        ? 'Kiểm tra hàng'
                        : 'Không kiểm tra hàng')
                : _tableRowNull(),
            (pointCurrent?.note != null && pointCurrent!.note!.isNotEmpty)
                ? _itemInfo(title: 'Ghi chú: ', content: pointCurrent?.note)
                : _tableRowNull(),
            _externalCodeWidget(),
            _itemInfoImage(title: 'Hình ảnh', pointCurrent: pointCurrent),
            _itemSignImage(title: 'Chữ ký', content: 'Xem chi tiết', signImage: pointCurrent?.signImage, context: context)
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
                  Text('Dịch vụ',
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
                fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                color: AppColor.colorGray)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().getAdapterSize(4)),
        child: Text(content ?? '',
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                color: AppColor.colorBlack)),
      ),
    ]);
  }

  TableRow _tableRowNull() {
    return const TableRow(children: [
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
        List<PickPointProductModel>? returnProducts =
            OrderUtils.collectProducts(orderModel, pointCurrent);
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
          child: Text('Mã tham chiếu: ',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                  color: AppColor.colorGray)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().getAdapterSize(4)),
          child: Text(_externalCode,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                  color: AppColor.colorBlack),
              maxLines: _maxLine,
              overflow: TextOverflow.ellipsis),
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
                        fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Text(
                    OrderUtils.getCurrencyText(pointCurrent!.services![i].cost),
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
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

  TableRow _itemInfoImage({required String title, Point? pointCurrent}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().getAdapterSize(4)),
          child: Text(title,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                  color: AppColor.colorGray)),
        ),
        pointCurrent != null
            ? SizedBox(
                height: ScreenUtil.getInstance().getAdapterSize(80),
                child: ListView.builder(
                  itemCount: pointCurrent.images?.length ?? 0,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      fit: BoxFit.contain,
                      width: ScreenUtil.getInstance().getAdapterSize(80),
                      height: ScreenUtil.getInstance().getAdapterSize(80),
                      alignment: Alignment.topLeft,
                      imageUrl: pointCurrent.images![index],
                      placeholder: (context, url) => Image.asset(
                        'assets/images/no_image.png',
                        alignment: Alignment.topLeft,
                        fit: BoxFit.contain,
                        width: ScreenUtil.getInstance().getAdapterSize(80),
                        height: ScreenUtil.getInstance().getAdapterSize(80),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/no_image.png',
                        alignment: Alignment.topLeft,
                        fit: BoxFit.contain,
                        width: ScreenUtil.getInstance().getAdapterSize(80),
                        height: ScreenUtil.getInstance().getAdapterSize(80),
                      ),
                    );
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  TableRow _itemSignImage({required String title, required String? content, required String? signImage, required BuildContext context}) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().getAdapterSize(4)),
        child: Text(title,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                color: AppColor.colorGray)),
      ),
      TextButton(
        onPressed: () {
          print('touch: $signImage');
          Navigator.pushNamed(context, SignImagePage.routeName, arguments: ScreenArguments(arg1: signImage));
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.topLeft,
        ),
        child: Text(
          content ?? '',
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().getAdapterSize(16),
            color: AppColor.colorBlue,),
        ),
      ),
    ]);
  }
}
