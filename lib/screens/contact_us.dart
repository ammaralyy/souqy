import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/components/drawer.dart';

import 'CartItems.dart';
import 'CheckOutPage.dart';

String myName;
String myEmail;

class About extends StatefulWidget {

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getName();
  }

  Future<void> getName() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name =  pref.getString('nick');
    String email =  pref.getString('email');


    setState(() {
      myName = name;
      myEmail = email;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.yellow,
        title: Text(
          'About Us',
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.credit_card),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckOut()));
              }),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartItems()));
              })
        ],
      ),
      drawer: DrawerComponent(),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Image(image: AssetImage('assets/images/a.jpg')),
            title: Text(myName,
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(myEmail,
                style: TextStyle(color: Colors.yellow)),
          ),
          ListTile(
            leading: Icon(Icons.phone_callback),
            title: Text('Phone Number',
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            subtitle: Text('+201093808655',
                style: TextStyle(color: Colors.yellow)),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Email',
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(myEmail,
                style: TextStyle(color: Colors.yellow)),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('GitHub',
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            subtitle:
                Text(myName, style: TextStyle(color: Colors.yellow)),
          ),
        ],
      ),
    );
  }
}
