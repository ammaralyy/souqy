import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souqy/screens/CartItems.dart';
import 'package:souqy/screens/CheckOutPage.dart';
import 'package:souqy/screens/client_login.dart';
import 'package:souqy/screens/contact_us.dart';
import 'package:souqy/screens/home_screen.dart';
import 'package:souqy/screens/my_account.dart';
import 'package:souqy/screens/setting_screen.dart';

String myName;
String myEmail;

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {

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

  SharedPreferences pref;
  double fS = 16;
  int fC = Colors.black.value;
  getSize() async {
    pref = await SharedPreferences.getInstance();
    if (pref.get('fsize') != null) {
      setState(() {
        fS = pref.get('fsize');
      });
    }
  }

  getColor() async {
    pref = await SharedPreferences.getInstance();
    if (pref.get('fcolor') != null) {
      setState(() {
        fC = pref.get('fcolor');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              myName,
              style: TextStyle(color: Color(fC), fontSize: fS),
            ),
            accountEmail: Text(myEmail,
                style: TextStyle(color: Color(fC), fontSize: fS)),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/a.jpg'),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageScreen()));
            },
            child: ListTile(
              title: Text('Home Page',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(
                Icons.home,
                color: Colors.yellow,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccount()));
            },
            child: ListTile(
              title: Text('My Account',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(Icons.person, color: Colors.yellow),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CheckOut()));
            },
            child: ListTile(
              title: Text('My Orders',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(Icons.shopping_basket, color: Colors.yellow),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartItems()));
            },
            child: ListTile(
              title: Text('Shopping Cart',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.yellow,
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
            child: ListTile(
              title: Text('Settings',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(
                Icons.settings,
                color: Colors.blueGrey[600],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
            child: ListTile(
              title: Text('About',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(Icons.help, color: Colors.blueGrey[600]),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ClientLogin()));
            },
            child: ListTile(
              title: Text('logout',
                  style: TextStyle(color: Color(fC), fontSize: fS)),
              leading: Icon(Icons.logout, color: Colors.blueGrey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
