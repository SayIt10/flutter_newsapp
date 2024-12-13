part of 'news_bloc.dart';
sealed class NewsEvent {}

class GetNews extends NewsEvent {}

class SearchNews extends NewsEvent {
  final String search;

  SearchNews(this.search);
}