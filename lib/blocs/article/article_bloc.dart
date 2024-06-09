import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/artikel_models.dart';
import 'package:rumah_sakit/repositories/article_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final SharedPreferences sharedPreferences;
  final ArticleRepository articleRepository;

  ArticleBloc(this.sharedPreferences, this.articleRepository) : super(ArticleInitial()) {
    on<ArticleRequested>(_onArticleRequested);
  }

  Future<void> _onArticleRequested(ArticleRequested event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    
    try {
      final data_article = await articleRepository.fetchArticle();
      
      emit(ArticleLoaded(data_article));
    } catch (e) {
      print("failed");
      emit(ArticleFailure(e.toString()));
    }
  }
}
