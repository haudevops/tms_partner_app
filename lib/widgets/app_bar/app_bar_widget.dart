
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tms_partner_app/res/colors.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({this.leadingWidget, this.titleWidget, this.actions});

  final Widget? leadingWidget;
  final Widget? titleWidget;
  final List<Widget>? actions;
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize {
    return Size.fromHeight(56);
  }
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
              AppColor.colorPrimary,
              AppColor.colorPrimaryDark
            ]))),
        centerTitle: true,
        title: widget.titleWidget,
        actions: widget.actions,
        leading: widget.leadingWidget,
        leadingWidth: 200);
  }
}
