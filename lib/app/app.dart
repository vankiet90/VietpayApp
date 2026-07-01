import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

class VietpayApp extends StatelessWidget {
  const VietpayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
