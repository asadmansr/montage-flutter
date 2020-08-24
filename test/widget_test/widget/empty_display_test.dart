import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/core/widgets/empty_display.dart';

import '../../unit_test/core/helper/testable_widget.dart';

void main() {
  testWidgets('EmptyDisplay should have correct UI elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: EmptyDisplay()));
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
