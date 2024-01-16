part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ClickBackState extends LoginState {}

class ClickRegisterState extends LoginState {}

class SuccessSignInState extends LoginState {}

class FailureSignInState extends LoginState {
  final String msg;
  FailureSignInState(this.msg);
}

class LoadingSignInState extends LoginState {}