import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/collection/data/article_model.dart';

class ArticleStarBloc extends Bloc<ArticleStarEvent, ArticleState> {
  final ArticleModel article;

  ArticleStarBloc(this.article) : assert(article != null);
  bool _loading = false;

  @override
  ArticleState get initialState => ArticleState.normal;

  @override
  Stream<ArticleState> mapEventToState(ArticleStarEvent event) async* {
    if (_loading) {
      return;
    }
    _loading = true;
    try {
      article.hasStar = event == ArticleStarEvent.star;
      yield article.hasStar ? ArticleState.stared : ArticleState.normal;
      //request to star or not
//      Future.delayed(Duration(seconds: 2));
    } catch (_) {
      /*失败了重置回来*/
      article.hasStar = !article.hasStar;
      yield article.hasStar ? ArticleState.stared : ArticleState.normal;
    }
    _loading = false;
  }
}


enum ArticleStarEvent {
  star,
  unStar,
}

enum ArticleState {
  normal,
  stared,
}
