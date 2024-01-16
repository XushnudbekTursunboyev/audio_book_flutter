part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class ClickBackEvent extends RegisterEvent {}

class ClickSignInEvent extends RegisterEvent {}

class ClickRegisterEvent extends RegisterEvent {
  final String email;
  final String password;

  ClickRegisterEvent(this.email, this.password);
}

class FailRegisterEvent extends RegisterEvent {
  final String msg;

  FailRegisterEvent(this.msg);
}

class SuccessRegisterEvent extends RegisterEvent {}

class ClickGoogleEvent extends RegisterEvent {}

class ClickFacebookEvent extends RegisterEvent {}