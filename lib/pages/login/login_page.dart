
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import 'login_bloc.dart';

class LoginPage extends BasePage {
  LoginPage({Key? key}) : super(key: key, bloc: LoginBloc());
  static const routeName = '/LoginPage';

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, BaseBloc> {
  // late LoginBloc _bloc;
  final FocusNode _focusNodePhoneNumber = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _passwordVisible = false;
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  @override
  void onCreate() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // _bloc = getBloc();
  }

  @override
  void onDestroy() {
    _passController.clear();
    _phoneController.clear();
    _focusNodePhoneNumber.unfocus();
    _focusNodePassword.unfocus();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: AppColor.colorWhiteDark,
          height: ScreenUtil.getInstance().screenHeight,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: ScreenUtil.getInstance().getAdapterSize(16),
                right: ScreenUtil.getInstance().getAdapterSize(16),
                top: ScreenUtil.getInstance().getAdapterSize(80)),
            children: [
              Text(S.of(context).login,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(30))),
              _itemPadding(12),
              Text(
                  'Quý khách vui lòng nhập số điện thoại và mật khẩu để đăng nhập.',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                      color: AppColor.colorTextGray)),
              _itemPadding(32),
              Text(S.of(context).phone_number,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                      color: AppColor.colorTextGray)),
              _itemPadding(12),
              _itemInput(
                  hintText: S.of(context).input_phone_number,
                  autoFocus: false,
                  focusNode: _focusNodePhoneNumber,
                  obscureText: false,
                  globalKey: _formKeyPhone,
                  onSubmit: (value) {
                    _focusNodePhoneNumber.unfocus();
                    _focusNodePassword.requestFocus();
                  },
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.of(context).empty_phone_number;
                    } else if (value.length != 10 || !regExp.hasMatch(value)) {
                      return S.of(context).invalid_phone_number;
                    }
                    return null;
                  }),
              _itemPadding(20),
              Text(S.of(context).pass_word,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(18),
                      color: AppColor.colorTextGray)),
              _itemPadding(12),
              _itemInput(
                  hintText: S.of(context).pass_word,
                  autoFocus: false,
                  focusNode: _focusNodePassword,
                  obscureText: !_passwordVisible,
                  onSubmit: (value) {},
                  controller: _passController,
                  globalKey: _formKeyPass,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.of(context).empty_pass_word;
                    }
                    return null;
                  }),
              _itemPadding(32),
              ButtonSubmitWidget(
                onPressed: () {
                  // if (_formKeyPhone.currentState!.validate() &&
                  //     _formKeyPass.currentState!.validate()) {
                  //   _bloc.login(_phoneController.text, _passController.text);
                  // }
                  Navigator.pushReplacementNamed(context, NavigationPage.routeName);
                },
                title: S.of(context).login.toUpperCase(),
                colorTitle: Colors.white,
                height: ScreenUtil.getInstance().getAdapterSize(44),
              ),
            ],
          ),
        ));
  }

  Widget _itemPadding(double size) {
    return SizedBox(height: ScreenUtil.getInstance().getAdapterSize(size));
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
      TextInputType? keyboardType,
      Widget? suffixIcon}) {
    return Form(
      key: globalKey,
      child: TextFormField(
        autofocus: autoFocus,
        focusNode: focusNode,
        keyboardType: keyboardType,
        onFieldSubmitted: onSubmit,
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0x33101010), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0x33101010), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            suffixIcon: suffixIcon),
        validator: validator,
      ),
    );
  }
}
