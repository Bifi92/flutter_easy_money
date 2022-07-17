import 'package:easy_money/widgets/lista/main_navigation.dart';
import 'package:flutter/material.dart';

class EasyMoneyApp extends StatefulWidget {
  const EasyMoneyApp({Key? key}) : super(key: key);

  @override
  State<EasyMoneyApp> createState() => _EasyMoneyAppState();
}

class _EasyMoneyAppState extends State<EasyMoneyApp> {
  @override
  Widget build(BuildContext context) {
    return const MainNavigation();
  }
}
