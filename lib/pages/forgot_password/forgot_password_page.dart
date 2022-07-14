// import 'package:eton_partner/base/base_bloc.dart';
// import 'package:eton_partner/base/base_page.dart';
// import 'package:eton_partner/generated/l10n.dart';
// import 'package:eton_partner/pages/forgot_password/forgot_password_bloc.dart';
// import 'package:eton_partner/res/colors.dart';
// import 'package:eton_partner/routers/screen_arguments.dart';
// import 'package:eton_partner/utils/common_utils/screen_util.dart';
// import 'package:eton_partner/widgets/button/button_submit_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
//
// // @Auth: hau.tran
// // @Description: ForgotPassword Page
// // @Date: 28/12/2021
//
// class ForgotPasswordPage extends BasePage{
//   static const routeName = '/ForgotPasswordPage';
//   ForgotPasswordPage() : super(bloc: ForgotPasswordBloc());
//
//   @override
//   BasePageState<BasePage<BaseBloc>> getState() => _ForgotPasswordPageState();
// }
//
// class _ForgotPasswordPageState extends BasePageState<ForgotPasswordPage>{
//   late ForgotPasswordBloc _bloc;
//   final FocusNode _focusNodePhoneNumber = FocusNode();
//   final TextEditingController _phoneController = TextEditingController();
//   final _formKeyPhone = GlobalKey<FormState>();
//   final RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
//
//   @override
//   void onCreate() {
//     _bloc = getBloc();
//   }
//
//   @override
//   void onDestroy() {
//     // TODO: implement onDestroy
//   }
//
//   @override
//   Widget buildWidget(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: EdgeInsets.only(
//             left: ScreenUtil.getInstance().getAdapterSize(16),
//             right: ScreenUtil.getInstance().getAdapterSize(16),
//             top: ScreenUtil.getInstance().getAdapterSize(30)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(S.current.password_retrieval,
//                 style: TextStyle(
//                     fontSize: ScreenUtil.getInstance().getAdapterSize(30))),
//             _itemPadding(12),
//             Text(
//                 S.current.re_enter_phone_to_take_password,
//                 style: TextStyle(
//                     fontSize: ScreenUtil.getInstance().getAdapterSize(14),
//                     color: AppColor.colorTextGray)),
//             _itemPadding(50),
//             Text(S.of(context).phone_number,
//                 style: TextStyle(
//                     fontSize: ScreenUtil.getInstance().getAdapterSize(18),
//                     color: AppColor.colorTextGray)),
//             _itemPadding(12),
//             _itemInput(
//                 hintText: S.of(context).input_phone_number,
//                 autoFocus: true,
//                 focusNode: _focusNodePhoneNumber,
//                 obscureText: false,
//                 globalKey: _formKeyPhone,
//                 onSubmit: (value) {
//                   _focusNodePhoneNumber.unfocus();
//                   if (_formKeyPhone.currentState!.validate()) {
//                     // _bloc.loginOTP(_phoneController.text);
//                     // Navigator.pushNamed(context, VerifyOTPPage.routeName, arguments: ScreenArguments(arg1: _phoneController.text));
//                   }
//                 },
//                 controller: _phoneController,
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return S.of(context).empty_phone_number;
//                   } else if (value.length != 10 || !regExp.hasMatch(value)) {
//                     return S.of(context).invalid_phone_number;
//                   }
//                   return null;
//                 }),
//             const Spacer(),
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: ScreenUtil.getInstance().getAdapterSize(15),
//                   left: ScreenUtil.getInstance().getAdapterSize(16),
//                   right: ScreenUtil.getInstance().getAdapterSize(16)),
//               child: ButtonSubmitWidget(
//                 onPressed: () {
//                   if (_formKeyPhone.currentState!.validate()) {
//                     // _bloc.forgotPassword(_phoneController.text);
//                     Navigator.pushNamed(context, VerifyOTPPage.routeName, arguments: ScreenArguments(arg1: _phoneController.text));
//                   }
//                 },
//                 title: S.of(context).continues.toUpperCase(),
//                 colorTitle: Colors.white,
//                 height: ScreenUtil.getInstance().getAdapterSize(44),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: ScreenUtil.getInstance().getAdapterSize(50),
//                   left: ScreenUtil.getInstance().getAdapterSize(16),
//                   right: ScreenUtil.getInstance().getAdapterSize(16)),
//               child: GestureDetector(
//                 onTap: (){
//                   Navigator.pop(context);
//                 },
//                 child: Center(child: Text(S.current.login, style: TextStyle(fontSize: ScreenUtil.getInstance().getAdapterSize(18), color: Colors.orange),)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _itemPadding(double size){
//     return SizedBox(height: ScreenUtil.getInstance().getAdapterSize(size));
//   }
//
//   Widget _itemInput(
//       {required String hintText,
//         required bool autoFocus,
//         required FocusNode focusNode,
//         required ValueChanged<String?> onSubmit,
//         required TextEditingController controller,
//         required bool obscureText,
//         required GlobalKey globalKey,
//         required FormFieldValidator<String> validator,
//         TextInputType? keyboardType,
//         Widget? suffixIcon}) {
//     return Form(
//       key: globalKey,
//       child: TextFormField(
//         autofocus: autoFocus,
//         focusNode: focusNode,
//         keyboardType: keyboardType,
//         onFieldSubmitted: onSubmit,
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey),
//             filled: true,
//             fillColor: Colors.white,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               borderSide: BorderSide(color: Color(0x33101010), width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               borderSide: BorderSide(color: Color(0x33101010), width: 1),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               borderSide: BorderSide(color: Colors.red, width: 1),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               borderSide: BorderSide(width: 1, color: Colors.red),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 15),
//             suffixIcon: suffixIcon),
//         validator: validator,
//       ),
//     );
//   }
//
// }
