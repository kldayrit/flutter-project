import 'dart:developer';
import 'dart:ffi';

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
      expect(find.text('Please Enter Password'), findsOneWidget);
    });

    testWidgets('Check Pagination', (tester) async {
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

      final listFinder = find.byType(Scrollable);
      final itemFinder = find.widgetWithText(TextButton, 'walapanamanata');

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      // may makita dapat na post ko na nasa sobrang layong page
      expect(itemFinder, findsOneWidget);
    });

    testWidgets('Check Failed Registration', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder register = find.widgetWithText(TextButton, 'REGISTER');

      //tap register
      await tester.tap(register);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // should find the register page
      expect(find.text('Register Page'), findsOneWidget);

      final Finder fname =
          find.widgetWithText(TextFormField, 'Enter First Name');
      final Finder lname =
          find.widgetWithText(TextFormField, 'Enter Last Name');
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'REGISTER');

      await tester.enterText(fname, 'firstname');
      await addDelay(3000);
      await tester.enterText(lname, 'lastname');
      await tester.enterText(username, 'walapanamanata');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      //should find at succesful registration
      expect(find.text('Failed to Register User'), findsOneWidget);
    });

    testWidgets('Test Post Creation', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'LOGIN');

      expect(find.text('Login Succesful'), findsNothing);

      //input credentials
      await tester.enterText(username, 'awit');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // must succeed
      expect(find.text('Login Succesful'), findsOneWidget);

      final Finder create =
          find.widgetWithIcon(FloatingActionButton, Icons.post_add_outlined);

      await tester.tap(create);
      await addDelay(3000);
      await tester.pumpAndSettle();

      // should find create post page
      expect(find.text('Create Post'), findsOneWidget);

      final Finder post =
          find.widgetWithText(TextField, 'Type your post here...');
      final Finder send = find.widgetWithText(ElevatedButton, 'POST');

      await tester.enterText(post, 'please sana mahanap mo to');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(find.text('please sana mahanap mo to'), findsOneWidget);
    });

    testWidgets('Test Edit Post', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'LOGIN');

      expect(find.text('Login Succesful'), findsNothing);

      //input credentials
      await tester.enterText(username, 'awit');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // must succeed
      expect(find.text('Login Succesful'), findsOneWidget);

      final Finder self =
          find.widgetWithIcon(IconButton, Icons.chrome_reader_mode);

      await tester.tap(self);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(find.text('please sana mahanap mo to'), findsOneWidget);

      final Finder edit = find.widgetWithIcon(IconButton, Icons.edit);

      await tester.tap(edit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(find.text('Edit Post'), findsOneWidget);

      final Finder post =
          find.widgetWithText(TextField, 'Type your post here...');
      final Finder send = find.widgetWithText(ElevatedButton, 'EDIT POST');

      await tester.enterText(post, 'please lang');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(find.text('please lang'), findsOneWidget);
    });
    testWidgets('Test Delete Post', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'LOGIN');

      expect(find.text('Login Succesful'), findsNothing);

      //input credentials
      await tester.enterText(username, 'awit');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // must succeed
      expect(find.text('Login Succesful'), findsOneWidget);

      final Finder self =
          find.widgetWithIcon(IconButton, Icons.chrome_reader_mode);

      await tester.tap(self);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      final Finder delete = find.widgetWithIcon(IconButton, Icons.delete);

      await tester.tap(delete);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);
    });
    testWidgets('Check View Profile', (tester) async {
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

      final Finder me = find.widgetWithIcon(IconButton, Icons.list_alt);

      await tester.tap(me);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Test Logout', (tester) async {
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

      final Finder me = find.widgetWithIcon(IconButton, Icons.list_alt);

      await tester.tap(me);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
      final Finder out = find.widgetWithText(TextButton, 'LOGOUT');

      await tester.tap(out);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);
    });

    testWidgets('Overall- test features at once', (tester) async {
      await tester.pumpWidget(app.MyApp());
      final Finder register = find.widgetWithText(TextButton, 'REGISTER');

      //tap register
      await tester.tap(register);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // should find the register page
      expect(find.text('Register Page'), findsOneWidget);

      final Finder fname =
          find.widgetWithText(TextFormField, 'Enter First Name');
      final Finder lname =
          find.widgetWithText(TextFormField, 'Enter Last Name');
      final Finder username =
          find.widgetWithText(TextFormField, 'Enter Username');
      final Finder password =
          find.widgetWithText(TextFormField, 'Enter Password');
      final Finder submit = find.widgetWithText(ElevatedButton, 'REGISTER');

      await tester.enterText(fname, 'firstname');
      await addDelay(3000);
      await tester.enterText(lname, 'lastname');
      await tester.enterText(username, 'FImObP9wal');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(submit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      //should find at succesful registration
      expect(find.text('Successfuly Registered New User'), findsOneWidget);

      final Finder login = find.widgetWithText(ElevatedButton, 'LOGIN');
      await tester.enterText(username, 'FImObP9wal');
      await addDelay(3000);
      await tester.enterText(password, '123');
      await addDelay(3000);
      await tester.tap(login);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      // should find at successful login using newly created user
      expect(find.text('Login Succesful'), findsOneWidget);

      final Finder create =
          find.widgetWithIcon(FloatingActionButton, Icons.post_add_outlined);

      await tester.tap(create);
      await addDelay(3000);
      await tester.pumpAndSettle();

      // should find create post page
      expect(find.text('Create Post'), findsOneWidget);

      final Finder post =
          find.widgetWithText(TextField, 'Type your post here...');
      final Finder send = find.widgetWithText(ElevatedButton, 'POST');

      await tester.enterText(post, 'please sana mahanap mo to at gumana ka');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(send);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(
          find.text('please sana mahanap mo to at gumana ka'), findsOneWidget);

      final listFinder = find.byType(Scrollable);
      final itemFinder = find.widgetWithText(TextButton, 'walapanamanata');

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      // may makita dapat na post ko na nasa sobrang layong page
      expect(itemFinder, findsOneWidget);

      final Finder edit = find.widgetWithIcon(IconButton, Icons.edit);

      await tester.tap(edit);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(find.text('Edit Post'), findsOneWidget);

      final Finder box =
          find.widgetWithText(TextField, 'Type your post here...');
      final Finder go = find.widgetWithText(ElevatedButton, 'EDIT POST');

      await tester.enterText(box, 'please lang');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(go);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);

      expect(find.text('please lang'), findsOneWidget);

      final Finder delete = find.widgetWithIcon(IconButton, Icons.delete);

      await tester.tap(delete);
      await addDelay(3000);
      await tester.pumpAndSettle();
      await addDelay(3000);
    });
  });
}
