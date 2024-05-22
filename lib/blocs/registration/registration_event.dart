part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}


class RegisterRequest extends RegistrationEvent {
  final String namaDepan;
  final String namaBelakang;
  final String email;
  final String telpon;
  final String password;

  RegisterRequest(this.namaDepan, this.namaBelakang, this.email, this.telpon, this.password);
  @override
  List<Object> get props => [namaDepan, namaBelakang, email, telpon, password];
}