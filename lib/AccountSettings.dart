import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_day/Login.dart';
import 'package:my_day/api/UserAPI.dart';
import 'package:my_day/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_day/functions/Functions.dart';

import 'config/ThemeData.dart';

class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  String username = "";
  String displayName = "";
  int password = 0;
  String collectionName = "Users";
  User userObj;

  bool enableUpdateButton = true;

  TextEditingController displayNameController;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController cNewPasswordController = TextEditingController();

  @override
  void initState() {
    _initiate();
    super.initState();
  }

  _initiate() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('username') ?? null;
    final displayUser = prefs.getString('displayName') ?? null;
    final pass = prefs.getInt('password') ?? 0;
    if (user != null) {
      DocumentSnapshot snapshot = await getUser(collectionName, user);
      setState(() {
        username = user;
        displayName = displayUser;
        password = pass;
        userObj = User.fromSnapshot(snapshot);
      });
      displayNameController = TextEditingController(text: displayUser);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  handleUpdate(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    _disableButtons();

    try {
      if (displayNameController.text == null ||
          displayNameController.text == "") {
        showToast(context, "Name is empty");
      } else {
        updateUser(userObj, {'displayName': displayNameController.text});
        prefs.setString('displayName', displayNameController.text);
        showToast(context, "Name updated");
      }

      if ((newPasswordController.text != "" &&
              newPasswordController.text != "" &&
              oldPasswordController.text != "") &&
          newPasswordController.text == cNewPasswordController.text) {
        print(password.toString());
        if (password == oldPasswordController.text.hashCode) {
          updateUser(
              userObj, {'password': newPasswordController.text.hashCode});
          prefs.setInt('password', newPasswordController.text.hashCode);
          showToast(context, "Password updated");
        } else {
          showToast(context, "Old password doesn't match");
        }
      } else {
        showToast(context,
            "Password didn't updated. password update fields are invalid");
      }
    } catch (e) {
      print(e.toString());
    }
    _enableButtons();
  }

  _disableButtons() {
    setState(() {
      enableUpdateButton = false;
    });
  }

  _enableButtons() {
    setState(() {
      enableUpdateButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    double buttonHeight = 40;

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: themeColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    new CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('graphics/user_inverse.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 20),
                    Text(
                      username,
                      style: TextStyle(color: themeColor),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10.0),
                  width: buttonWidth,
                  height: 42,
                  child: Theme(
                    child: TextField(
                      controller: displayNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.perm_identity),
                        hintText: "Name",
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
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10.0),
                  width: buttonWidth,
                  height: 42,
                  child: Theme(
                    child: TextField(
                      controller: oldPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "Old password",
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
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10.0),
                  width: buttonWidth,
                  height: 42,
                  child: Theme(
                    child: TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        hintText: "New password",
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
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10.0),
                  width: buttonWidth,
                  height: 42,
                  child: Theme(
                    child: TextField(
                      controller: cNewPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Confirm new password",
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    data: Theme.of(context).copyWith(primaryColor: Colors.grey),
                  ),
                ),
                SizedBox(height: 50),
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
                            Text('Update',
                                style:
                                    TextStyle(height: 1.2, color: themeColor)),
                          ],
                        ),
                        onPressed: () {
                          enableUpdateButton
                              ? handleUpdate(context)
                              : print('disabled');
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ));
                }),
                SizedBox(height: 10),
              ]),
        ),
      ),
    );
  }
}
