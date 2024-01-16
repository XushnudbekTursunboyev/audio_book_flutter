import 'dart:async';

import 'package:audio_book_flutter/data/model/book_model.dart';
import 'package:audio_book_flutter/data/repository/app_repository_impl.dart';
import 'package:audio_book_flutter/domain/repository/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AppRepository _repository = AppRepositoryImpl();

  MainBloc() : super(MainInitial()) {
    on<BooksLoadEvent>((event, emit) async {
      emit(BooksLoadingState());
      try {
        List<BookData> books = await _repository.getAllBooks();
        emit(BooksLoadedState(books));
      } catch (e) {
        emit(BooksLoadFailureState(e.toString()));
      }
    });

    on<BookImageLoadEvent>((event, emit) async {
      emit(BooksLoadingState());
      try {
        String downloadUrl = await _repository.getDownloadURL(event.url);
        emit(BookImageLoadedState(downloadUrl));
      } catch (e) {
        emit(BooksLoadFailureState(e.toString()));
      }
    });

    on<BooksByCategoryEvent>((event, emit) async {
      emit(BooksLoadingState());
      try {
        emit(BookByCategoryState(event.category));
      } catch (e) {
        emit(BooksLoadFailureState(e.toString()));
      }
    });

    on<BookToPlayEvent>((event, emit) {
      emit(BookToPlayState(event.id));
    });
  }
}
