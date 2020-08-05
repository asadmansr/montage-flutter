import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:montageapp/features/random_user/presentation/bloc/user_bloc.dart';
import 'package:montageapp/features/random_user/presentation/page/get_user_page.dart';
import 'package:montageapp/injection_container.dart' as di;

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

void main() {
  UserBloc userBloc;

  setUp(() {
    userBloc = MockUserBloc();
  });

  tearDown(() {
    userBloc.close();
  });

  Widget makeDiTestableWidget({Widget child}) {
    WidgetsFlutterBinding.ensureInitialized();
    di.init();
    return BlocProvider.value(
      value: userBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Initial GetUserPage should be in Empty state',
      (WidgetTester tester) async {
    GetUserPage getUserPage = GetUserPage();
    when(userBloc.state).thenReturn(Empty());
    await tester.pumpWidget(makeDiTestableWidget(child: getUserPage));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.refresh), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
