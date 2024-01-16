part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class BooksLoadedState extends MainState {
  final List<BookData> books;

  BooksLoadedState(this.books);
}

class BooksLoadingState extends MainState {}

class BooksLoadFailureState extends MainState {
  final String msg;

  BooksLoadFailureState(this.msg);
}

class BookImageLoadedState extends MainState {
  final String url;

  BookImageLoadedState(this.url);
}

class BookByCategoryState extends MainState {
  final String category;

  BookByCategoryState(this.category);
}

class BookToPlayState extends MainState {
  final String id;

  BookToPlayState(this.id);
}