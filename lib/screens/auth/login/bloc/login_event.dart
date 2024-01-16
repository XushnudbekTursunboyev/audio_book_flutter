part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class ClickBackEvent extends LoginEvent {}

class ClickRegisterEvent extends LoginEvent {}

class ClickSignInEvent extends LoginEvent {
  final String email;
  final String password;

  ClickSignInEvent(this.email, this.password);
}

class FailureSignInEvent extends LoginEvent {
  final String msg;

  FailureSignInEvent(this.msg);
}

class SuccessSignInEvent extends LoginEvent {}

class ClickSignInWithGoogleEvent extends LoginEvent {}

class ClickSignInWithFbEvent extends LoginEvent {}