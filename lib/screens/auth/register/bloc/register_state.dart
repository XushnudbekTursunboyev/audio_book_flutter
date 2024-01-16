part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ClickBackState extends RegisterState {}

class ClickSignInState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class FailRegisterState extends RegisterState {
  final String msg;

  FailRegisterState(this.msg);
}

class SuccessRegisterState extends RegisterState {}