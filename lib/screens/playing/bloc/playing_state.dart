part of 'playing_bloc.dart';@immutableabstract class PlayingState {}class PlayingInitial extends PlayingState {}class GetBookByIdState extends PlayingState {  final BookData book;  GetBookByIdState(this.book);}class LoadingState extends PlayingState {}class OpenBookFileState extends PlayingState {  final String url;  OpenBookFileState(this.url);}