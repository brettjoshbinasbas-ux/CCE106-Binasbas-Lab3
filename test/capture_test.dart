import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tawag_lab3/main.dart';

void main() {
  testWidgets('Generate all 4 screenshots', (WidgetTester tester) async {
    final screenshotDir = Directory('screenshots');
    if (!screenshotDir.existsSync()) {
      screenshotDir.createSync(recursive: true);
    }

    tester.view.physicalSize = const Size(1080, 2160);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final repaintKey = GlobalKey();

    Future<void> snap(String fileName) async {
      await tester.pump(const Duration(milliseconds: 300));
      final boundary = repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        final image = await boundary.toImage(pixelRatio: 2.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          File('screenshots/$fileName').writeAsBytesSync(byteData.buffer.asUint8List());
        }
      }
    }

    // 1. Login Form
    await tester.pumpWidget(
      RepaintBoundary(
        key: repaintKey,
        child: const LoginRegisterApp(),
      ),
    );
    await snap('login_form.png');

    // 2. Switch to Register Form
    await tester.tap(find.text('No account yet? Register'));
    await tester.pump(const Duration(milliseconds: 300));
    await snap('registration_form.png');

    // 3. Validation error (password too short, invalid email)
    await tester.enterText(find.widgetWithText(TextFormField, 'Full Name'), 'Juan Dela Cruz');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'juan');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '1234');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), '5678');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pump(const Duration(milliseconds: 300));
    await snap('validation_error.png');

    // 4. Fill valid credentials and register
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'juan@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'flutter123');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'flutter123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pump(const Duration(milliseconds: 500));

    // 5. Login
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'juan@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'flutter123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump(const Duration(milliseconds: 500));

    // 6. Welcome screen
    await snap('welcome_screen.png');
  });
}
