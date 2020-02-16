import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ArticleModel {
  final String id;
  final String title;
  final String desc;
  final String url;
  bool hasStar;

  ArticleModel({@required this.id, this.title, this.desc, this.url, this.hasStar = false});

//  @override
//  List<Object> get props => [id, title];

  @override
  String toString() {
    return "{id: $id, title: $title, desc: $desc, hasStar: $hasStar}";
  }



}
