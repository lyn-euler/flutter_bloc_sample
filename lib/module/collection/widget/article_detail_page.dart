import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/module/collection/data/article_model.dart';

class ArticleDetailPage extends StatelessWidget {
  final ArticleModel article;

  ArticleDetailPage({this.article}) : assert(article != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("文章详情"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                "${article.title}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text("${article.desc}"),
            ),
          ],
        ),
      ),
    );
  }
}
