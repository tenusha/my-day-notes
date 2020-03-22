import 'package:flutter/material.dart';
import 'package:my_day/HomePage.dart';
import 'package:my_day/SignUp.dart';
import 'package:my_day/Welcome.dart';

import 'ThemeData.dart';

class LoginPage extends StatelessWidget {
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
            Container(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                )),
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
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
            Container(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                )),
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
