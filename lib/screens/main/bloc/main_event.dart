part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class BooksLoadEvent extends MainEvent {}

class BookImageLoadEvent extends MainEvent {
  final String url;

  BookImageLoadEvent(this.url);
}

class BooksByCategoryEvent extends MainEvent {
  final String category;

  BooksByCategoryEvent(this.category);
}

class BookToPlayEvent extends MainEvent {
  final String id;

  BookToPlayEvent(this.id);
}