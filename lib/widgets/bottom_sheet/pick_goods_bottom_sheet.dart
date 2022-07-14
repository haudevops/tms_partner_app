import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base_bottom_sheet.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/button/button_submit_widget.dart';

import 'header_widget.dart';

class PickGoodsBottomSheet {
  PickGoodsOption? _groupOption = PickGoodsOption.PICK_SUCCESS;

  PickGoodsBottomSheet._internal();

  static final PickGoodsBottomSheet _instance =
      PickGoodsBottomSheet._internal();

  factory PickGoodsBottomSheet() {
    return _instance;
  }

  void showPickGoodsOption(
      {required BuildContext buildContext,
      required OrderModel orderModel,
      required PointTargetFinder pointTargetFinder,
      required Function(PickGoodsOption) onSubmit}) {
    BaseBottomSheet().show(
        context: buildContext,
        widget: StatefulBuilder(builder: (context, StateSetter state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget(context: context, title: S.of(context).pickup),
              Divider(
                height: 1,
                color: Colors.black.withOpacity(0.2),
              ),
              _radioCheckOption(
                  nameOption: 'Giao hàng thành công',
                  option: PickGoodsOption.PICK_SUCCESS,
                  state: state),
              _radioCheckOption(
                  nameOption: 'Giao hàng thất bại',
                  option: PickGoodsOption.PICK_FAILED,
                  state: state),
              _checkPickUpLater(orderModel, pointTargetFinder, state),
              _submitWidget(onSubmit, buildContext)
            ],
          );
        }));
  }

  Widget _radioCheckOption(
      {required String nameOption,
      required PickGoodsOption option,
      required StateSetter state}) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().getAdapterSize(16),
          ScreenUtil.getInstance().getAdapterSize(16),
          ScreenUtil.getInstance().getAdapterSize(16),
          0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _groupOption == option ? Color(0xFFFFF1E5) : Colors.white,
          border: Border.all(
              color: _groupOption == option
                  ? Color(0xFFF28022)
                  : Color(0xFFA49F9B))),
      child: RadioListTile(
        title: Text(nameOption,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                color: _groupOption == option
                    ? AppColor.colorPrimaryButton
                    : Color(0xFF666462))),
        value: option,
        groupValue: _groupOption,
        onChanged: (PickGoodsOption? value) {
          state(() {
            _groupOption = value;
          });
        },
      ),
    );
  }

  Widget _checkPickUpLater(OrderModel orderModel,
      PointTargetFinder pointTargetFinder, StateSetter state) {
    if (orderModel.detail != null) {
      if (orderModel.detail!.isMultiPickPoint() &&
          orderModel.detail!
                  .getNextPointProgress(pointTargetFinder.point?.id) !=
              null) {
        return _radioCheckOption(
            nameOption: 'Lấy hàng sau',
            option: PickGoodsOption.PICK_UP_LATER,
            state: state);
      }
    }
    return SizedBox();
  }

  Widget _submitWidget(
      Function(PickGoodsOption) onSubmit, BuildContext context) {
    return ButtonSubmitWidget(
      onPressed: () {
        Navigator.pop(context);
        onSubmit(_groupOption!);
      },
      title: 'Xác nhận',
      colorTitle: Colors.white,
      marginHorizontal: ScreenUtil.getInstance().getAdapterSize(16),
      marginVertical: ScreenUtil.getInstance().getAdapterSize(16),
      height: ScreenUtil.getInstance().getAdapterSize(44),
    );
  }
}

enum PickGoodsOption { PICK_SUCCESS, PICK_FAILED, PICK_UP_LATER }
