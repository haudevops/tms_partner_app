import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

// @Auth: hau.tran
// @Description: UserInfo Page
// @Date: 27/12/2021

// r'^
// (?=.*[A-Z])       // should contain at least one upper case
// (?=.*[a-z])       // should contain at least one lower case
// (?=.*?[0-9])      // should contain at least one digit
// (?=.*?[!@#\$&*~]) // should contain at least one Special character
//     .{8,}             // Must be at least 8 characters in length
// $

class ChangePasswordPage extends BasePage {
  ChangePasswordPage({Key? key}) : super(bloc: ChangePasswordBloc());
  static const routerName = '/ChangePasswordPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends BasePageState<ChangePasswordPage> {
  // late ChangePasswordBloc _bloc;
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _isObscureOld = false;
  bool _isObscureNew = false;
  bool _isObscureConfirm = false;
  final _formKeyOldPass = GlobalKey<FormState>();
  final _formKeyNewPass = GlobalKey<FormState>();
  final _formKeyConfirmPass = GlobalKey<FormState>();
  final _focusNodePassword = FocusNode();
  final _focusNodeNewPassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();
  final RegExp regExp = RegExp(r'(?=.*?[0-9]).{8,}');

  @override
  void onCreate() {
    // _bloc = getBloc();
  }

  @override
  void onDestroy() {
    _focusNodePassword.unfocus();
    _focusNodeNewPassword.unfocus();
    _focusNodeConfirmPassword.unfocus();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          S.current.change_pass,
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        color: AppColor.colorWhiteDark,
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).change_pass,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(30))),
            _itemPadding(12),
            Text(
                "Mật khẩu dùng để đăng nhập vào app có tối thiểu 8 kí tự gồm chữ cái và số và kí tự đặc biệt.",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                    color: AppColor.colorTextGray)),
            _itemPadding(32),
            Text(S.of(context).current_password,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
            _itemInput(
                hintText: S.current.old_password,
                autoFocus: true,
                focusNode: _focusNodePassword,
                obscureText: !_isObscureOld,
                onSubmit: (value) {
                  _focusNodePassword.unfocus();
                  _focusNodeNewPassword.requestFocus();
                },
                controller: _oldPassword,
                globalKey: _formKeyOldPass,
                isShow: _isObscureOld,
                onPressed: () {
                  setState(() {
                    _isObscureOld = !_isObscureOld;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.current.empty_pass_word;
                  } else if (!regExp.hasMatch(value)) {
                    return S.current.minimum_password_invalid;
                  }
                  return null;
                }),
            _itemPadding(32),
            Text(S.of(context).new_password,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
            _itemInput(
                hintText: S.current.new_password,
                autoFocus: false,
                focusNode: _focusNodeNewPassword,
                obscureText: !_isObscureNew,
                onSubmit: (value) {
                  _focusNodeNewPassword.unfocus();
                  _focusNodeConfirmPassword.requestFocus();
                },
                isShow: _isObscureNew,
                onPressed: () {
                  setState(() {
                    _isObscureNew = !_isObscureNew;
                  });
                },
                controller: _newPassword,
                globalKey: _formKeyNewPass,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.current.empty_pass_word;
                  } else if (!regExp.hasMatch(value)) {
                    return S.current.minimum_password_invalid;
                  }
                  return null;
                }),
            _itemPadding(32),
            Text(S.of(context).confirm_password,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
            _itemInput(
                hintText: S.current.confirm_password,
                autoFocus: false,
                focusNode: _focusNodeConfirmPassword,
                obscureText: !_isObscureConfirm,
                onSubmit: (value) {
                  _focusNodeConfirmPassword.unfocus();
                },
                isShow: _isObscureConfirm,
                onPressed: () {
                  _isObscureConfirm = !_isObscureConfirm;
                },
                controller: _confirmPassword,
                globalKey: _formKeyConfirmPass,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.current.empty_pass_word;
                  } else if (!regExp.hasMatch(value)) {
                    return S.current.minimum_password_invalid;
                  } else if (_newPassword.text != _confirmPassword.text) {
                    return S.current.passwords_do_not_match;
                  }
                  return null;
                }),
            _widgetChangePassword(),
          ],
        ),
      ),
    );
  }

  Widget _widgetChangePassword() {
    return Container(
      width: ScreenUtil.getInstance().getAdapterSize(300),
      height: ScreenUtil.getInstance().getAdapterSize(40),
      margin: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().getAdapterSize(32), horizontal: ScreenUtil.getInstance().getAdapterSize(16)),
      child: ElevatedButton(
        onPressed: () {
          //Call API
          // if (_formKeyOldPass.currentState!.validate() &&
          //     _formKeyNewPass.currentState!.validate() &&
          //     _formKeyConfirmPass.currentState!.validate()) {
          //   _bloc.changePassword(
          //       _oldPassword.text, _newPassword.text, _confirmPassword.text);
          // }
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    title: Text(S.current.menu_logout,
                        textAlign: TextAlign.center),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(S.current.logout_confirm,
                            textAlign: TextAlign.center),
                        SizedBox(
                            height:
                            ScreenUtil.getInstance().getAdapterSize(15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonSubmitWidget(
                              title: S.current.skip.toUpperCase(),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              colorTitle: AppColor.orderStatusYellow,
                              backgroundColors: false,
                              width: ScreenUtil.getInstance()
                                  .getAdapterSize(110),
                              height: ScreenUtil.getInstance()
                                  .getAdapterSize(40),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            backgroundColor: MaterialStateProperty.all(Colors.orange)),
        child: Text(
          S.current.change_password,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _showDivider() {
    return Divider(
      thickness: 1,
      indent: ScreenUtil.getInstance().getAdapterSize(10),
      endIndent: ScreenUtil.getInstance().getAdapterSize(35),
    );
  }

  Widget _itemInput(
      {required String hintText,
      required bool autoFocus,
      required FocusNode focusNode,
      required ValueChanged<String?> onSubmit,
      required TextEditingController controller,
      required bool obscureText,
      required GlobalKey globalKey,
      required FormFieldValidator<String> validator,
      required bool isShow,
      required VoidCallback onPressed}) {
    return Form(
      key: globalKey,
      child: TextFormField(
        autofocus: autoFocus,
        focusNode: focusNode,
        onFieldSubmitted: onSubmit,
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColor.colorPrimaryButton, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColor.colorPrimaryButton, width: 1),
          ),
          errorBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColor.orderStatusRed, width: 1),
          ),
          suffixIcon: IconButton(
            icon: Icon(isShow ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey),
            onPressed: onPressed,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _itemPadding(double size) {
    return SizedBox(height: ScreenUtil.getInstance().getAdapterSize(size));
  }
}
