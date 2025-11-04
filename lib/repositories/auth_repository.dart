// lib/data/repositories/auth_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Email + password sign up (stores username in 'profiles' table)
  Future<String?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      if (res.user == null) return 'Failed to create user';
      await _supabase.auth.signInWithPassword(password: password,email: email);

      // store profile
      await _supabase.from('profiles').insert({
        'id': res.user!.id,
        'email': email,
        'username': username,
        'password':password,
      });

      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Email + password login
  Future<String?> signInWithPassword(String email, String password) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.session == null) return 'Invalid credentials';
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Send 6-digit OTP to email (magic-link/OTP depending on project settings)
  Future<String?> sendOtpToEmail(String email) async {
    try {
      await _supabase.auth.signInWithOtp(email: email);
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Verify OTP code
  Future<String?> verifyOtp(String email, String token) async {
    try {
      await _supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: token,
      );
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Resend verification (email confirmation)
  Future<String?> resendVerification(String email) async {
    try {
      await _supabase.auth.resend(type: OtpType.email, email: email);
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Send password reset email (Supabase hosted form by default)
  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Update the user's password (user is in recovery mode after clicking email link)
  Future<String?> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Sign out
  Future<void> signOut() async => await _supabase.auth.signOut();

  // Helper: is email verified
  Future<bool> isEmailVerified() async {
    await _supabase.auth.refreshSession();
    final user = _supabase.auth.currentUser;
    return user?.emailConfirmedAt != null;
  }

  // Current user
  User? currentUser() => _supabase.auth.currentUser;
}