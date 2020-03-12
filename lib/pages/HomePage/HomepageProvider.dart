import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kide/pages/HomePage/models/CardDetails.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageProvider with ChangeNotifier{
  List<CardDetails> _cardDetails = [];

  List<CardDetails> get cardDetails {
    return _cardDetails;
  }
  Future<Null> refreshList() async{
    Completer<Null> completer=new Completer<Null>();
    new Future.delayed(Duration(seconds: 1)).then((_){
      completer.complete();
      getData();
    });
    return completer.future;
  }

  void getData(){
    List<CardDetails> _tempList= [];
    var firestore = Firestore.instance;
    var qn = firestore.collection("blog_post_homepage").getDocuments();

    qn.then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f)  {
        _tempList.insert(0, CardDetails(heading: f.data['heading'],
            image: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              placeholderCacheHeight: f.data['card']==1 ? 100 : 50,
              image: f.data['image'].toString()),
            cardType: f.data['card'],
            description: f.data['subheading'])
        );
        _tempList.toSet().toList();
      });
      _cardDetails = [_tempList[_tempList.length-1], ..._tempList.sublist(0, _tempList.length-1)];
      notifyListeners();
    });

  }
}

