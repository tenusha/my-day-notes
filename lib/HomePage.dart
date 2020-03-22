import 'package:flutter/material.dart';
import 'package:my_day/AddNote.dart';
import 'package:my_day/ThemeData.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.username}) : super(key: key);

  final String username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Day'),
        backgroundColor: themeColor,
        actions: [
          IconButton(
            icon:Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotePage(username: widget.username),
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
                    Text(widget.username,
                        style: TextStyle(color: Colors.white)),
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
                    builder: (context) => AddNotePage(username: widget.username),
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
                    builder: (context) => HomePage(username: widget.username,),
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
              onTap: () {
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
