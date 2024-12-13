part of 'news_bloc.dart';

sealed class NewsState {}

final class NewsInitial extends NewsState {}

class NewsSuccess extends NewsState {
  final List<Article> articles;

  NewsSuccess(this.articles);
}

class NewsLoading extends NewsState {}

class NewsEmpty extends NewsState {}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
