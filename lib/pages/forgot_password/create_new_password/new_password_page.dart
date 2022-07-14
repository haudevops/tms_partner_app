
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

// @Auth: hau.tran
// @Description: NewPassword Page
// @Date: 30/12/2021

class NewPasswordPage extends BasePage {
  static const routeName = '/NewPasswordPage';

  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends BasePageState<NewPasswordPage, BaseBloc> {
  final FocusNode _focusNodeNewPassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKeyNewPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();
  final RegExp regExp = RegExp(r'(?=.*?[0-9]).{8,}');
  bool _newPassword = false;
  bool _confirmPassword = false;
  bool _showButton = false;

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  void showDialogSuccessPassword() {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return DialogPage(
            leading: 'Tạo mới mật khẩu thành công',
            title: 'Quý khách vui lòng nhập lại mật khẩu vừa tạo để đăng nhập',
            textButton: S.current.continues,
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
          );
        });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().getAdapterSize(16),
            right: ScreenUtil.getInstance().getAdapterSize(16),
            top: ScreenUtil.getInstance().getAdapterSize(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.create_new_password,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(30))),
            _itemPadding(12),
            Text(
                'Mật khẩu dùng để đăng nhập vào app có tối thiểu 8 kí tự gồm chữ cái và số và kí tự đặc biệt.',
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                    color: AppColor.colorTextGray)),
            _itemPadding(50),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(S.of(context).pass_word,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                      color: AppColor.colorTextGray)),
            ),
            _itemPadding(12),
            _itemInput(
                hintText: S.current.new_password,
                autoFocus: true,
                focusNode: _focusNodeNewPassword,
                obscureText: !_newPassword,
                globalKey: _formKeyNewPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                      _newPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _newPassword = !_newPassword;
                    });
                  },
                ),
                onChanged: (value) {},
                onSubmit: (value) {
                  _focusNodeNewPassword.unfocus();
                  _focusNodeConfirmPassword.requestFocus();
                  _formKeyNewPassword.currentState!.validate();
                },
                controller: _newPasswordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.current.empty_pass_word;
                  } else if (!regExp.hasMatch(value)) {
                    return S.current.minimum_password_invalid;
                  }
                  return null;
                }),
            _itemPadding(20),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(S.of(context).confirm_passwords,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14),
                      color: AppColor.colorTextGray)),
            ),
            _itemPadding(12),
            _itemInput(
                hintText: S.current.confirm_password,
                autoFocus: true,
                focusNode: _focusNodeConfirmPassword,
                obscureText: !_confirmPassword,
                onSubmit: (value) {
                  _formKeyNewPassword.currentState!.validate() &&
                      _formKeyConfirmPassword.currentState!.validate();
                },
                onChanged: (value) {
                  if (_formKeyNewPassword.currentState!.validate() &&
                      _formKeyConfirmPassword.currentState!.validate()) {
                    setState(() {
                      _showButton = true;
                    });
                  } else {
                    setState(() {
                      _showButton = false;
                    });
                  }
                },
                controller: _confirmPasswordController,
                globalKey: _formKeyConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                      _confirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _confirmPassword = !_confirmPassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.current.empty_pass_word;
                  } else if (!regExp.hasMatch(value)) {
                    return S.current.minimum_password_invalid;
                  } else if (_confirmPasswordController.text !=
                      _newPasswordController.text) {
                    return S.current.passwords_are_not_the_same;
                  }
                  return null;
                }),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil.getInstance().getAdapterSize(50),
                  left: ScreenUtil.getInstance().getAdapterSize(16),
                  right: ScreenUtil.getInstance().getAdapterSize(16)),
              child: Container(
                width: ScreenUtil.getInstance().screenWidth,
                height: ScreenUtil.getInstance().getAdapterSize(50),
                child: ElevatedButton(
                  child: Text(
                    S.current.continues,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKeyNewPassword.currentState!.validate() &&
                        _formKeyConfirmPassword.currentState!.validate()) {
                      showDialogSuccessPassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: _showButton ? Colors.orange : Colors.grey,
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemPadding(double size) {
    return SizedBox(height: ScreenUtil.getInstance().getAdapterSize(size));
  }

  Widget _itemInput(
      {required String hintText,
      required bool autoFocus,
      required FocusNode focusNode,
      required ValueChanged<String?> onSubmit,
      required ValueChanged<String?> onChanged,
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
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0x33101010), width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.orange, width: 2),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            suffixIcon: suffixIcon),
        validator: validator,
      ),
    );
  }
}
