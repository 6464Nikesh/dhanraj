import 'dart:async';
import 'dart:convert';

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/utils/app_assets.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/preference_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences? sp;
  LoginModel? loginModel;

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback(
       (timeStamp) async {
         sp = await SharedPreferences.getInstance();
         String data = sp?.getString(PreferenceKey.loginData) ?? "";

         if(data.isNotEmpty){
           loginModel = LoginModel.fromJson(jsonDecode(sp?.getString(PreferenceKey.loginData) ?? ""));
           print(loginModel?.toJson());
         }

         await Future.delayed(
           const Duration(seconds: 1),
           () {
             if (loginModel != null) {
               Navigator.pushNamed(context, AppRoutes.dashboard);
             } else {
               Navigator.pushNamed(context, AppRoutes.login);
             }
           },
         );
       },
     );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
      ),
      body:  Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.logo,scale: 4,)
              ],
            ),
          ),
          Center(
            child: Text(
              AppStrings.aPaperTradingApp,
              style: TextStyle(color: AppColors.grey, fontFamily: "roboto"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
