import 'package:flutter/material.dart';
import 'package:loginsql/preferences.dart';

import 'databasehelper.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final dbhelper = Databasehelper.instance;
  Preferences preferences = Preferences();

  var username;
  var number;
  var email;
  var name;
  void queryspecific() async {
    var allrows = await dbhelper.queryspacific(username);
    allrows.forEach((row) {
      username = row["username"];
      number = row["number"];
      email = row["email"];
      name = row["name"];
    });
    // number = allrows["number"];
  }

  void update(usernameController, nameController, numberController,
      emailController) async {
    var row = await dbhelper.update(
        usernameController, nameController, numberController, emailController);
    print(row);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = preferences.getPreferences("username");
    // queryspecific();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  username != null ? username : "username",
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
                    hintText: name != null ? name : "Name",
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
                  controller: nameController,
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
                    hintText: email != null ? email : "email",
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
                  controller: emailController,
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
                    hintText: number != null ? number : "Number",
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
                  controller: numberController,
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
                    "update",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    update(usernameController, nameController, numberController,
                        emailController);
                    // var number_entered =
                    //     "+91" + numberController.text.trim();
                    // readData(number_entered);
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
