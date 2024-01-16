import 'dart:async';

import 'package:audio_book_flutter/data/model/auth_model.dart';
import 'package:audio_book_flutter/data/repository/app_repository_impl.dart';
import 'package:audio_book_flutter/domain/repository/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppRepository _repository = AppRepositoryImpl();

  LoginBloc() : super(LoginInitial()) {
    on<ClickBackEvent>((event, emit) {
      emit(ClickBackState());
    });
    on<ClickRegisterEvent>((event, emit) {
      emit(ClickRegisterState());
    });
    on<ClickSignInEvent>((event, emit) async {
      emit(LoadingSignInState());
      try {
        bool loginBehaviour = await _repository
            .loginWithEmailAndPassword(AuthData(event.email, event.password));
        if (loginBehaviour == true) {
          emit(SuccessSignInState());
        } else {
          emit(FailureSignInState("Something went wrong!"));
        }
      } catch (e) {
        emit(FailureSignInState(e.toString()));
      }
    });

    on<ClickSignInWithGoogleEvent>((event, emit) async {
      emit(LoadingSignInState());
      try {
        bool registerBehaviour = await _repository.authWithGoogle();
        if (registerBehaviour == true) {
          emit(SuccessSignInState());
        } else {
          emit(FailureSignInState("Something went wrong!"));
        }
      } catch (e) {
        emit(FailureSignInState(e.toString()));
      }
    });

    on<ClickSignInWithFbEvent>((event, emit) async {
      emit(LoadingSignInState());
      try {
        bool registrationBehaviour = await _repository.authWithFacebook();
        if (registrationBehaviour == true) {
          emit(SuccessSignInState());
        } else {
          emit(FailureSignInState("Something went wrong!"));
        }
      } catch (e) {
        emit(FailureSignInState(e.toString()));
      }
    });
  }
}
