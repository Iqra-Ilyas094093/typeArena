import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:type_arena/repositories/auth_repository.dart';
import 'package:type_arena/utils/proj_url.dart';
import 'package:type_arena/view_model/auth_view_model.dart';
import 'package:type_arena/view_model/typing_provider.dart';
import 'package:type_arena/view_model/typing_view_model.dart';
import 'package:type_arena/views/dashboard/dashboard_page.dart';
import 'package:type_arena/views/homePage/home_page.dart';
import 'package:type_arena/views/navigation/navigation.dart';
import 'package:type_arena/views/second%20try.dart';
import 'package:type_arena/views/try.dart';

import 'model/code_snippet.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: ProjUrl.url, anonKey: ProjUrl.anonKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthRepository _repo = AuthRepository();

    final CodeSnippet initialSnippet = CodeSnippet(
      id: '1',
      language: 'JavaScript',
      title: 'Palindrome Check',
      difficulty: Difficulty.beginner,
      code: '''function isPalindrome(str) {
  return str === str.split('').reverse().join('');
}''',
    );
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthViewModel(_repo)),
        ChangeNotifierProvider(create: (_)=>TypingViewModel(initialSnippet)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.spaceGroteskTextTheme(
            ThemeData.dark().textTheme
          ),
          primaryTextTheme: GoogleFonts.spaceGroteskTextTheme(),
          primaryColor: Color(0xFF1193d4),
        ),
        home: CodeTypingTest(),
      ),
    );
  }
}