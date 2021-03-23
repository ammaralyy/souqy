import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/screens/CartItems.dart';
import 'package:souqy/screens/my_account.dart';
import '../user_db.dart';
import 'drawer.dart';

String myPass;
String myEmail;

class ChangePassword extends StatefulWidget {

  static const String routeName = '/pass';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  User user;

  UsersDB databaseHandeler = UsersDB();

  TextEditingController currentController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController reNewController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    user = ModalRoute.of(context).settings.arguments;

    myPass = user.password;

    print(myPass);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        // backgroundColor: Colors.deepPurple,
        title: Text('Change Password'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
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
                  //margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: currentController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Old Password',
                          hintText: 'Enter your Old Password',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: newController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                          hintText: 'Enter your New Password',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: reNewController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                          hintText: 'Enter your New Password Again',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('Change Password'),
                    onPressed: () async{

                      String old = currentController.text;
                      String newP = newController.text;
                      String reNewP = reNewController.text;

                      if(myPass == old){
                        if(newP == reNewP){
                          user.password = newP;

                          await databaseHandeler.updateUser(user);

                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setString('pass', newP);

                          print(user.password);

                          Navigator.pushNamed(
                              context,
                            MyAccount.routeName
                          );

                        }
                      }

                    },
                    color: Colors.yellow,
                    textColor: Colors.white,
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
