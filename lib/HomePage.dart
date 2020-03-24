import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_day/AccountSettings.dart';
import 'package:my_day/AddNote.dart';
import 'package:my_day/EditNote.dart';
import 'package:my_day/config/ThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'api/NoteAPI.dart';
import 'model/Note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  String displayName = "";
  String collectionName = "Notes";
  String imageUrl;

  @override
  void initState() {
    _initiate();
    super.initState();
  }

  _initiate() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('username') ?? null;
    final displayUser = prefs.getString('displayName') ?? null;
    final img = prefs.getString('imageUrl') ?? null;
    if (user != null) {
      setState(() {
        username = user;
        displayName = displayUser != null ? displayUser : user;
        imageUrl = img;
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

  void _showDeleteDialog(Note noteObj) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Note"),
          content: new Text(
              "Are you sure you want to delete the selected note. This action cannot be undone"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                deleteNote(noteObj);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var body = _buildBody(context);

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
                      backgroundImage: imageUrl == null
                          ? AssetImage('graphics/user.png')
                          : NetworkImage(imageUrl),
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
                image: AssetImage('graphics/settings.png'),
              ),
              title:
                  Text('Account settings', style: TextStyle(color: themeColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountSettingsPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
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
                prefs.remove('password');
                prefs.remove('imageUrl');
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: body == null
                      ? Text(
                          "You don't have any notes yet",
                          style: TextStyle(color: Colors.grey),
                        )
                      : body)
            ],
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getNotes(collectionName, username),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    print('test _buildListItem');
    final noteObj = Note.fromSnapshot(data);

    String note = noteObj.note.replaceAll('\n', ' ');
    if (note.length > 100) {
      note = note.substring(0, 100) + '...';
    }

    String subject = noteObj.subject;
    var formatter = new DateFormat('dd MMM yyyy hh:mm:ss a');
    String date = formatter.format(
        new DateTime.fromMicrosecondsSinceEpoch(noteObj.timestamp * 1000));

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNotePage(
                note: noteObj,
              ),
            ),
          ),
          child: Container(
            color: Colors.white,
            child: ListTile(
              title: Text('$subject', style: TextStyle(height: 1.5)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text('$note'),
                  SizedBox(height: 10),
                  Text(
                    '$date',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            iconWidget: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            color: themeColor,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNotePage(
                  note: noteObj,
                ),
              ),
            ),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _showDeleteDialog(noteObj),
          ),
        ],
      ),
    );

//    return Column(
//      children: <Widget>[
//        Text('$note'),
//        Text('$subject'),
//        Text('$date'),
//      ],
//    );
  }
}
