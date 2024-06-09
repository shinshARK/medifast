import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/artikel_models.dart';
import 'package:rumah_sakit/repositories/article_repository.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc(this.articleRepository) : super(ArticleInitial()) {
    on<ArticleRequested>(_onArticleRequested);
  }

  Future<void> _onArticleRequested(
      ArticleRequested event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());

    try {
      final articles = await articleRepository.fetchArticles();

      emit(ArticleLoaded(articles));
    } catch (e) {
      emit(ArticleFailure(e.toString()));
    }
  }
}
