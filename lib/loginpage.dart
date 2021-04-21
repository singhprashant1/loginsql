import 'package:flutter/material.dart';
import 'package:loginsql/ProfilePage.dart';
import 'package:loginsql/preferences.dart';
import 'package:loginsql/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'databasehelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final dbhelper = Databasehelper.instance;
  Preferences preferences = Preferences();

  void quaryall() async {
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      print(row);
      // print(row["username"]);
      if (row["username"] == usernameController.text &&
          row["password"] == passController.text) {
        preferences.setPreferences('username', usernameController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
      // print(row[])
      // print(row["age"]);
    });
    // print(name);
  }

  void initialize() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => Preferences.prefs = prefs);
    });
  }

  @override
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      quaryall();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
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
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    _validateInputs();
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
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
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
