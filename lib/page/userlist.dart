import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Userlist extends StatefulWidget {
  @override
  _UserlistState createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  Future<List<User>> _getUser() async {
    final url = 'http://188.166.248.81:5000/user';
    var data = await http.get(url);

    var jsonData = json.decode(data.body);
    print(jsonData);
    var jsonD = jsonData['users'];
    List<User> users = [];

    for (var u in jsonD) {
      User user = User(u["name"], u["email"], u["phone"]);

      users.add(user);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Userlist'),
        ),
        body: Container(
          child: FutureBuilder(
            future: _getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(snapshot.data[index])));
                      },
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

class DetailPage extends StatelessWidget {
  final User user;
  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                child: TextFormField(
              initialValue: user.name,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            )),
            Container(
                child: TextFormField(
              initialValue: user.email,
              decoration: InputDecoration(
                labelText: 'email',
                prefixIcon: Icon(Icons.email),
              ),
            )),
            Container(
                child: TextFormField(
              initialValue: user.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
            )),
            SizedBox(height: 20),
            RaisedButton(
              padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
              onPressed: () {},
              child: Text('Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String phone;

  User(this.name, this.email, this.phone);
}
