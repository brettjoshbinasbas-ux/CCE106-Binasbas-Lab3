import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tawag_lab3/main.dart';

void main() {
  testWidgets('Full Auth flow smoke test', (WidgetTester tester) async {
    // 1. Build our app and trigger a frame
    await tester.pumpWidget(const LoginRegisterApp());

    // Verify initial login screen
    expect(find.text('QuickAuth Portal'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.textContaining('Brett Josh Binasbas'), findsOneWidget);
    expect(find.text('No account yet? Register'), findsOneWidget);

    // 2. Switch to Register screen
    await tester.tap(find.text('No account yet? Register'));
    await tester.pumpAndSettle();

    expect(find.text('Create an Account'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Full Name'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Confirm Password'), findsOneWidget);

    // 3. Test validation - password less than 8 characters
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full Name'),
      'Juan Dela Cruz',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'juan@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'short', // < 8 characters
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      'short',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pumpAndSettle();

    expect(find.text('Use at least 8 characters.'), findsOneWidget);

    // 4. Test valid registration
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'flutter123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm Password'),
      'flutter123',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pumpAndSettle();

    // Verify snackbar and return to login
    expect(find.text('Registration successful! Please log in.'), findsOneWidget);
    expect(find.text('Welcome Back!'), findsOneWidget);

    // 5. Test login with registered credentials
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'juan@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'flutter123',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // Verify welcome screen
    expect(find.text('Welcome, Juan Dela Cruz!'), findsOneWidget);
    expect(find.text('juan@example.com'), findsOneWidget);

    // 6. Test logout
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
