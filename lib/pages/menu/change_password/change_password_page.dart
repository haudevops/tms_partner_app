
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

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
      appBar: AppBar(
        title: Text(S.current.change_password_low),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
            _showDivider(),
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
            _showDivider(),
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
            _showDivider(),
            _widgetChangePassword(),
          ],
        ),
      ),
    );
  }

  Widget _widgetChangePassword() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().getAdapterSize(8)),
      child: Container(
        width: ScreenUtil.getInstance().getAdapterSize(300),
        height: ScreenUtil.getInstance().getAdapterSize(40),
        child: ElevatedButton(
          onPressed: () {
            //Call API
            if (_formKeyOldPass.currentState!.validate() &&
                _formKeyNewPass.currentState!.validate() &&
                _formKeyConfirmPass.currentState!.validate()) {
              // _bloc.changePassword(
              //     _oldPassword.text, _newPassword.text, _confirmPassword.text);
            }
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
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: ScreenUtil.getInstance().getAdapterSize(10)),
            suffixIcon: IconButton(
              icon: Icon(
                  isShow
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey),
              onPressed: onPressed,
            ),),
        validator: validator,
      ),
    );
  }
}
