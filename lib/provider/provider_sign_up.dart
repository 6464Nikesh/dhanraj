import 'dart:convert';
import 'dart:ffi' hide Size;

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/model/sign_up_model.dart';
import 'package:dhanraj/services/networking.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/app_widget.dart';
import 'package:dhanraj/utils/miscellaneous.dart';
import 'package:dhanraj/utils/preference_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide Size;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderSignUp extends ChangeNotifier with Networking {
  TextEditingController firstName = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController lastName = TextEditingController();
  bool isPasswordShow = true;
  bool isConfirmPasswordShow = true;
  late BuildContext parentContext;
  SharedPreferences? sp;

  setPasswordVisibility() {
    if (isPasswordShow) {
      isPasswordShow = false;
    } else {
      isPasswordShow = true;
    }
    notifyListeners();
  }

  init({required BuildContext context}) {
    parentContext = context;
    notifyListeners();
  }

  setConfirmPasswordVisibility() {
    if (isConfirmPasswordShow) {
      isConfirmPasswordShow = false;
    } else {
      isConfirmPasswordShow = true;
    }
    notifyListeners();
  }

  bool validation(BuildContext context) {
    RegExp regex = RegExp(Miscellaneous.emailPattern);

    // First Name
    if (firstName.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.firstName}", AppColors.red, Colors.white);
      return false;
    } else if (firstName.text.trim().length < 3) {
      AppWidget().snackBar(context, "${AppStrings.firstName} must be at least 3 characters", AppColors.red, Colors.white);
      return false;
    }

    // Last Name
    else if (lastName.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.lastName}", AppColors.red, Colors.white);
      return false;
    } else if (lastName.text.trim().length < 3) {
      AppWidget().snackBar(context, "${AppStrings.lastName} must be at least 3 characters", AppColors.red, Colors.white);
      return false;
    }

    // Mobile
    else if (mobile.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.mobileNo}", AppColors.red, Colors.white);
      return false;
    } else if (mobile.text.trim().length < 10) {
      AppWidget().snackBar(context, "${AppStrings.mobileNo} must be at least 10 digits", AppColors.red, Colors.white);
      return false;
    }

    // Email
    else if (email.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.emailId}", AppColors.red, Colors.white);
      return false;
    } else if (!regex.hasMatch(email.text.trim())) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.valid} ${AppStrings.emailId}", AppColors.red, Colors.white);
      return false;
    }

    // Password
    else if (password.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.password}", AppColors.red, Colors.white);
      return false;
    } else if (password.text.trim().length < 6) {
      AppWidget().snackBar(context, "${AppStrings.password} must be at least 6 characters", AppColors.red, Colors.white);
      return false;
    }

    // Confirm Password
    else if (confirmPassword.text.trim().isEmpty) {
      AppWidget().snackBar(context, "${AppStrings.pleaseEnter} ${AppStrings.confirmPassword}", AppColors.red, Colors.white);
      return false;
    } else if (password.text.trim() != confirmPassword.text.trim()) {
      AppWidget().snackBar(context, AppStrings.passwordIsNotMatched, AppColors.red, Colors.white);
      return false;
    }

    return true;
  }


  Future<void> sendOtp() async {
    if (validation(parentContext)) {
      showDialog(
        context: parentContext,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );

      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91${mobile.text}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            Navigator.pop(parentContext);
            AppWidget().snackBar(parentContext, "Error: ${e.message}", Colors.redAccent, Colors.white);
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.pop(parentContext);
            otpVerification(verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        print("Nikesh");
        print(e);
      }
    }
  }

  Future<void> createNewUser() async {
    otp.clear();
    sp = await SharedPreferences.getInstance();
    if (validation(parentContext)) {
      var postMap = {
        "first_name": firstName.text.trim(),
        "last_name": lastName.text.trim(),
        "mobile": mobile.text.trim(),
        "email": email.text.trim(),
        "password": password.text.trim(),
        "confirm_password": confirmPassword.text.trim(),
        "parent_user_id": "1",
        "initial_balance": 100000
      };

      await post(context: parentContext, mapData: postMap, endPoint: AppApiEndPoint.signUpUser, isLoaderShow: true, fromBottomSheet: false).then(
        (value) {
          if (value != null) {
            SignUpModel signUpModel = SignUpModel.fromJson(value);
            showSuccessBottomSheet(signUpModel.message ?? "");
          }
        },
      );
    }
  }

  Future<void> openBrowserUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void showSuccessBottomSheet(String msg) {
    showModalBottomSheet(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                "Success!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                msg,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: AppColors.blue),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        AppStrings.login,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "roboto",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> verifyOtp({required String verificationId}) async {
    bool returnValue = false;
    if (otp.text.isEmpty || otp.text.length < 6) {
      AppWidget().snackBarTop(parentContext, "Please enter valid OTP.", AppColors.red, Colors.white);
    }

    showDialog(
      context: parentContext,
      builder: (context) {
        return AppWidget().loader(context);
      },
    );

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp.text,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) {
          Navigator.pop(parentContext);
          if (value.user != null) {
            returnValue = true;
          }
        },
      );
    } catch (e) {
      Navigator.pop(parentContext);
      AppWidget().snackBarTop(parentContext, "Invalid OTP: $e", AppColors.red, Colors.white);
    }
    return returnValue;
  }

  void otpVerification(String verificationId) {
    showModalBottomSheet(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      barrierLabel: "barrier",
      isDismissible: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: PopScope(
            canPop: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: otp,
                  cursorColor: AppColors.grey,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                    hintText: "${AppStrings.enter} ${AppStrings.otp}",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Please, Enter OTP Here!",
                  textAlign: TextAlign.center,
                  style: Theme.of(parentContext).textTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await verifyOtp(verificationId: verificationId).then(
                      (value) async {
                        if (value == true) {
                          Navigator.pop(parentContext);
                          await createNewUser().then(
                            (value) {},
                          );
                        }
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: AppColors.blue),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          AppStrings.verify,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "roboto",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
