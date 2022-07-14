// import 'package:eton_partner/base/base_bloc.dart';
// import 'package:eton_partner/data/model/auth/forgot_password_model.dart';
// import 'package:eton_partner/data/service/auth_service.dart';
// import 'package:eton_partner/pages/forgot_password/verify_otp/verify_otp_page.dart';
// import 'package:eton_partner/routers/screen_arguments.dart';
// import 'package:eton_partner/utils/logs/logger.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
//
// class ForgotPasswordBloc extends BaseBloc{
//   final _loginOTPController = BehaviorSubject<LoginOTPModel>();
//   late BuildContext _context;
//
//   Stream<LoginOTPModel> get streamLoginOTP => _loginOTPController.stream;
//
//   Future<void> loginOTP(String phone) async{
//     showLoading();
//     await AuthService.instance.loginOTP(phone).then((value) {
//       if(value.errorCode == 0){
//         Navigator.pushNamed(_context, VerifyOTPPage.routeName, arguments: ScreenArguments(arg1: phone));
//       }
//       if(value.message == 'Ok!'){
//         showMsg('Mã OTP đã được gửi');
//       }else{
//         showMsg(value.message);
//       }
//       hiddenLoading();
//     }).catchError((error){
//       hiddenLoading();
//       DebugLog.show('Forgot password error: ${error.toString()}');
//     });
//   }
//
//   @override
//   void dispose() {
//     _loginOTPController.close();
//   }
//
//   @override
//   void onCreate(BuildContext context) {
//     _context = context;
//   }
//
// }