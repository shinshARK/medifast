part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;

  const ArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleFailure extends ArticleState {
  final String error;

  const ArticleFailure(this.error);

  @override
  List<Object> get props => [error];
}
