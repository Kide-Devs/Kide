import 'package:flutter/material.dart';
import 'package:kide/models/SubEvent.dart';

class Bookmarks with ChangeNotifier{
  List<SubEvent> _bookmarks = [];

  List<SubEvent> get bookmarks {
    return _bookmarks;
  }

  void addBookmark( subEvent ) {
    _bookmarks.add( subEvent );
    notifyListeners();
    List<String> p = [];
    _bookmarks.forEach((b) => p.add(b.name));
    print(p);
  }

  void removeBookmark( subEvent ) {
    _bookmarks.remove( subEvent );
    notifyListeners();
    List<String> p = [];
    _bookmarks.forEach((b) => p.add(b.name));
    print(p);
  }
}