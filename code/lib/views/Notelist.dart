import 'package:flutter/material.dart';
import 'package:notes/provider/note_provider.dart';
import 'package:notes/views/note.dart';

class Notelist extends StatefulWidget {
  @override
  _NotelistState createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.fill)),
        child: FutureBuilder(
            future: Provider.getNoteList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final notes = snapshot.data;
                return Container(
                    margin: EdgeInsets.all(30),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Note(Notemode.Editing, notes[index])));
                          },
                          child: Card(
                            elevation: 15,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20)),
                            child: Column(
                              children: <Widget>[
                                new ClipRRect(
                                  child: new Image.asset(
                                      "images/background_tile.jpg"),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                new Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _notetitle(notes[index]['title']),
                                      Container(
                                        height: 8,
                                      ),
                                      _notecontent(notes[index]['text']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: notes.length,
                    ));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(Notemode.Creating, null)));
        },
        child: Icon(
          Icons.edit,
        ),
      ),
    );
  }
}

class _notetitle extends StatelessWidget {
  final String _title;

  _notetitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}

class _notecontent extends StatelessWidget {
  final String _text;

  _notecontent(this._text);
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(color: Colors.grey),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
