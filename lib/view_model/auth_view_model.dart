// lib/logic/viewmodels/auth_view_model.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  AuthViewModel(this._repo) {
    // listen for auth state changes (optional but helpful)
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      final e = event.event;
      if (e == AuthChangeEvent.passwordRecovery) {
        _passwordRecovery = true;
        notifyListeners();
      }

      // update current user cached
      _currentUser = Supabase.instance.client.auth.currentUser;
      notifyListeners();
    });
  }

  bool isLoading = false;
  String? error;
  User? _currentUser;
  bool _passwordRecovery = false; // set when recovery link clicked

  User? get currentUser => _currentUser;
  bool get passwordRecoveryMode => _passwordRecovery;

  void clearError() {
    error = null;
    notifyListeners();
  }

  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    isLoading = true;
    notifyListeners();

    final res = await _repo.signUp(
      email: email,
      password: password,
      username: username,
    );

    isLoading = false;

    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }

    return true;
  }

  Future<bool> loginWithPassword(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final res = await _repo.signInWithPassword(email, password);

    isLoading = false;

    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }

    _currentUser = Supabase.instance.client.auth.currentUser;
    notifyListeners();
    return true;
  }

  Future<bool> sendOtp(String email) async {
    isLoading = true;
    notifyListeners();

    final res = await _repo.sendOtpToEmail(email);

    isLoading = false;
    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> verifyOtp(String email, String token) async {
    isLoading = true;
    notifyListeners();

    final res = await _repo.verifyOtp(email, token);

    isLoading = false;
    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }

    _currentUser = Supabase.instance.client.auth.currentUser;
    notifyListeners();
    return true;
  }

  Future<bool> resendVerification(String email) async {
    final res = await _repo.resendVerification(email);
    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> sendPasswordReset(String email) async {
    isLoading = true;
    notifyListeners();

    final res = await _repo.sendPasswordResetEmail(email);

    isLoading = false;
    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> updatePassword(String newPassword) async {
    isLoading = true;
    notifyListeners();

    final res = await _repo.updatePassword(newPassword);

    isLoading = false;
    if (res != null) {
      error = res;
      notifyListeners();
      return false;
    }

    // after update, sign out to force normal login
    await _repo.signOut();
    _currentUser = null;
    _passwordRecovery = false;
    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    await _repo.signOut();
    _currentUser = null;
    notifyListeners();
  }
}