import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/collection/bloc/article_star_bloc.dart';
import 'package:flutter_bloc_sample/module/collection/widget/article_detail_page.dart';

class ArticleWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return _itemWidget(context);
  }


  Widget _itemWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 5.0,
          )
        ]),
        child: _articleItem(context),
      ),
    );
  }

  Widget _articleItemBuilder(BuildContext context, ArticleState state) {
    final article = BlocProvider.of<ArticleStarBloc>(context).article;
    return IconButton(
      onPressed: () {
        BlocProvider.of<ArticleStarBloc>(context).add(
            article.hasStar ? ArticleStarEvent.unStar : ArticleStarEvent.star);
      },
      icon: Icon(
        Icons.star,
        color: article.hasStar ? Colors.red[400] : Colors.grey,
      ),
    );
  }

  Widget _articleItem(BuildContext context) {
    final article = BlocProvider.of<ArticleStarBloc>(context).article;
    final stack = Stack(
      children: <Widget>[
        ListTile(
          leading: Text(
            article.id,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic),
          ),
          title: Text(
            article.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          isThreeLine: true,
          subtitle: Text(article.desc),
          dense: true,
          trailing: SizedBox(width: 30, height: 30),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.grey.withOpacity(0.2),
              highlightColor: Colors.transparent,
              onTap: () {
                final article =
                    BlocProvider.of<ArticleStarBloc>(context).article;

                Navigator.of(context).push(
                  MaterialPageRoute<ArticleDetailPage>(
                    builder: (context) => ArticleDetailPage(article: article),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          width: 60,
          child: BlocBuilder<ArticleStarBloc, ArticleState>(
            builder: _articleItemBuilder,
          ),
        ),
      ],
    );
    return stack;
  }
}
