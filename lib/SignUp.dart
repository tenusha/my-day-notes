import 'package:flutter/material.dart';
import 'package:my_day/Login.dart';
import 'package:my_day/User.dart';
import 'package:my_day/UserAPI.dart';

import 'HomePage.dart';
import 'ThemeData.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage() : super();

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool enableGoogleButton = true;
  bool enableSignUpButton = true;
  String collectionName = 'Users';

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  handleSignUp(BuildContext context) async {
    _disableButtons();

    print('signup clicked');
    try {
      if (username.text == null || username.text == "") {
        _showToast(context, "Username is empty");
      } else if (password.text == null || password.text == "") {
        _showToast(context, "Password is empty");
      } else if (cPassword.text == null || cPassword.text == "") {
        _showToast(context, "Confirm password is empty");
      } else if (password.text != cPassword.text) {
        _showToast(context, "Password and confirm password does't match");
      } else {
        var user = new User(username: username.text, password: password.text);
        bool status = await addUser(collectionName, user);
        if (status) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(username: username.text)),
          );
        } else {
          _showToast(
              context, "Username exists. Please choose a different username");
        }
      }
    } catch (e) {
      print(e.toString());
    }
    _enableButtons();
  }

  handleGoogleSignUp(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(username: 'Google User')),
    );
  }

  _disableButtons() {
    setState(() {
      enableSignUpButton = false;
      enableGoogleButton = false;
    });
  }

  _enableButtons() {
    setState(() {
      enableSignUpButton = true;
      enableGoogleButton = true;
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
            SizedBox(height: 75),
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
                        Text('SignUp with google',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                height: 1.2)),
                      ],
                    ),
                    onPressed: () {
                      handleGoogleSignUp(context);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ));
            }),
            SizedBox(height: 15),
            Text(
              'OR',
              style: TextStyle(color: Colors.white, height: 3, fontSize: 14),
            ),
            SizedBox(height: 15),
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
                  controller: cPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Confirm Password",
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
                        Text('SignUp',
                            style: TextStyle(height: 1.2, color: themeColor)),
                      ],
                    ),
                    onPressed: () {
                      enableSignUpButton
                          ? handleSignUp(context)
                          : print('disabled');
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ));
            }),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: new Text(
                'Already have an account? Log In',
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
