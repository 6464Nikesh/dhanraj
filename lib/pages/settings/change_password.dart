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
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        Provider.of<ProviderChangePassword>(context, listen: false).clear();
      },
      child: Consumer<ProviderChangePassword>(builder: (context, pcp, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                AppStrings.changePassword,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 19,
              ),
              TextField(
                style: const TextStyle(fontFamily: "roboto", fontSize: 14, fontWeight: FontWeight.w600),
                controller: pcp.currentPassword,
                cursorColor: AppColors.grey,
                obscureText: pcp.isPasswordCurrentShow,
                decoration: InputDecoration(
                  suffixIcon: (pcp.isPasswordCurrentShow)
                      ? GestureDetector(
                          onTap: () {
                            pcp.setVisibilityCurrent();
                          },
                          child: const Icon(Icons.visibility))
                      : GestureDetector(
                          onTap: () {
                            pcp.setVisibilityCurrent();
                          },
                          child: const Icon(Icons.visibility_off)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "${AppStrings.current} ${AppStrings.password}",
                  hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              TextField(
                style: const TextStyle(fontFamily: "roboto", fontSize: 14, fontWeight: FontWeight.w600),
                controller: pcp.newPassword,
                cursorColor: AppColors.grey,
                obscureText: pcp.isPasswordNewShow,
                decoration: InputDecoration(
                  suffixIcon: (pcp.isPasswordNewShow)
                      ? GestureDetector(
                          onTap: () {
                            pcp.setVisibilityNew();
                          },
                          child: const Icon(Icons.visibility))
                      : GestureDetector(
                          onTap: () {
                            pcp.setVisibilityNew();
                          },
                          child: const Icon(Icons.visibility_off)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: AppStrings.newPassword,
                  hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              TextField(
                style: const TextStyle(fontFamily: "roboto", fontSize: 14, fontWeight: FontWeight.w600),
                controller: pcp.confirmPassword,
                cursorColor: AppColors.grey,
                obscureText: pcp.isPasswordConfirmShow,
                decoration: InputDecoration(
                  suffixIcon: (pcp.isPasswordConfirmShow)
                      ? GestureDetector(
                          onTap: () {
                            pcp.setVisibilityConfirm();
                          },
                          child: const Icon(Icons.visibility))
                      : GestureDetector(
                          onTap: () {
                            pcp.setVisibilityConfirm();
                          },
                          child: const Icon(Icons.visibility_off)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: AppStrings.confirmPassword,
                  hintStyle: const TextStyle(fontFamily: "roboto", fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.2), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    pcp.changePassword(context: context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
                  child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
