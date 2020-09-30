import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_display.dart';

import '../../unit_test/core/helper/testable_widget.dart';

void main() {
  group('Male userA should have correct UI displayed', () {
    final tUserA = User(
        name: "john smith",
        email: "john@example.com",
        userName: "john123",
        password: "johnPassword",
        address: "123 example st, City State",
        gender: "male",
        imgUrl: "assets/man_1.png");

    testWidgets('UserA should have correct widgets displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: GenerateUserDisplay(
            user: tUserA,
            nameController: TextEditingController(text: tUserA.name),
            emailController: TextEditingController(text: tUserA.email),
            usernameController: TextEditingController(text: tUserA.userName),
            passwordController: TextEditingController(text: tUserA.password),
            addressController: TextEditingController(text: tUserA.address),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(5));
    });

    testWidgets('UserA should have correct values for textForm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: GenerateUserDisplay(
            user: tUserA,
            nameController: TextEditingController(text: tUserA.name),
            emailController: TextEditingController(text: tUserA.email),
            usernameController: TextEditingController(text: tUserA.userName),
            passwordController: TextEditingController(text: tUserA.password),
            addressController: TextEditingController(text: tUserA.address),
          ),
        ),
      );

      EditableText name = tester.firstWidget(find.text(tUserA.name));
      EditableText email = tester.firstWidget(find.text(tUserA.name));
      expect(name.readOnly, false);
      expect(email.readOnly, false);
    });
  });

  group('Female userB should have correct UI displayed', () {
    final tUserB = User(
        name: "Alice Smith",
        email: "alice@example.com",
        userName: "alice!@#",
        password: "aSJDIW@KSd293",
        address: "123 town rd, City State",
        gender: "male",
        imgUrl: "assets/man_1.png");

    testWidgets('UserB should have correct widgets displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: GenerateUserDisplay(
            user: tUserB,
            nameController: TextEditingController(text: tUserB.name),
            emailController: TextEditingController(text: tUserB.email),
            usernameController: TextEditingController(text: tUserB.userName),
            passwordController: TextEditingController(text: tUserB.password),
            addressController: TextEditingController(text: tUserB.address),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(5));
    });

    testWidgets('UserB should have correct values for textForm',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: GenerateUserDisplay(
            user: tUserB,
            nameController: TextEditingController(text: tUserB.name),
            emailController: TextEditingController(text: tUserB.email),
            usernameController: TextEditingController(text: tUserB.userName),
            passwordController: TextEditingController(text: tUserB.password),
            addressController: TextEditingController(text: tUserB.address),
          ),
        ),
      );

      EditableText name = tester.firstWidget(find.text(tUserB.name));
      EditableText email = tester.firstWidget(find.text(tUserB.name));
      expect(name.readOnly, false);
      expect(email.readOnly, false);
    });
  });
}
