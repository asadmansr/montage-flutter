import 'package:flutter/material.dart';
import 'package:montageapp/features/user_list/presentation/page/get_user_list_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Montage',
      debugShowCheckedModeBanner: false,
      home: GetUserListPage(),
    );
  }
}
