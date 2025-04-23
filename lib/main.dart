import 'package:dhanraj/provider/bottom_sheet_provider.dart';
import 'package:dhanraj/provider/provider_dashboard.dart';
import 'package:dhanraj/provider/provider_global_search.dart';
import 'package:dhanraj/provider/provider_login.dart';
import 'package:dhanraj/provider/provider_settings.dart';
import 'package:dhanraj/provider/provider_watchlist.dart';
import 'package:dhanraj/utils/app_route.dart';
import 'package:dhanraj/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

        /// Bottom sheet Provider
        ChangeNotifierProvider(create: (context) => BottomSheetProvider())
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
