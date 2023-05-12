import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/auth_provider.dart';
import 'package:flutter_application_template/src/routes/routes.dart';
import 'package:flutter_application_template/src/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_template/src/utils/style.dart' as MyTheme;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: Login(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.theme,
      initialRoute: 'finduser',
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
