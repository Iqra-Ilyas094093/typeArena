import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:type_arena/views/authentication/login_page.dart';
import 'package:type_arena/views/dashboard/dashboard_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Loading state
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final session = snapshot.data?.session;

        // User is not logged in → Show Login Screen
        if (session == null) {
          return const LoginPage();
        }

        // User is logged in → Show Home Screen
        return const DashboardPage();
      },
    );
  }
}
