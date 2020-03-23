import 'package:flutter/material.dart';
import 'package:my_day/Login.dart';
import 'package:my_day/Note.dart';
import 'package:my_day/NoteAPI.dart';
import 'package:my_day/ThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  String username = "";
  String collectionName = 'Notes';

  bool enableSaveIcon = true;
  TextEditingController subject = new TextEditingController();
  TextEditingController note = new TextEditingController();

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

  handleSaveClick(BuildContext context) async {
    _disableButtons();
    print('handleSaveClick()');
    try {
      if (subject.text == null || subject.text == "") {
        _showToast(context, "The subject is empty");
      } else if (note.text == null || note.text == "") {
        _showToast(context, "The note is empty. Please add something");
      } else {
        Note noteObj = new Note(
            subject: subject.text,
            note: note.text,
            username: username,
            timestamp: new DateTime.now().millisecondsSinceEpoch);
        bool status = await addNote(collectionName, noteObj);
        if(status){
          Navigator.of(context).pop();
        }else{
          _showToast(context, "Unable to add the note. Please chech your connection");
        }
      }
    } catch (e) {
      print(e.toString());
    }
    _enableButtons();
  }

  _disableButtons() {
    setState(() {
      enableSaveIcon = false;
    });
  }

  _enableButtons() {
    setState(() {
      enableSaveIcon = true;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: themeColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
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
