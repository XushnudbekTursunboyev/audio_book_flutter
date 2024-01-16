
import 'package:audio_book_flutter/data/model/auth_model.dart';
import 'package:audio_book_flutter/data/model/book_model.dart';

abstract class AppRepository {
  Future<bool> registerWithEmailAndPassword(AuthData authData);
  Future<bool> loginWithEmailAndPassword(AuthData authData);
  Future<bool> authWithGoogle();
  Future<bool> authWithFacebook();
  Future<List<BookData>> getAllBooks();
  Future<String> getDownloadURL(String gsUrl);
  Future<List<BookData>> getBooksByCategory(String category);
  Future<BookData> getBookById(String id);
  Future<String> getAudioDownloadURL(String gsUrl);
  Future<List<BookData>> searchBooksByName(String title);
}