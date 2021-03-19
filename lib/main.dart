import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souqy/components/change_password.dart';
import 'package:souqy/components/edit_name.dart';
import 'package:souqy/screens/CartItems.dart';
import 'package:souqy/screens/all_users.dart';
import 'package:souqy/screens/client_login.dart';
import 'package:souqy/screens/client_signup.dart';
import 'package:souqy/screens/home_screen.dart';
import 'package:souqy/screens/my_account.dart';
import 'components/products.dart';
import 'models/CartFunctions.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CartFunctions(),
    child: MyApp(),
  ));
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Store',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: ClientLogin.routeName,
      routes: {
        HomePageScreen.routeName: (context) => HomePageScreen(),
        Products.routeName: (context) => Products(),
        CartItems.routeName: (context) => CartItems(),
        ClientLogin.routeName: (context) => ClientLogin(),
        ClientSignup.routeName: (context) => ClientSignup(),
        ChangePassword.routeName: (context) => ChangePassword(),
        EditName.routeName: (context) => EditName(),
        MyAccount.routeName:(context) => MyAccount(),
        AllUsers.routeName:(context) => AllUsers()
      },
    );
  }
}
