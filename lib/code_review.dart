// import 'package:flutter/material.dart';
//
// class OnboardingOtpScreen extends StatefulWidget {
//   OnboardingOtpScreen({Key? key,
//     required this.mobileNo,
//     required this.userId,
//     required this.email,
//     required this.password,
//     this.userProfileBean,
//     this.registrationBean,
//     this.option = OtpOption.PHONE,
//     this.otpVerifyPurpose = OtpVerifyPurpose.FIRSTTIMELOGIN})
//       : super(key: key);
//   String mobileNo;
//   String userId;
//   String email;
//   String password;
//
// // For Login
//   UserProfileBean? userProfileBean;
//
// // For Registration
//   RegistrationBean? registrationBean;
//   OtpOption option;
//
//   OtpVerifyPurpose otpVerifyPurpose;
//
//   @override
//   State<OnboardingOtpScreen> createState() => _OnboardingOtpScreenState();
// }
//
// class _OnboardingOtpScreenState extends State<OnboardingOtpScreen> {
//   late RegistrationBloc _registrationBloc;
//   late UserBloc _userBloc;
//   late OTPBloc _otpBloc;
//   late SendOTPBean _sendOTPBean;
//   SentOTPBean? _sentOTPBean;
//   late String errorText;
//   String? activationErrorText;
//   late OtpFieldController _otpFieldController;
//   bool countingDown = false;
//
//   @override
//   void initState() {
//     super.initState();
//     errorText = "";
//     _registrationBloc = RegistrationBloc();
//     _otpBloc = OTPBloc();
//     _userBloc = UserBloc();
//     _otpFieldController = OtpFieldController(onVerify: (otpValue) {
//       verifyOTP(otpValue);
//     });
//     _sendOTPBean = SendOTPBean(
//         mobileNo: widget.mobileNo,
//         userId: widget.userId,
//         option: widget.option.optionName,
//         email: widget.email);
//     if (kReleaseMode) {
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         _initSendOtp();
//       });
//     }
//   }
//
//   _initSendOtp() async {
// //TODO: Currently By Pass OTP, OTP Integration Testing Successful. Uncomment this before compile
//     final loadingDialog = ViewBloc.showLoadingDialog(context,
//         ";${mtl("otpSending")}${StringUtil.maskString(widget.mobileNo)}";);
//     dynamic result = await _otpBloc.sendOtp(_sendOTPBean);
//     await Future.delayed(const Duration(milliseconds: 80));
//     loadingDialog.dismiss(() {});
// // If OTP sent successful, it will return SentOTPBean else it&#39;s a error message
//
//     if (result.runtimeType == SentOTPBean) {
//       _sentOTPBean = result;
//       setState(() {
//         countingDown = true;
//         errorText = "";
//       });
//     } else {
//       setState(() {
//         errorText = result.toString();
//       });
//     }
//   }
//
//   // In debug mode, no OTP is required.
//   Future<void>
//
//   verifyOTP(String otpValue) async {
//     bool verifyResult = true;
// // If it&#39;s in release mode, this should be execute to verify the OTP
//     if (kReleaseMode) {
//       final loadingDialog = ViewBloc.showLoadingDialog(context, mtl("otpVerifying"));
//       verifyResult = await _otpBloc.verifyOtp(
//           otpValue, _sendOTPBean.userId,
//           _sentOTPBean ??
//               SentOTPBean(otpRefNo: "", resendIntervalInMins: 0, otpMaxReattempt: 0),
//           context,
//               (errMsg) {
//             setState(() {
//               errorText = errMsg;
//             });
//           }
//       );
//       await Future.delayed(const Duration(milliseconds: 2000));
//       loadingDialog.dismiss(() {});
//     }
// // In debug mode, this checking will always true
//     if (verifyResult || kDebugMode) {
//       await ViewBloc.showSuccessDialogForAwhile(context, successMessage: mtl("otpVerified"));
// //After verification success, different process for firs-time login and registration
//       if (widget.otpVerifyPurpose.verifyPurposeName ==
//           OtpVerifyPurpose.REGISTRATION.verifyPurposeName) {
//         processForRegistration();
//       } else if (widget.otpVerifyPurpose.verifyPurposeName ==
//           OtpVerifyPurpose.FIRSTTIMELOGIN.verifyPurposeName) {
//         processForFirstTimeLogin();
//       } else if (widget.otpVerifyPurpose.verifyPurposeName ==
//           OtpVerifyPurpose.CHANGEPASSWORD.verifyPurposeName) {
//         processForChangePassword();
//       } else {
//         processForResetPassword();
//       }
//     } else {
// //Verification failed, delete all the text field and re-enter
//       _otpFieldController.verifyUnsuccessful();
//     }
//   }
//
//   Future<void> processForRegistration() async {
//     bool isCustomer = widget.registrationBean?.isCustomer ?? false;
//     if (!isCustomer) {
//       final result = await _registrationBloc.sendValidationEmail(
//           _sendOTPBean.userId, _sendOTPBean.email ?? "", context);
//
//       logNUI("Otp Screen", "First-time Login Error : $e");
//       await ViewBloc.showFailedDialogForAwhile(
//         context, errorMessage: mtl("loginUnsuccessfulDialog"),);
//       NUINavigator.popAllAndPush(context, const BaseScreen());
//     }
//   }
// }
//
// Future<void> processForResetPassword() async {
//   NUINavigator.popAndPush(
//       context, NewPasswordScreen(isFirstStep: false, userId: widget.userId,));
// }
//
// Future<void>
//
// processForChangePassword() async {
//   NUINavigator.popAndPush(
//       context, NewPasswordScreen(isFirstStep: false, userId: widget.userId,
//       inAppChangePassword: true));
// }
//
// Future<bool>
//
// showTerminateDialog() async {
//   final result = await ViewBloc.showAlertDialog(
//       context,
//       title: "${mtl("otpTerminateDialog")} ${widget.otpVerifyPurpose.name} ${mtl(
//           "otpTerminateDialog2")}",
//       positiveText: mtl("yes"),
//       onPressedPositive: () {
//         NUINavigator.popWithResult(context, true);
//       },
//       negativeText: mtl("no"),
//       onPressedNegative: () {
//         NUINavigator.popWithResult(context, false);
//       }
//   );
//   return result;
// }
//
// @override
// Widget build(BuildContext context) {
//   return WillPopScope(
//       onWillPop: () async {
//         return await showTerminateDialog();
//       },
//       child: AnnotatedRegion & lt;SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.dark,
//       child: Scaffold(
//         backgroundColor: AppColors.BackgroundWhite,
//         body: Column(
//           children: [
//             BackToolbar(
//               title: Text(
//                 mtl("verification"), style: uiTheme.font(size: 18, colorPair: accentBlue),
//                 textAlign:
//                 TextAlign.center,),
//               withShadow: true,
//               withStatusBar: true,
//               backButton: true,
//
//               backIcon: Icon(Icons.arrow_back_rounded, color: uiTheme.color(accentBlue)),
//               onPressed: () async {
//                 final result = await showTerminateDialog();
//                 if (result) {
//                   NUINavigator.pop(context);
//                 }
//               },
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("${widget.otpVerifyPurpose.verifyPurposeName} ${mtl(
//                           "verification")}", style: uiTheme.font(size:
//                       18, colorPair: darkBlue),),
//                       const Divider(height: 16),
//                       Text(
//                           mtl("otpDesc"), style: uiTheme.font(size: 16, colorPair: greyTwo)),
//                       const Divider(height: 30),
//                       Text(isNullOrEmpty(errorText) ? "" : errorText,
//                           style: uiTheme.font(size: 14, colorPair: red)),
//                       const Divider(height: 8),
//                       OtpField(otpFieldController: _otpFieldController,),
//                       const Divider(height: 15),
//                       Visibility(
//                           visible: countingDown,
//                           child: Text("OTP has been sent to ${StringUtil.maskString(
//                               widget.mobileNo)}.", style:
//                           uiTheme.font(size: 14, colorPair: darkBlue))
//                       ),
//                       const Divider(height: 30),
//                       Align(
//                         alignment: Alignment.center,
//                         child: RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             text: &#39;${mtl("otpDidNotGetCode")} &#39;,
//                             style: uiTheme.font(size: 18, colorPair: darkBlue),
//                             children: [
//                               TextSpan(
//                                 text: mtl("otpResend"),
//                                 style: uiTheme.font(size: 18,
//                                     color: countingDown ? uiTheme.color(accentBlue)
//                                         .withOpacity(0.3) :
//                                     uiTheme.color(accentBlue)),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = countingDown ? null : () async {
//                                     await _initSendOtp();
//                                   },
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const Divider(height: 8),
//                       Visibility(
//
//                           visible: countingDown,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("Resend in ", style: uiTheme.font(
//                                   size: 14, colorPair: darkBlue)),
//                               CustomTimer(
//                                 seconds: 305,
//                                 onFinished: () {
//                                   countingDown = false;
//                                   setState(() {});
//                                 },),
//                             ],
//                           )
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//   ),);
// }