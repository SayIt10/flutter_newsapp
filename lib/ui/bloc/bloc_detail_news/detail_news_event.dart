part of 'detail_news_bloc.dart';

sealed class DetailNewsEvent {}

class FetchNewsDetailByTitle extends DetailNewsEvent {
  final String title;

  FetchNewsDetailByTitle(this.title);
}
