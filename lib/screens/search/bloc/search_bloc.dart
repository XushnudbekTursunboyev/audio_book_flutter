import 'package:audio_book_flutter/data/model/book_model.dart';import 'package:audio_book_flutter/data/repository/app_repository_impl.dart';import 'package:audio_book_flutter/domain/repository/app_repository.dart';import 'package:bloc/bloc.dart';import 'package:meta/meta.dart';part 'search_event.dart';part 'search_state.dart';class SearchBloc extends Bloc<SearchEvent, SearchState> {  final AppRepository _repository = AppRepositoryImpl();  SearchBloc() : super(SearchInitial()) {    on<BookSearchByTitleEvent>((event, emit) async {      try {        List<BookData> books = await _repository.searchBooksByName(event.title);        emit(BookSearchByTitleState(books));      } catch (e) {      }    });    on<BookToPlayEvent>((event, emit) {      emit(BookToPlayState(event.id));    });  }}