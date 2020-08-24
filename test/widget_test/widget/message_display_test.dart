import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/core/widgets/message_display.dart';

import '../../unit_test/core/helper/testable_widget.dart';

void main() {
  const String tServerFailure = "Server Failure";
  const String tNetworkFailure = "Network Failure";
  const String tUnexpectedFailure = "Unexpected Failure";

  testWidgets(
      'MessageDisplay should have correct UI elements upon ServerFailure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MessageDisplay(message: tServerFailure)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(tServerFailure), findsOneWidget);

    Text text = tester.firstWidget(find.text(tServerFailure));
    expect(text.style.color, Colors.white);
    expect(text.style.fontSize, 25);
    expect(text.textAlign, TextAlign.center);
  });

  testWidgets(
      'MessageDisplay should have correct UI elements upon NetworkFailure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MessageDisplay(message: tNetworkFailure)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(tNetworkFailure), findsOneWidget);

    Text text = tester.firstWidget(find.text(tNetworkFailure));
    expect(text.style.color, Colors.white);
    expect(text.style.fontSize, 25);
    expect(text.textAlign, TextAlign.center);
  });

  testWidgets(
      'MessageDisplay should have correct UI elements upon UnexpectedFailure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MessageDisplay(message: tUnexpectedFailure)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(tUnexpectedFailure), findsOneWidget);

    Text text = tester.firstWidget(find.text(tUnexpectedFailure));
    expect(text.style.color, Colors.white);
    expect(text.style.fontSize, 25);
    expect(text.textAlign, TextAlign.center);
  });
}
