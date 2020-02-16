import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_sample/module/collection/data/article_model.dart';
import '../data/articles_repository.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  var _articles = <ArticleModel>[];

  get articles => UnmodifiableListView<ArticleModel>(_articles);
  var _currPage = 0;

  @override
  ArticlesState get initialState => ArticlesUninitialized();
  int i = 0;
  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    debugPrint("event change");
    if (event is ArticlesEventLoadData) {
      if (event.isFirstPage) {
        _currPage = 0;
      }
      if (_currPage == 0) {
        _articles.clear();
      }
      final articlesRepo = ArticlesRepository();
      yield ArticlesLoading();
      try {
        final articleResult = await articlesRepo.fetchArticles(_currPage);
        _articles.addAll(articleResult.articles ?? []);
        yield ArticlesFetchCompletion(hasNext: true,);
        _currPage++;
      } catch (error) {
        debugPrint("fetch error: $error");
        yield ArticlesError();
      }
    }
  }
}

/*class 方式*/
abstract class ArticlesEvent extends Equatable {
  ArticlesEvent();

  @override
  List<Object> get props => [];
}

class ArticlesEventLoadData extends ArticlesEvent {
  final bool isFirstPage;

  ArticlesEventLoadData({this.isFirstPage = true});
}

abstract class ArticlesState extends Equatable {
  @override
  List<Object> get props => [];
}

class ArticlesUninitialized extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesError extends ArticlesState {}

class ArticlesFetchCompletion extends ArticlesState {

  final bool hasNext;

  ArticlesFetchCompletion({this.hasNext = true});

}
