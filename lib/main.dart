import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apps',
      home: AddReviewPage(),
    );
  }
}

class AddReviewPage extends StatefulWidget {
  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final databaseReference = Firestore.instance;
  int _highlightedStars = 0;
  String _comment = "";

  _updateComment(text) {
    setState(() {
      _comment = text;
    });
  }

  _updateHighlightedStars(index) {
    setState(() {
      _highlightedStars = index + 1;
    });
  }

  _reviewSubmit(context) async {
    if (_highlightedStars == 0) {
      print('score is empty');
    } else if (_comment == '') {
      print('comment is empty');
    } else {
      print(_comment);
      print(_highlightedStars);
      await databaseReference.collection("reviews").document().setData({
        'rating': _highlightedStars,
        'comment': _comment,
        'id': new DateTime.now().millisecondsSinceEpoch
      });

      _showDialog();
    }
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reviewe added'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Reviewe added successfly !!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewsPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width;
    double buttonHeight = 40;

    return Scaffold(
        appBar: AppBar(title: Text('Add Review')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Mobile App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.plus_one),
                title: Text('Add a review'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReviewPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Reviews'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: OutlineButton(
                    borderSide: BorderSide(
                        style: BorderStyle.none, color: Colors.black),
                    disabledBorderColor: Colors.black,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Reviews >>>',
                            style: TextStyle(
                                color: Colors.blue, fontSize: 14, height: 1.2),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewsPage()),
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  )),
              SizedBox(height: 3),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(color: Colors.grey, thickness: 0.4),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Add a review',
                  style:
                  TextStyle(color: Colors.black, fontSize: 20, height: 1.2),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () => _updateHighlightedStars(index),
                              icon: Icon(
                                index < _highlightedStars
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 30,
                                color: Colors.amber,
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 5),
                      ])),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey.withOpacity(0.01),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: false,
                      onChanged: (text) {
                        _updateComment(text);
                      },
                      maxLines: 12,
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your comment here"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                width: buttonWidth,
                height: 50,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () => _reviewSubmit(context),
                  child: const Text('Continue',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ));
  }
}

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  int _total = 0;
  int _totalReviews = 0;

  _calcTotal(snapshot) {
    int tot = 0;

    for (int i = 0; i < snapshot.length; i++) {
      final record = Record.fromSnapshot(snapshot[i]);
      tot += record.rating;
    }

    if(snapshot.length>0){
      tot = (tot / snapshot.length).round();

      _total = tot;
      _totalReviews = snapshot.length;
    }

  }

  @override
  Widget build(BuildContext context) {
    var body = _buildBody(context);
    var _totalReviews = _buildTotalReviews(context);

    return Scaffold(
      appBar: AppBar(title: Text('Reviews')),
      body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text('Reviews', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 5),
              _totalReviews,
              SizedBox(height: 3),
              Divider(color: Colors.grey, thickness: 0.4),
              Expanded(child: body == null ? Text('Nothing to display') : body)
            ],
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildTotalReviews(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildTotalReviewsContent(context, snapshot.data.documents);
        });
  }

  Widget _buildTotalReviewsContent(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    _calcTotal(snapshot);
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Icon(
                index < _total ? Icons.star : Icons.star_border,
                size: 15,
                color: Colors.amber,
              );
            }),
          ),
          SizedBox(width: 5),
          Text('$_totalReviews reviews', style: TextStyle(height: 1.2))
        ]));
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    final comment = record.comment;

    var formatter = new DateFormat('dd MMM yyyy');
    String date = formatter
        .format(new DateTime.fromMicrosecondsSinceEpoch(record.id * 1000));

    double textWidthAdjusment = 110.0;

    return Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            child: Row(children: <Widget>[
              SizedBox(width: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://www.pngkey.com/png/full/230-2301779_best-classified-apps-default-user-profile.png',
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              SizedBox(width: 25),
              Container(
                  width: MediaQuery.of(context).size.width - textWidthAdjusment,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < record.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 15,
                                color: Colors.amber,
                              );
                            }),
                          ),
                          SizedBox(width: 15),
                          Text('$date', style: TextStyle(height: 1.2))
                        ]),
                        SizedBox(height: 10),
                        Text('$comment',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: TextStyle(height: 1.2)),
                      ])),
            ])),
        Divider(color: Colors.grey, thickness: 0.4),
        SizedBox(height: 3),
      ],
    );
  }
}

class Record {
  final int id;
  final int rating;
  final String comment;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['rating'] != null),
        assert(map['comment'] != null),
        assert(map['id'] != null),
        rating = map['rating'],
        comment = map['comment'],
        id = map['id'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$rating:$comment>";
}
