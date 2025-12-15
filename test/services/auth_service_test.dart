import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/services/auth_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
      // Reset authentication state
      authService.logout();
    });

    test('should be a singleton', () {
      final authService1 = AuthService();
      final authService2 = AuthService();
      expect(authService1, same(authService2));
    });

    test('should return false when not authenticated', () {
      expect(authService.isAuthenticated(), false);
    });

    test('should return true after login', () {
      authService.login();
      expect(authService.isAuthenticated(), true);
    });

    test('should return false after logout', () {
      authService.login();
      expect(authService.isAuthenticated(), true);
      
      authService.logout();
      expect(authService.isAuthenticated(), false);
    });

    test('should persist login state across multiple checks', () {
      authService.login();
      expect(authService.isAuthenticated(), true);
      expect(authService.isAuthenticated(), true);
      expect(authService.isAuthenticated(), true);
    });
  });
}
