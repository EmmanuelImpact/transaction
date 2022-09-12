import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screen/the_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ],
  );
  runApp(
    const PersonalTransactions(),
  );
}

class PersonalTransactions extends StatelessWidget {
  const PersonalTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          // ignore: deprecated_member_use
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'Roboto',
                ),
              ),
        ),
      ),
      title: 'Personal  Transactions',
      home: const TheHomeScreen(),
    );
  }
}
