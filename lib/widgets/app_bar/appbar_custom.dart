import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({this.leadingWidget,
    this.titleWidget,
    this.actions,
    this.showOnBack = false});

  final Widget? leadingWidget;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showOnBack;

  @override
  Size get preferredSize {
    return Size.fromHeight(56);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showOnBack,
      title: titleWidget,
      actions: actions,
      leading: leadingWidget,
      centerTitle: true,
      elevation: 1,
    );
  }
}
