import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String final_response = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _phone;

  //function to validate and save user form
  Future<void> _savingData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_name);
    }
  }

  //function to add border and rounded edges to our form
  OutlineInputBorder _inputformdeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide:
          BorderSide(width: 1.0, color: Colors.blue, style: BorderStyle.solid),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('UserForm'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Name';
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                              onSaved: (input) => _name = input),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6) return 'EnterPhone';
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              onSaved: (input) => _phone = input),
                        ),
                        FlatButton(
                          onPressed: () async {
                            //validating the form and saving it
                            _savingData();

                            //url to send the post request to
                            final url = 'http://188.166.248.81:5000/user';

                            //sending a post request to the url
                            final response = await http.post(url,
                                body: json.encode({
                                  'name': _name,
                                  'email': _email,
                                  'phone': _phone
                                }));
                          },
                          child: Text('ADD'),
                          color: Colors.blue,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Userlist()));
                          },
                          child: Text('UserList'),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
