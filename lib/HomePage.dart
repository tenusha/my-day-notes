import 'package:flutter/material.dart';
import 'package:my_day/AddNote.dart';
import 'package:my_day/ThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  String displayName = "";

  @override
  void initState() {
    _initiate();
    super.initState();
  }

  _initiate() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('username') ?? null;
    final displayUser = prefs.getString('displayName') ?? null;
    if (user != null) {
      setState(() {
        username = user;
        displayName = displayUser != null ? displayUser : user;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Day'),
        backgroundColor: themeColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotePage(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 240,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: themeColor,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    new CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('graphics/user.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 20),
                    Text(displayName, style: TextStyle(color: Colors.white)),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Image(
                height: 30,
                image: AssetImage('graphics/add_note.png'),
              ),
              title: Text('Add a note', style: TextStyle(color: themeColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image(
                height: 28,
                image: AssetImage('graphics/view_note.png'),
              ),
              title: Text('View existing notes',
                  style: TextStyle(color: themeColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image(
                height: 28,
                image: AssetImage('graphics/log_out.png'),
              ),
              title: Text('Log out', style: TextStyle(color: themeColor)),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('username');
                prefs.remove('displayName');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
