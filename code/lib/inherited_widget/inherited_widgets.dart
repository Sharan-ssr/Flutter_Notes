import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget{

  final notes = [
    {
      'title':'asdf',
      'text':'hello'
    },
    {
      'title':'ghjk',
      'text':'hi'
    },
    {
      'title':'qwer',
      'text':'zxcv'
    }
  ];

  NoteInheritedWidget(Widget child) : super(child:child);

  static NoteInheritedWidget of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(NoteInheritedWidget)as NoteInheritedWidget);
  }

  bool updateShouldNotify(NoteInheritedWidget oldwidget){
    return oldwidget.notes != notes;
  }
}