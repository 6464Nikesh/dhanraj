import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_button.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider_change_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProviderChangePassword>(context, listen: false).getPrefData();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.changePassword),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          Provider.of<ProviderChangePassword>(context, listen: false).clear();
        },
        child: Consumer<ProviderChangePassword>(builder: (context, pcp, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 19,
                      ),
                      TextField(
                        controller: pcp.currentPassword,
                        cursorColor: AppColors.grey,
                        obscureText: pcp.isPasswordShow,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          suffixIcon: (pcp.isPasswordShow)
                              ? GestureDetector(
                                  onTap: () {
                                    pcp.setVisibility();
                                  },
                                  child: const Icon(Icons.visibility))
                              : GestureDetector(
                                  onTap: () {
                                    pcp.setVisibility();
                                  },
                                  child: const Icon(Icons.visibility_off)),
                          hintText: "${AppStrings.current} ${AppStrings.password}",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      TextField(
                        controller: pcp.newPassword,
                        cursorColor: AppColors.grey,
                        obscureText: pcp.isPasswordShow,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          suffixIcon: (pcp.isPasswordShow)
                              ? GestureDetector(
                                  onTap: () {
                                    pcp.setVisibility();
                                  },
                                  child: const Icon(Icons.visibility))
                              : GestureDetector(
                                  onTap: () {
                                    pcp.setVisibility();
                                  },
                                  child: const Icon(Icons.visibility_off)),
                          hintText: AppStrings.newPassword,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      TextField(
                        controller: pcp.confirmPassword,
                        cursorColor: AppColors.grey,
                        obscureText: pcp.isPasswordShow,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          suffixIcon: (pcp.isPasswordShow)
                              ? GestureDetector(
                                  onTap: () {
                                    pcp.setVisibility();
                                  },
                                  child: const Icon(Icons.visibility))
                              : GestureDetector(
                                  onTap: () {
                                    pcp.setVisibility();
                                  },
                                  child: const Icon(Icons.visibility_off)),
                          hintText: AppStrings.confirmPassword,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: GestureDetector(
                      onTap: () {
                        pcp.changePassword(context: context);
                      },
                      child: AppButton.button(
                        text: AppStrings.submit,
                        context: context,
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
