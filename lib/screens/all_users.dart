import 'package:flutter/material.dart';

import '../user_db.dart';

class AllUsers extends StatefulWidget {
  static const String routeName = '/ShowScreen';

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {

  Future<List<User>> data() async {
    List<User> users = [];

    users.add(User(1, 'ammar@mail.com', '123', 'ammar'));

    return users;
  }

  UsersDB dataBaseHandler;

  @override
  Widget build(BuildContext context) {
    dataBaseHandler = UsersDB();

    return Scaffold(
        appBar: AppBar(
          title: Text('Show Screen'),
        ),
        body: Container(
          child: FutureBuilder(
            future: dataBaseHandler.showUsers(),
            // future: data(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: snapShot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key('${snapShot.data[index].id}'),
                      onDismissed: (direction) async{
                        await dataBaseHandler.deleteUser(snapShot.data[index].id);
                      },
                      child: ListTile(
                        title: Text(snapShot.data[index].nikeName),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
    );
  }
}
