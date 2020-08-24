import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/core/widgets/loading_display.dart';

import '../../unit_test/core/helper/testable_widget.dart';

void main() {
  testWidgets('LoadingDisplay should have correct UI elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: LoadingDisplay()));

    CircularProgressIndicator indicator =
        tester.firstWidget(find.byType(CircularProgressIndicator));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(indicator.value, null);
  });
}
