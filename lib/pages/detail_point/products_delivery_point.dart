
import 'package:flutter/material.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/utils/open_settings/open_settings.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class ProductsDeliveryPoint extends StatelessWidget {
  const ProductsDeliveryPoint(
      {Key? key, required this.products, required this.pointCurrent})
      : super(key: key);
  final List<PickPointProductModel> products;
  final Point? pointCurrent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top:
                        BorderSide(color: Color(0xFF101010).withOpacity(0.1)))),
            child: ButtonSubmitWidget(
              marginHorizontal: ScreenUtil.getInstance().getAdapterSize(16),
              marginVertical: ScreenUtil.getInstance().getAdapterSize(8),
              title: 'XEM ĐƯỜNG ĐI',
              onPressed: () {
                OpenSettings.openMap(
                    pointCurrent?.location?.lat, pointCurrent?.location?.lng);
              },
              colorTitle: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
          child: ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Row(
                    children: [
                      Text('Sản phẩm',
                          style: TextStyle(
                              fontSize:
                                  ScreenUtil.getInstance().getAdapterSize(16),
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('Số lượng',
                          style: TextStyle(
                              fontSize:
                                  ScreenUtil.getInstance().getAdapterSize(16),
                              fontWeight: FontWeight.w600)),
                    ],
                  );
                } else {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              ScreenUtil.getInstance().getAdapterSize(12)),
                  child: Row(
                    children: [

                    ],
                  ),);
                }
              },
              separatorBuilder: (context, index) {
                return index == 0 ? SizedBox() : Divider();
              },
              itemCount: products.length + 1),
        )
      ],
    );
  }
}
