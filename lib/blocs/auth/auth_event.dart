
part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();
  // equatable
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthRegisterRequested extends AuthEvent {
  final String namaDepan;
  final String namaBelakang;
  final String email;
  final String telpon;
  final String password;

  AuthRegisterRequested(this.namaDepan, this.namaBelakang, this.email, this.telpon, this.password);
}

class LoginRequest extends AuthEvent {}

