
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

import 'header_widget.dart';

class SelectImageBottomSheet {
  SelectImageBottomSheet._internal();

  static final SelectImageBottomSheet _instance =
      SelectImageBottomSheet._internal();

  factory SelectImageBottomSheet() {
    return _instance;
  }

  void show(
      {required BuildContext context,
      required Function(SelectOptionImage) onSelect}) {
    BaseBottomSheet().show(
        context: context,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerWidget(context: context, title: 'Thêm hình ảnh/Video'),
            Divider(
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(8)),
            _itemSelect(
                title: 'Từ máy ảnh',
                image: 'assets/icon/svg/ic_option_camera.svg',
                onTap: () {
                  Navigator.pop(context);
                  onSelect(SelectOptionImage.Camera);
                }),
            Divider(
                color: Colors.grey,
                height: 0,
                indent: ScreenUtil.getInstance().getAdapterSize(65)),
            _itemSelect(
                title: 'Từ thư viện',
                image: 'assets/icon/svg/ic_option_photo.svg',
                onTap: () {
                  Navigator.pop(context);
                  onSelect(SelectOptionImage.Gallery);
                }),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(8)),
          ],
        ));
  }

  Widget _itemSelect(
      {required String title,
      required String image,
      required GestureTapCallback onTap}) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: ScreenUtil.getInstance().getAdapterSize(8)),
      child: ListTile(
        leading: SvgPicture.asset(image),
        title: Text(
          title,
          style:
              TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(14)),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

enum SelectOptionImage { Camera, Gallery }
