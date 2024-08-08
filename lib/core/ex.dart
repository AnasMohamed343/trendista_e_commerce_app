import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/main.dart';

extension navigator on Widget {
  void goTo() =>
      Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) {
          return this;
        },
      ));
}
