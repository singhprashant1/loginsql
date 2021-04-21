import 'package:flutter/material.dart';
import 'package:loginsql/loginpage.dart';

import 'databasehelper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final dbhelper = Databasehelper.instance;
  void insertdata() async {
    Map<String, dynamic> row = {
      Databasehelper.columnUserName: usernameController.text,
      Databasehelper.columnpassword: passController.text,
      Databasehelper.columnemail: " ",
      Databasehelper.columnName: " ",
      Databasehelper.columnnumber: " ",
    };
    final id = await dbhelper.insert(row);
    print(id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      insertdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  controller: usernameController,
                  validator: (input) {
                    if (input.isEmpty) return 'Please enter proper Username';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'password',
                    prefixIcon: Icon(Icons.security),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  controller: passController,
                  validator: (input) {
                    if (input.isEmpty) return 'Please enter proper password';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 52,
                  // minWidth: 323,
                  color: Colors.blue[900],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    _validateInputs();
                    // var number_entered =
                    //     "+91" + numberController.text.trim();
                    // readData(number_entered);
                  },
                  splashColor: Colors.redAccent,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 52,
                  // minWidth: 323,
                  color: Colors.blue[900],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    // _validateInputs();
                  },
                  splashColor: Colors.redAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
