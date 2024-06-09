part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();
  
  @override
  List<Object> get props => [];
}

final class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {

  final List<Article> data_article;

  const ArticleLoaded(this.data_article);
}

class ArticleFailure extends ArticleState {

  final String error;

  const ArticleFailure(this.error);

  @override
  List<Object> get props => [error];
}
