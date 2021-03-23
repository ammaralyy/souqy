import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/screens/all_users.dart';
import '../constant.dart';
import 'file:///D:/Working/flutter/souqy/lib/user_db.dart';
import 'client_signup.dart';
import 'home_screen.dart';


String myEmail;
String myPass;

class ClientLogin extends StatefulWidget {
  static const String routeName = '/ClientLogin';

  @override
  _ClientLoginState createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {


  Future<void> getUser() async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    String e = pref.getString('email');
    String p = pref.getString('pass');

    setState(() {
      myEmail = e;
      myPass = p;
    });

    print(myEmail + ' ' + myPass);

  }

  void validateUser(String email, String pass){

    getUser();

    if(myEmail == email && myPass == pass){
      Navigator.pushNamed(
        context,
        HomePageScreen.routeName,
      );
    }
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  UsersDB usersDB;

  @override
  Widget build(BuildContext context) {

    usersDB = UsersDB();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      controller: _email,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.yellow[800]))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _password,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.yellow[800]))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: textStyle2,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.yellow[700],
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async{
                            String email = _email.text;
                            String password = _password.text;

                            if(email == 'admin' && password == 'admin'){
                              Navigator.pushNamed(
                                context,
                                AllUsers.routeName,
                              );
                            }else{
                              validateUser(email, password);
                            }
                          },
                          child: Center(
                            child: Text('LOGIN', style: textStyle1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Souqy ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ClientSignup.routeName);
                  },
                  child: Text(
                    'Register',
                    style: textStyle2,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
