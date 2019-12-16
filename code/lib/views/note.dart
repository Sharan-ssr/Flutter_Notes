import 'package:flutter/material.dart';
import 'package:notes/inherited_widget/inherited_widgets.dart';
import 'package:notes/provider/note_provider.dart';

enum Notemode{
  Editing,
  Creating,
}

class Note extends StatefulWidget {

  final Notemode notemode;
  final Map<String,dynamic> note;

  Note(this.notemode, this.note);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {

  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _textControler = TextEditingController();

  List<Map<String, String>>get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if(widget.notemode == Notemode.Editing){
      _titleControler.text = widget.note['title'];
    _textControler.text = widget.note['text'];
    }
     super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.notemode == Notemode.Creating ? 'New note':'Edit note'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/bg.png"),fit: BoxFit.fill)
        ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleControler,
              decoration: InputDecoration(hintText: "Heading",
              filled: true,
              fillColor: Colors.white70,),
            ),
            Container(
              height: 10,
            ),
            TextField(
              controller: _textControler,
              decoration: InputDecoration(hintText: "Content",
              filled: true,
              fillColor: Colors.white70,),
              maxLines: 10,
            ),
            Container(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.notemode == Notemode.Creating ?
                _Notebutton('Discard', Colors.grey, () {
                  Navigator.pop(context);
                }):_Notebutton('Delete', Colors.red, () async {
                  await Provider.delete(widget.note['id']);
                  Navigator.pop(context);
                }),
                _Notebutton('Save', Colors.blue, () {
                  final title = _titleControler.text;
                  final text = _textControler.text;

                  if(widget?.notemode == Notemode.Creating){
                     Provider.insertnote({
                      'title':title,
                      'text':text
                     });
                   } if(widget?.notemode == Notemode.Editing){
                    Provider.updatenote({
                      'id':widget.note['id'],
                      'title':_titleControler.text,
                      'text':_textControler.text,
                    });
                    }
                  Navigator.pop(context);
                }),
              ],
            )
          ],
        ),
      ),),
    );
  }
}

class _Notebutton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onpressed;
  _Notebutton(this._text, this._color, this._onpressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onpressed,
      child: Text(_text),
      color: _color,
      minWidth: 80,
    );
  }
}
