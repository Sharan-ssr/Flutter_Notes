import 'package:flutter/material.dart';
import 'package:notes/inherited_widget/inherited_widgets.dart';
import 'package:notes/views/Notelist.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
    MaterialApp(
      home: Notelist(),
    ),
    );
  }
}