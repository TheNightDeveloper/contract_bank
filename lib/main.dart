import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:contracts_bank/config/routes/pages.dart';
import 'package:contracts_bank/core/utils/const.dart';

Future<void> main() async {
  await init();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [...AppPages.allProviders(context)],
        builder: (context, child) => ScreenUtilInit(
              builder: (context, child) => const MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppPages.generateRoutes,
              ),
            ));
  }
}
