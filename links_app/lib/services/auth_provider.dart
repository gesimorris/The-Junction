import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final token = await AuthService.getToken();
    state = token != null;
  }

  Future<bool> login(String email, String password) async {
    final success = await AuthService.login(email, password);
    if (success) state = true;
    return success;
  }

  Future<bool> register(String fName, String lName, String email, String password) async {
    return await AuthService.register(fName, lName, email, password);
  }

  void logout() {
    AuthService.logout();
    state = false;
  }
}