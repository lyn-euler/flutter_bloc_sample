import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/collection/bloc/article_star_bloc.dart';
import 'package:flutter_bloc_sample/module/collection/bloc/articles_bloc.dart';
import './article_widget.dart';
import '../bloc/articles_bloc.dart';

class ArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文章列表"),
      ),
      body: BlocProvider<ArticlesBloc>(
        create: (BuildContext context) => ArticlesBloc(),
        child: ArticlesList(),
      ),
    );
  }
}

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ArticlesBloc>(context).add(ArticlesEventLoadData());

    return RefreshIndicator(
      displacement: 40,
      onRefresh: () async {
        BlocProvider.of<ArticlesBloc>(context).add(ArticlesEventLoadData());
      },
      child: BlocBuilder<ArticlesBloc, ArticlesState>(
        // ⚠️：不能添加， 否则item不会刷新？？？
//        condition: (preState, state) {
//          debugPrint("condition:::::$state");
//          return !(state is ArticlesLoading);
//        },
        builder: _blocBuilder,
      ),
    );
  }

  Widget _blocBuilder(BuildContext context, ArticlesState state) {
    debugPrint("build condition:::::$state");
    return _ArticlesList();
  }
}

class _ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = BlocProvider.of<ArticlesBloc>(context).articles;
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        debugPrint('=====++++++滑动到了最底部');
        BlocProvider.of<ArticlesBloc>(context)
            .add(ArticlesEventLoadData(isFirstPage: false));
      }
    });

    return ListView.builder(
      controller: scrollController,
      itemBuilder: _buildItem,
      itemCount: articles.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return BlocProvider<ArticleStarBloc>(
      create: (context) {
        final articles = BlocProvider.of<ArticlesBloc>(context).articles;
        final article = articles[index];
        debugPrint("--++000$article");
        return ArticleStarBloc(article);
      },
      child: ArticleWidget(),
    );
  }
}
