import 'package:example/views/BankDetailScreen.dart';
import 'package:example/views/HomeScreen.dart';
import 'package:example/views/WalkThroughScreen.dart';
import 'package:flutter/material.dart';
import 'package:okra_widget/okra_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins"
      ),
      home: WalkThroughScreen(),
      routes: {
        '/intro': (context) => WalkThroughScreen(),
        '/home': (context) => HomeScreen(),
        '/details': (context) => BankDetailScreen(),
      },
    );
  }
}
