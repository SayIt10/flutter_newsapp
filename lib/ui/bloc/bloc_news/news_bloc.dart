import 'package:bloc/bloc.dart';
import 'package:flutter_shared_preferences_app/auth/news_model_datasource.dart';
import 'package:flutter_shared_preferences_app/model/news_model.dart';


part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<GetNews>((event, emit) async {
      //state nya diganti dengan laoding
      emit(NewsLoading());
      //ambil data dari api
      final response = await NewsRemoteDatasource().getNews();
      //state diupldate dengan data
      emit(NewsSuccess(response.articles ?? []));
    });

    on<SearchNews>((event, emit) async {
      emit(NewsLoading());
      final result = await NewsRemoteDatasource().getSearchNews(event.search);
      if (result.articles != null && result.articles!.isEmpty) {
        emit(NewsEmpty());
      } else {
        emit(NewsSuccess(result.articles ?? []));
      }
    });
  }
}
