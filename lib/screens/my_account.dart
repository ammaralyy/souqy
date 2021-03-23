import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/components/change_language.dart';
import 'package:souqy/components/change_location.dart';
import 'package:souqy/components/change_password.dart';
import 'package:souqy/components/drawer.dart';
import 'package:souqy/components/edit_name.dart';

import '../user_db.dart';
import 'CartItems.dart';
import 'CheckOutPage.dart';

String myEmail;
int myId;
String myNick;
String myPass;

class MyAccount extends StatefulWidget {

  static const String routeName = '/account';


  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getName();
  }

  Future<void> getName() async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    String nick =  pref.getString('nick');
    String email =  pref.getString('email');
    String pass =  pref.getString('pass');
    int id = pref.getInt('id');

    setState(() {
      myEmail = email;
      myId = id;
      myNick = nick;
      myPass = pass;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        // backgroundColor: Colors.deepPurple,
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.credit_card, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckOut()));
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CartItems.routeName,
                );
              })
        ],
      ),
      drawer: DrawerComponent(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.yellow,
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          EditName.routeName,
                          arguments:user = new User(myId, myEmail, myPass, myNick)
                      );
                    },
                    title: Text(myName),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    trailing: Icon(Icons.edit),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Colors.yellow,
                        ),
                        title: Text('Change Passwod'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ChangePassword.routeName,
                            arguments:user = new User(myId, myEmail, myPass, myNick)
                          );
                        },
                      ),
                      Divider(
                        height: 2.0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Colors.yellow,
                        ),
                        title: Text('Change Language'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeLanguage()));
                        },
                      ),
                      Divider(
                        height: 2.0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.location_city,
                          color: Colors.yellow,
                        ),
                        title: Text('Change Location'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeLocation()));
                        },
                      ),
                      Divider(
                        height: 2.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
