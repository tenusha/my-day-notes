import 'package:flutter/material.dart';
import 'package:my_day/HomePage.dart';
import 'package:my_day/Login.dart';
import 'package:my_day/model/Note.dart';
import 'package:my_day/api/NoteAPI.dart';
import 'package:my_day/config/ThemeData.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNotePage extends StatefulWidget {
  EditNotePage({Key key, this.note}) : super(key: key);

  final Note note;

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  String username = "";
  String collectionName = 'Notes';
  Note noteState;
  bool enableSaveIcon = true;
  bool enableDeleteIcon = true;
  TextEditingController subject;
  TextEditingController note;

  @override
  void initState() {
    setState(() {
      noteState = widget.note;
      subject = new TextEditingController(text: widget.note.subject);
      note = new TextEditingController(text: widget.note.note);
    });
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

  handleSaveClick(BuildContext context) {
    _disableButtons();
    print('handleSaveClick()');
    try {
      if (subject.text == null || subject.text == "") {
        _showToast(context, "The subject is empty");
      } else if (note.text == null || note.text == "") {
        _showToast(context, "The note is empty. Please add something");
      } else {
        var noteObj = {
          'subject': subject.text,
          'note': note.text,
          'username': username,
          'timestamp': new DateTime.now().millisecondsSinceEpoch
        };
        updateNote(noteState, noteObj);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
      _showToast(
          context, "Unable to update the note. Please chech your connection");
      Navigator.of(context).pop();
    }
    _enableButtons();
  }

  _disableButtons() {
    setState(() {
      enableSaveIcon = false;
      enableDeleteIcon = false;
    });
  }

  _enableButtons() {
    setState(() {
      enableSaveIcon = true;
      enableDeleteIcon = true;
    });
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
                _closePage(this.context);
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

  _closePage(BuildContext context) {
    Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: themeColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Builder(builder: (BuildContext context) {
            return new IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(
                    "Subject: " + subject.text + "\n\nNote: " + note.text);
              },
            );
          }),
          Builder(builder: (BuildContext context) {
            return new IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                enableDeleteIcon
                    ? _showDeleteDialog(noteState)
                    : print('disabled');
              },
            );
          }),
          Builder(builder: (BuildContext context) {
            return new IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                enableSaveIcon ? handleSaveClick(context) : print('disabled');
              },
            );
          }),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextField(
                    controller: subject,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(
                        hintText: "Subject",
                        hintStyle: new TextStyle(fontSize: 16.0)),
                    style: new TextStyle(fontSize: 20.0, color: Colors.black))),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: Colors.grey, thickness: 0.4),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: note,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 20,
                  decoration:
                      InputDecoration.collapsed(hintText: "Add your note here"),
                )),
          ],
        ),
      ),
    );
  }
}
