import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/pages/login_page.dart';
import 'package:orbithub_based_project/pages/tabs_page.dart';
import 'package:orbithub_based_project/services/auth_service.dart';

void main() {
  group('LoginPage', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
      authService.logout();
    });

    testWidgets('should display login error message and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.byIcon(Icons.lock), findsOneWidget);
      expect(find.text('Please log in to continue'), findsOneWidget);
      expect(find.text('Login Required'), findsOneWidget);
    });

    testWidgets('should have a login button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets('should navigate to TabsPage after login',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Verify user is not authenticated
      expect(authService.isAuthenticated(), false);

      // Tap login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      // Verify navigation to TabsPage
      expect(find.byType(TabsPage), findsOneWidget);
      expect(find.byType(LoginPage), findsNothing);
      
      // Verify user is now authenticated
      expect(authService.isAuthenticated(), true);
    });
  });
}
