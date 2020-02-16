import 'package:flutter/material.dart';
import '../../../network/api.dart';
import './article_model.dart';

class ArticlesRepository {
  Future<ArticlesResult> fetchArticles(int page) async {
    final response = await ArticlesProvider.articles(page);

    if (!response['success']) {
      throw Exception("error to fetch article");
    }
    final data = response['data']['articles'] as List;

    final hasNext = response['data']['hasNext'] as bool;

    final articles = data.map((raw) {
      final article = ArticleModel(
          id: "${raw['id'] + page * 10}", title: raw['title'], desc: raw['desc']);
      debugPrint("====${article}");
      return article;
    }).toList();

    return ArticlesResult(hasNext: hasNext, articles: articles);
  }
}

class ArticlesResult {
  final bool hasNext;
  final List<ArticleModel> articles;

  ArticlesResult({this.articles, this.hasNext});

  @override
  String toString() {
    return "hasNext: $hasNext, articles: $articles";
  }
}

class ArticlesProvider {
  static Future<Map<String, dynamic>> articles(int page) async {
    final response =
        await Api.rap.get('v1/articles', queryParameters: {'page': page});
    return response.data;
  }
}
