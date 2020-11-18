import 'package:eoscalculator/locator.dart';
import 'package:eoscalculator/providers/AppStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';

void main() {
  setupLocator();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>(
          create: (context) => locator<AppStateProvider>(),
          child: HomePage(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      )));
}
