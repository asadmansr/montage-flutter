import 'package:flutter/material.dart';

import 'features/random_user/presentation/page/get_user_page.dart';
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
      home: GetUserPage(),
    );
  }
}
