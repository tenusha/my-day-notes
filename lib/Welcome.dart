import 'package:flutter/material.dart';
import 'package:my_day/HomePage.dart';
import 'package:my_day/ThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'SignUp.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    _initiate();
    super.initState();
  }

  _initiate() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('username') ?? null;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    double buttonHeight = 40;

    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: themeColor,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text(
                  'My Day',
                  style: TextStyle(
                      color: Colors.white,
                      height: 5,
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                )),
                SizedBox(height: 50),
                Text(
                  '_____________________',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 10),
                ),
                Text(
                  'Save your thoughts as notes from anywhere',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      height: 3,
                      fontSize: 14),
                ),
                SizedBox(height: 100),
                Container(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: OutlineButton(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.white),
                      disabledBorderColor: Colors.white,
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.2),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    )),
                SizedBox(height: 5),
                Text(
                  '------------------------ OR SKIP ------------------------',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                      height: 4),
                ),
                SizedBox(height: 20),
                Container(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: OutlineButton(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.white),
                      disabledBorderColor: Colors.white,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.2),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    )),
                SizedBox(height: 70),
              ]),
        ),
      ),
    );
  }
}
