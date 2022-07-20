import 'package:flutter/material.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class ButtonSubmitWidget extends StatelessWidget {
  const ButtonSubmitWidget(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.height,
      this.width,
      this.paddingHorizontal,
      this.paddingVertical,
      this.marginVertical,
      this.marginHorizontal,
      this.colorTitle,
      this.titleSize,
      this.backgroundColors = true,
      this.inactiveColor = false})
      : super(key: key);

  final String title;
  final Color? colorTitle;
  final VoidCallback? onPressed;
  final bool backgroundColors;
  final bool inactiveColor;
  final double? height;
  final double? width;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? marginHorizontal;
  final double? marginVertical;
  final double? titleSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenUtil.getInstance().screenWidth,
      height: height ?? ScreenUtil.getInstance().getAdapterSize(40),
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 0, vertical: paddingVertical ?? 0),
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal ?? 0, vertical: marginVertical ?? 0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: backgroundColors
                ? MaterialStateProperty.all(AppColor.colorPrimaryButton)
                : MaterialStateProperty.all(inactiveColor
                    ? const Color(0xFFCFCAC6)
                    : const Color(0xFFCFCAC6)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ScreenUtil.getInstance().getAdapterSize(8)),
            ))),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              color: colorTitle,
              fontSize: ScreenUtil.getInstance().getAdapterSize(titleSize ?? 14)),
        ),
      ),
    );
  }
}
