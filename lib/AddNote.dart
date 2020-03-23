import 'package:flutter/material.dart';
import 'package:my_day/Login.dart';
import 'package:my_day/ThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  String username = "";

  @override
  void initState() {
    _initiate();
    super.initState();
  }

  _initiate() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('username') ?? null;
    if (user != null) {
      setState(() {
        username = user;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  handleSaveClick() {
    print('handleSaveClick()');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new note",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: false,
        backgroundColor: themeColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              handleSaveClick();
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Add Note'),
            Text(username),
          ],
        ),
      ),
    );
  }
}
