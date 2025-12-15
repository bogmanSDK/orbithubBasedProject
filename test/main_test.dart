import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/main.dart';
import 'package:orbithub_based_project/services/auth_service.dart';
import 'package:orbithub_based_project/pages/tabs_page.dart';
import 'package:orbithub_based_project/pages/login_page.dart';

void main() {
  group('MyApp', () {
    testWidgets('should create MaterialApp with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'OrbitHub Project');
    });
  });

  group('AuthCheckPage', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    testWidgets('should redirect to LoginPage when not authenticated',
        (WidgetTester tester) async {
      authService.logout();
      
      await tester.pumpWidget(const MaterialApp(home: AuthCheckPage()));

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(TabsPage), findsNothing);
    });

    testWidgets('should display TabsPage when authenticated',
        (WidgetTester tester) async {
      authService.login();
      
      await tester.pumpWidget(const MaterialApp(home: AuthCheckPage()));

      expect(find.byType(TabsPage), findsOneWidget);
      expect(find.byType(LoginPage), findsNothing);
    });
  });
}
