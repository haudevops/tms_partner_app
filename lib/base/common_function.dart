
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tms_partner_app/widgets/dialog/dialog_internet_connection.dart';
import 'package:tms_partner_app/widgets/holder_widget.dart';

import '../config/define_service_api.dart';
import '../utils/constants.dart';
import '../utils/screen_util.dart';
import '../widgets/loading_widget.dart';

abstract class BaseFunction {
  BuildContext? _contextBaseFunction;
  late State _stateBaseFunction;
  bool isShowLoading = false;
  late FToast _fToast;

  void initBaseCommon(State state) {
    _stateBaseFunction = state;
    _contextBaseFunction = state.context;
    _fToast = FToast();
    _fToast.init(state.context);
  }

  void onCreate();

  void onResume() {}

  void onPause() {}

  Widget buildWidget(BuildContext context);

  void onBackground() {}

  void onForeground() {}

  void onDestroy();

  String getWidgetName() {
    if (_contextBaseFunction == null) {
      return "";
    }
    String className = _contextBaseFunction.toString();

    if (environment != Constants.PROD_ENVIRONMENT) {
      try {
        className = className.substring(0, className.indexOf("("));
      } catch (err) {
        className = "";
      }
      return className;
    }

    return className;
  }

  void showLoading(bool isLoading) {
    if (_stateBaseFunction.mounted) {
      _stateBaseFunction.setState(() {
        isShowLoading = isLoading;
      });
    }
  }

  void showDialogInternetConnect(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return DialogInternetConnect();
        });
  }

  Widget getBaseView(BuildContext context) {
    return Stack(
      children: [
        buildWidget(context),
        isShowLoading ? getLoadingWidget() : getHolderLWidget(),
      ],
    );
  }

  void showToast(String content,
      {Toast length = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.TOP,
      Color backColor = Colors.black54,
      Color textColor = Colors.white}) {
    Widget toast = Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().getAdapterSize(24),
          vertical: ScreenUtil.getInstance().getAdapterSize(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: backColor),
      child: Text(content,
          style: TextStyle(
              color: textColor,
              fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
    );

    _fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: Duration(seconds: 2),
    );
  }

  Widget getAppBarLeft() {
    return InkWell(
      onTap: clickAppBarBack,
      child: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  void clickAppBarBack() {
    finish();
  }

  void finish<T extends Object>([T? result]) {
    if (Navigator.canPop(_contextBaseFunction!)) {
      Navigator.pop<T>(_contextBaseFunction!, result);
    } else {
      finishDartPageOrApp();
    }
  }

  void finishDartPageOrApp() {
    SystemNavigator.pop();
  }
}
