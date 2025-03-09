import 'package:flutter/material.dart';

import '../first_page/presentation/pages/first_page.dart';
import '../pages/second_page.dart';
import '../third_page/presentation/pages/third_page.dart';

class AppRoute {
  static const first = '/';
  static const second = '/second-page';
  static const third = '/thrid-page';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case first:
        return MaterialPageRoute(builder: (context) => const FirstPage());
      case second:
        final args = settings.arguments;
        if (args == null) {
          return _invalidArgumentPage;
        } else if (args is! Map<String, dynamic>) {
          return _invalidArgumentPage;
        }
        return MaterialPageRoute(
            builder: (context) => SecondPage(
                  name: args['name'] ?? '',
                  user: args['user'] ?? 'Selected User Name',
                ));
      case third:
        final args = settings.arguments;
        if (args == null) {
          return _invalidArgumentPage;
        } else if (args is! String) {
          return _invalidArgumentPage;
        }
        return MaterialPageRoute(builder: (context) => ThirdPage(name: args));
      default:
        return _notFoundPage;
    }
  }

  static MaterialPageRoute get _invalidArgumentPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Invalid Argument'),
            ),
          ));

  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ));
}
