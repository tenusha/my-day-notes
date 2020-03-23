import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_day/HomePage.dart';
import 'package:my_day/SignUp.dart';
import 'package:my_day/UserAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ThemeData.dart';
import 'User.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool enableLogInButton = true;
  String collectionName = 'Users';

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  handleLoginPress(BuildContext context) async {
    print('handleLoginPress()');
    _disableButtons();
    try {
      if (username.text == null || username.text == "") {
        _showToast(context, "Username is empty");
      } else if (password.text == null || password.text == "") {
        _showToast(context, "Password is empty");
      } else {
        DocumentSnapshot snapshot =
            await getUser(collectionName, username.text);
        if (snapshot == null) {
          _showToast(context, "User does not exists");
        } else if (password.text.hashCode == snapshot.data['password']) {
          // Store username on disk
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('username', username.text);

          // Navigate to Home Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          _showToast(context, "Incorrect password");
        }
      }
    } catch (e) {
      print(e.toString());
    }
    _enableButtons();
  }

  handleGoogleLogIn(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', 'Google User');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  _disableButtons() {
    setState(() {
      enableLogInButton = false;
    });
  }

  _enableButtons() {
    setState(() {
      enableLogInButton = true;
    });
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    double buttonHeight = 40;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: themeColor,
          ),
          child: Column(children: <Widget>[
            SizedBox(height: 100),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: AssetImage('graphics/icon.png'),
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                    child: Text(
                  'My Day',
                  style: TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                )),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(height: 70),
            SizedBox(height: 10),
            Builder(builder: (BuildContext context) {
              return new Container(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    splashColor: Colors.grey,
                    textStyle: TextStyle(color: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          image: AssetImage('graphics/google.webp'),
                          height: 20.0,
                          width: 20.0,
                        ),
                        SizedBox(width: 7),
                        Text('Login with google',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                height: 1.2)),
                      ],
                    ),
                    onPressed: () {
                      handleGoogleLogIn(context);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ));
            }),
            SizedBox(height: 10),
            Text(
              'OR',
              style: TextStyle(color: Colors.white, height: 3, fontSize: 14),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              padding: EdgeInsets.only(left: 10.0),
              width: buttonWidth,
              height: 42,
              child: Theme(
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Username",
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                data: Theme.of(context).copyWith(primaryColor: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              padding: EdgeInsets.only(left: 10.0),
              width: buttonWidth,
              height: 42,
              child: Theme(
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                data: Theme.of(context).copyWith(primaryColor: Colors.grey),
              ),
            ),
            SizedBox(height: 60),
            Builder(builder: (BuildContext context) {
              return new Container(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    splashColor: Colors.grey,
                    textStyle: TextStyle(color: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Login',
                            style: TextStyle(height: 1.2, color: themeColor)),
                      ],
                    ),
                    onPressed: () {
                      enableLogInButton
                          ? handleLoginPress(context)
                          : print("disabled");
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ));
            }),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: new Text(
                'Do not have an account? Sign Up',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                    height: 3),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
