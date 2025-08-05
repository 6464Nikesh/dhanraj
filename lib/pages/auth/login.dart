import 'package:dhanraj/provider/provider_login.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/preference_key.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: Consumer<ProviderLogin>(
        builder: (context, pl, child) {
          return PopScope(
            canPop: false,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            const Text(
                              AppStrings.signIn,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text(
                            //       AppStrings.dontHaveAnAccount,
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //         fontFamily: "roboto",
                            //         fontWeight: FontWeight.w500,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 5,
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         Navigator.pushNamed(context, AppRoutes.signUp);
                            //       },
                            //       child: const Text(
                            //         AppStrings.createAccount,
                            //         style: TextStyle(
                            //           decoration: TextDecoration.underline,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w500,
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 19,
                            ),
                            TextField(
                              controller: pl.userName,
                              cursorColor: AppColors.grey,
                              textCapitalization: TextCapitalization.characters,
                              // Makes keyboard uppercase
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.grey),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.grey),
                                ),
                                hintText: AppStrings.username,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            TextField(
                              controller: pl.password,
                              obscureText: pl.isPasswordShow,
                              cursorColor: AppColors.grey,
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.grey),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.grey),
                                ),
                                suffixIcon: (pl.isPasswordShow)
                                    ? GestureDetector(
                                        onTap: () {
                                          pl.setVisibility();
                                        },
                                        child: const Icon(Icons.visibility))
                                    : GestureDetector(
                                        onTap: () {
                                          pl.setVisibility();
                                        },
                                        child: const Icon(Icons.visibility_off)),
                                hintText: AppStrings.password,
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                pl.login(context: context);
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
                            const Text(
                              AppStrings.forgetYourPassword,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "roboto",
                                color: AppColors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                              AppStrings.hey,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "roboto",
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              ",",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "roboto",
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              AppStrings.trader,
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
                                Navigator.pushNamed(context, AppRoutes.signUp);
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
                                    AppStrings.signUp,
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
            ),
          );
        },
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
