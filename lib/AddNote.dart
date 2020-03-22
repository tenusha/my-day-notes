import 'package:flutter/material.dart';
import 'package:my_day/ThemeData.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({Key key, this.username}) : super(key: key);

  final String username;

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  handleSaveClick(){
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
            icon:Icon(Icons.save),
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
            Text(widget.username),
          ],
        ),
      ),
    );
  }
}
