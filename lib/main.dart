import 'package:dhanraj/provider/deposit_withdrawal_sheet_provider.dart';
import 'package:dhanraj/provider/position_provider.dart';
import 'package:dhanraj/provider/provider_change_password.dart';
import 'package:dhanraj/provider/provider_dashboard.dart';
import 'package:dhanraj/provider/provider_funds.dart';
import 'package:dhanraj/provider/provider_global_search.dart';
import 'package:dhanraj/provider/provider_history.dart';
import 'package:dhanraj/provider/provider_login.dart';
import 'package:dhanraj/provider/provider_settings.dart';
import 'package:dhanraj/provider/provider_sign_up.dart';
import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/provider/web_socket_service.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/choose_image_provider.dart';
import 'package:dhanraj/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? sp;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        sp = await SharedPreferences.getInstance();
      },
    );
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderLogin()),
        ChangeNotifierProvider(create: (context) => ProviderSettings()),
        ChangeNotifierProvider(create: (context) => ProviderDashboard()),
        ChangeNotifierProvider(create: (context) => ProviderWatchlist()),
        ChangeNotifierProvider(create: (context) => ProviderGlobalSearch()),
        ChangeNotifierProvider(create: (context) => ProviderFunds()),
        ChangeNotifierProvider(create: (context) => ChooseImageProvider()),
        ChangeNotifierProvider(create: (context) => PositionProvider()),
        ChangeNotifierProvider(create: (context) => ProviderChangePassword()),
        ChangeNotifierProvider(create: (context) => ProviderHistory()),
        ChangeNotifierProvider(create: (context) => WebSocketService()),
        ChangeNotifierProvider(create: (context) => ProviderSignUp()),

        /// Bottom sheet Provider
        ChangeNotifierProvider(create: (context) => DepositWithdrawalSheetProvider())
      ],
      child: const MaterialApp(
        title: 'Dhanraj : A paper trading app',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
