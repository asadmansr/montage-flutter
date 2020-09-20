import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/core/widgets/message_display.dart';

import '../../unit_test/core/helper/testable_widget.dart';

void main() {
  const String tServerFailure =
      "Something went wrong. There seems to be a server failure. Please try again later.";
  const String tNetworkFailure =
      "Something went wrong. There seems to be a network failure. Please try again later.";
  const String tUnexpectedFailure =
      "Something went wrong. There seems to be an unexpected failure. Please try again later.";

  testWidgets(
      'MessageDisplay should have correct UI elements upon ServerFailure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MessageDisplay(message: tServerFailure)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text(tServerFailure), findsOneWidget);

    Text text = tester.firstWidget(find.text(tServerFailure));
    expect(text.style.color, Colors.white);
    expect(text.style.fontSize, 18);
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
    expect(text.style.fontSize, 18);
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
    expect(text.style.fontSize, 18);
    expect(text.textAlign, TextAlign.center);
  });
}
