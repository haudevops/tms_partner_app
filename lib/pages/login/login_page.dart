import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/prefs_const.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

class LoginPage extends BasePage {
  LoginPage({Key? key}) : super(bloc: LoginBloc());
  static const routeName = '/LoginPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {
  final FocusNode _focusNodePhoneNumber = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _passwordVisible = false;
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late LoginBloc _bloc;
  bool _isLogin = false;

  @override
  void onCreate() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _bloc = getBloc();
  }

  @override
  void onDestroy() {
    _passController.clear();
    _phoneController.clear();
    _focusNodePhoneNumber.unfocus();
    _focusNodePassword.unfocus();
  }

  Future<void> _initToken(bool token) async{
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(PrefsCache.IS_LOGIN, true);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
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
                  S.current.please_enter_phone_and_password,
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
                  onChange: (value){},
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
                  onChange: (value){
                    if (_formKeyPhone.currentState!.validate() &&
                        _formKeyPass.currentState!.validate()){
                      setState((){
                        _isLogin = true;
                      });
                    }else{
                      setState((){
                        _isLogin = false;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.of(context).empty_pass_word;
                    }
                    return null;
                  }),
              _itemPadding(32),
              ButtonSubmitWidget(
                onPressed: () {
                  if (_formKeyPhone.currentState!.validate() &&
                      _formKeyPass.currentState!.validate()) {
                    _bloc.login(_phoneController.text, _passController.text);
                    // _initToken( true);
                    // Navigator.pushReplacementNamed(context, NavigationPage.routeName);
                  }

                  // _bloc.login(_phoneController.text, _passController.text);
                },
                backgroundColors: _isLogin,
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
      required ValueChanged<String?> onChange,
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
        style: const TextStyle(color: Colors.black),
        onChanged: onChange,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0x33101010), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0x33101010), width: 1),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            suffixIcon: suffixIcon),
        validator: validator,
      ),
    );
  }
}
