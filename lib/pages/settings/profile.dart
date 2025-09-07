import 'dart:convert';

import 'package:dhanraj/model/login_model.dart';
import 'package:dhanraj/utils/app_appbar.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/app_strings.dart';
import 'package:dhanraj/utils/preference_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences? sp;
  LoginModel? loginModel;

  getPrefData() async {
    sp = await SharedPreferences.getInstance();
    String data = sp?.getString(PreferenceKey.loginData) ?? "";

    if (data.isNotEmpty) {
      loginModel = LoginModel.fromJson(jsonDecode(data));
    }

    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getPrefData();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppbar.appBar(AppStrings.profile),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 55,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkBlue,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                loginModel?.result?.user?.firstName?[0].toUpperCase() ?? "",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "roboto",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${loginModel?.result?.user?.firstName ?? ""} ${loginModel?.result?.user?.lastName ?? ""}",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "roboto",
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              loginModel?.result?.user?.emailId ?? "",
                              style: TextStyle(
                                fontFamily: "roboto",
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 33,
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         borderRadius: const BorderRadius.all(
                    //           Radius.circular(8),
                    //         ),
                    //         border: Border.all(color: AppColors.blue)),
                    //     child: Center(
                    //       child: const Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 10),
                    //         child: Text(
                    //           AppStrings.editProfile,
                    //           style: TextStyle(
                    //             fontSize: 18,
                    //             fontFamily: "roboto",
                    //             color: AppColors.blue,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 33,
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
