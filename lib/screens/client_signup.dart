import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/screens/home_screen.dart';

import '../constant.dart';
import '../user_db.dart';

class ClientSignup extends StatefulWidget {

  static const String routeName = '/ClientSignup';

  @override
  _ClientSignupState createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nikeNameController = TextEditingController();

  UsersDB usersDB;

  @override
  Widget build(BuildContext context) {
    usersDB = UsersDB();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Souqy',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(230.0, 125.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[700]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow[800]))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow[700]))),
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: nikeNameController,
                        decoration: InputDecoration(
                            labelText: 'NICK NAME ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow[700]))),
                      ),
                      SizedBox(height: 50.0),
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.yellow[800],
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async{
                                String email = emailController.text;
                                String password = passwordController.text;
                                String nikeName = nikeNameController.text;

                                User user = User(
                                    null, email, password, nikeName);

                                await usersDB.save(user);

                                print('${user.email} ${user.nikeName}');


                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString('email', email);
                                pref.setString('pass', password);
                                pref.setString('nick' , nikeName);

                                Navigator.pushNamed(
                                  context,
                                  HomePageScreen.routeName,
                                );

                              },
                              child: Center(
                                child: Text(
                                  'SIGNUP',
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text('Go Back',
                                  style: textStyle3
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ]));
  }


  // Future<void> setUser(String email, String pass, String nick) async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('email', email);
  //   pref.setString('pass', pass);
  //   pref.setString('nick' , nick);
  //
  // }

}