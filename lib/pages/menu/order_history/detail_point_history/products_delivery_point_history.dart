import 'package:flutter/material.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class ProductsDeliveryPointHistory extends StatelessWidget {
  const ProductsDeliveryPointHistory(
      {Key? key, required this.products, required this.pointCurrent})
      : super(key: key);
  final List<PickPointProductModel> products;
  final Point? pointCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().screenHeight,
      color: AppColor.colorWhiteDark,
      padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
      child: Column(
        children: [
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(5),
            },
            children: [_itemInfo(pointCurrent?.externalCode)],
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              Text('Sản phẩm',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('Số lượng',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: ScreenUtil.getInstance().getAdapterSize(8),
          ),
          _listProduct()
        ],
      ),
    );
  }

  TableRow _itemInfo(String? content) {
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
        child: Text(content ?? '',
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().getAdapterSize(16),
              color: AppColor.colorBlack,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }

  Widget _listProduct() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: pointCurrent?.products?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return _productWidget(pointCurrent?.products?[index]);
        },
      ),
    );
  }

  Widget _productWidget(ProductModel? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data?.name ?? '',
              style: TextStyle(
                color: AppColor.colorGray,
                fontSize: ScreenUtil.getInstance().getAdapterSize(14),
              ),
              maxLines: 2 ,
            ),
            Text(
              '${data?.quantity}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil.getInstance().getAdapterSize(14),
              ),
            ),

          ],
        ),
        SizedBox(
          height: ScreenUtil.getInstance().getAdapterSize(5),
        ),
        Text(
          data?.sku ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil.getInstance().getAdapterSize(14),
          ),
        ),
      ],
    );
  }
}
