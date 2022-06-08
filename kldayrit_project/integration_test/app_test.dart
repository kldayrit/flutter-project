import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kldayrit_project/user_model.dart';

import '../lib/main.dart' as app;

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Check failed login', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'LOGIN');

      expect(find.text('Login Succesful'), findsNothing);
      //input credentials
      await tester.enterText(username, 'walapanaman');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // must succeed
      expect(find.text('Failed to Login using credentials'), findsOneWidget);
    });
    testWidgets('Check Successful Login', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'LOGIN');

      expect(find.text('Login Succesful'), findsNothing);

      //input credentials
      await tester.enterText(username, 'walapanamanata');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // must succeed
      expect(find.text('Login Succesful'), findsOneWidget);
    });
    testWidgets('No Login Input', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'LOGIN');

      expect(find.text('Login Succesful'), findsNothing);

      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // must succeed
      expect(find.text('Please Enter Username'), findsOneWidget);
      expect(find.text('Please Enter Username'), findsOneWidget);
    });
  });
}
