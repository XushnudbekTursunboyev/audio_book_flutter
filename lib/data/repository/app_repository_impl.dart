
import 'package:audio_book_flutter/data/model/auth_model.dart';
import 'package:audio_book_flutter/data/model/book_model.dart';
import 'package:audio_book_flutter/data/source/local/pref/my_shared_pref.dart';
import 'package:audio_book_flutter/domain/repository/app_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppRepositoryImpl extends AppRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> loginWithEmailAndPassword(AuthData authData) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(AuthData authData) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> authWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      MySharedPreference.setEmail(googleUser.email);
      MySharedPreference.setFullName(googleUser.displayName ?? "Unknown");
      MySharedPreference.setAvatar(googleUser.photoUrl ?? "");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> authWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

        await _firebaseAuth.signInWithCredential(facebookAuthCredential);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BookData>> getAllBooks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('book').get();
      List<BookData> books = querySnapshot.docs.map((doc) {
        return BookData.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return books;
    } catch (e) {
      print("Repository getAllBooks - ${e.toString()}");
      return [];
    }
  }

  @override
  Future<String> getDownloadURL(String gsUrl) async {
    try {
      if (!gsUrl.startsWith('gs://')) return gsUrl;
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      return await ref.getDownloadURL();
    } catch (e) {
      return 'https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/81YkqyaFVEL._AC_UF1000,1000_QL80_.jpg';
    }
  }

  @override
  Future<List<BookData>> getBooksByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('book')
          .where('category', isEqualTo: category)
          .get();

      List<BookData> books = snapshot.docs.map((doc) {
        return BookData.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return books;
    } catch (e) {
      print("Error getBooksByCategory: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<BookData> getBookById(String id) async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('book').where('id', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> bookData =
        snapshot.docs.first.data() as Map<String, dynamic>;
        return BookData.fromJson(bookData);
      } else {
        throw Exception('Book not found');
      }
    } catch (e) {
      print("Error getBookById: ${e.toString()}");
      return BookData();
    }
  }

  @override
  Future<String> getAudioDownloadURL(String gsUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(gsUrl);
    return await ref.getDownloadURL();
  }

  @override
  Future<List<BookData>> searchBooksByName(String title) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('book')
          .where(
        'title',
        isGreaterThanOrEqualTo: title.isEmpty ? 0 : title,
        isLessThan: title.isEmpty
            ? null
            : title.substring(0, title.length - 1) +
            String.fromCharCode(
              title.codeUnitAt(title.length - 1) + 1,
            ),
      )
          .get();

      List<BookData> books = snapshot.docs.map((doc) {
        return BookData.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return books;
    } catch (e) {
      return [];
    }
  }
}
