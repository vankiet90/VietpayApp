import 'package:flutter/material.dart';

import '../../features/currency/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
