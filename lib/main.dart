import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:type_arena/views/homePage/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          ThemeData.dark().textTheme
        ),
        primaryTextTheme: GoogleFonts.spaceGroteskTextTheme(),
        primaryColor: Color(0xFF1193d4),
      ),
      home: LandingPage(),
    );
  }
}