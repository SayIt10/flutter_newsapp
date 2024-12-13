import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../auth/news_model_datasource.dart';
import '../../../model/news_model.dart';

part 'detail_news_event.dart';
part 'detail_news_state.dart';

class DetailNewsBloc extends Bloc<DetailNewsEvent, DetailNewsState> {
  DetailNewsBloc() : super(DetailNewsInitial()) {
    on<FetchNewsDetailByTitle>((event, emit) async {
      emit(NewsDetailLoading());
      try {
        final newsDetail = await NewsRemoteDatasource().getNewsByTitle(event.title);
        emit(NewsDetailLoaded(newsDetail));
      } catch (e) {
        emit(NewsDetailError(e.toString()));
      }
    });
  }
}
