part of 'detail_news_bloc.dart';

@immutable
sealed class DetailNewsState {}

final class DetailNewsInitial extends DetailNewsState {}

class NewsDetailInitial extends DetailNewsState {}

class NewsDetailLoading extends DetailNewsState {}

class NewsDetailLoaded extends DetailNewsState {
  final NewsModel newsDetail;

  NewsDetailLoaded(this.newsDetail);
}

class NewsDetailError extends DetailNewsState {
  final String message;

  NewsDetailError(this.message);
}
