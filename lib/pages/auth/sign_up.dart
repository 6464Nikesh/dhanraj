import 'package:dhanraj/provider/provider_sign_up.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: Consumer<ProviderSignUp>(builder: (context, ps, child) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          const Text(
                            AppStrings.createAccount,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                AppStrings.alreadyHaveAnAccount,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  AppStrings.login,
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: ps.firstName,
                                  cursorColor: AppColors.grey,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    hintText: AppStrings.firstName,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: ps.lastName,
                                  cursorColor: AppColors.grey,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.grey),
                                    ),
                                    hintText: AppStrings.lastName,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          TextField(
                            controller: ps.mobile,
                            cursorColor: AppColors.grey,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              hintText: AppStrings.mobileNo,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          TextField(
                            controller: ps.email,
                            cursorColor: AppColors.grey,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              hintText: AppStrings.emailId,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          TextField(
                            controller: ps.password,
                            cursorColor: AppColors.grey,
                            obscureText: ps.isPasswordShow,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              suffixIcon: (ps.isPasswordShow)
                                  ? GestureDetector(
                                      onTap: () {
                                        ps.setPasswordVisibility();
                                      },
                                      child: const Icon(Icons.visibility))
                                  : GestureDetector(
                                      onTap: () {
                                        ps.setPasswordVisibility();
                                      },
                                      child: const Icon(Icons.visibility_off)),
                              hintText: AppStrings.enterPassword,
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          TextField(
                            controller: ps.confirmPassword,
                            cursorColor: AppColors.grey,
                            obscureText: ps.isConfirmPasswordShow,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                              ),
                              suffixIcon: (ps.isConfirmPasswordShow)
                                  ? GestureDetector(
                                      onTap: () {
                                        ps.setConfirmPasswordVisibility();
                                      },
                                      child: const Icon(Icons.visibility))
                                  : GestureDetector(
                                      onTap: () {
                                        ps.setConfirmPasswordVisibility();
                                      },
                                      child: const Icon(Icons.visibility_off)),
                              hintText: AppStrings.confirmPassword,
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.bySigningUpYouAgreeToThe,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "roboto",
                                  color: AppColors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      ps.openBrowserUrl("https://dhanraj.trading/termsandcondition");
                                    },
                                    child: Text(
                                      AppStrings.termsAndCondition,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "roboto",
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    AppStrings.and,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "roboto",
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      ps.openBrowserUrl("https://dhanraj.trading/privacy-policy/");
                                    },
                                    child: Text(
                                      AppStrings.privacyPolicy,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "roboto",
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              ps.login(context: context);
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
                                    AppStrings.signIn,
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
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.welcome,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "roboto",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "!",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "roboto",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppStrings.registerWithYourPersonalDetailsToUseAllOfSiteFeatures,
                        style: TextStyle(
                          fontFamily: "roboto",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(color: Colors.white)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                AppStrings.signIn,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "roboto",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
