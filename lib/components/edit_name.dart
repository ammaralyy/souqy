import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/screens/CartItems.dart';
import 'package:souqy/screens/my_account.dart';
import '../user_db.dart';
import 'drawer.dart';

String myPass;

class EditName extends StatefulWidget {

  static const String routeName = '/EditName';

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  User user;

  UsersDB databaseHandeler = UsersDB();

  TextEditingController newNameController = TextEditingController();

  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    user = ModalRoute.of(context).settings.arguments;

    myPass = user.password;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        // backgroundColor: Colors.deepPurple,
        title: Text('Edit Name'),
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
                        controller: newNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Name',
                          hintText: 'Enter your New Name',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: passController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Your Password',
                          hintText: 'Enter your Password',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: () async{

                      String pass = passController.text;
                      String name = newNameController.text;

                      if(myPass == pass){
                        user.nikeName = name;

                        await databaseHandeler.updateUser(user);

                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString('nick', name);

                        print(user.nikeName);

                        Navigator.pushNamed(
                            context,
                            MyAccount.routeName
                        );

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
