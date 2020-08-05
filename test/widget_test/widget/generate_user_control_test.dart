import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/features/random_user/presentation/widget/generate_user_control.dart';

import '../../unit_test/core/helper/testable_widget.dart';

void main() {
  testWidgets(
      'GenerateUserControl should have correct UI elements for interaction',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: GenerateUserControl()));

    expect(find.byType(RawMaterialButton), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    RawMaterialButton btn = tester.firstWidget(find.byType(RawMaterialButton));
    expect(find.byType(RawMaterialButton), findsOneWidget);
    expect(btn.enabled, true);
    expect(btn.fillColor, Colors.green);
  });
}
