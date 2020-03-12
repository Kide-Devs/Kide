import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kide/pages/HomePage/models/CardDetails.dart';

class HomePageProvider with ChangeNotifier{
  List<CardDetails> _cardDetails = [];

  List<CardDetails> get cardDetails {
    return _cardDetails;
  }
  Future<Null> refreshList() async
  {

  Completer<Null> completer=new Completer<Null>();
  new Future.delayed(Duration(seconds: 1)).then((_){
    completer.complete();
    getData();
  });
  return completer.future;

  }
  void getData()
  {
    List<CardDetails> TempList= [];
    var firestore = Firestore.instance;
    var qn = firestore.collection("blog_post_homepage").getDocuments();

    qn.then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f)  {
        TempList.add(CardDetails(heading: f.data['heading'],
            image:  Image.network(f.data['image'].toString()),
            cardType: f.data['card'],
            description: f.data['subheading'])
        );
        TempList.toSet().toList();
      });
      _cardDetails = TempList;
      notifyListeners();
    });

  }
}

