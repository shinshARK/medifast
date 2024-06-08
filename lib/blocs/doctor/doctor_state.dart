part of 'doctor_bloc.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();
  
  @override
  List<Object> get props => [];
}

final class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {

  final List<DokterModel> data_dokter;

  const DoctorLoaded(this.data_dokter);
}

class DoctorFailure extends DoctorState {

  final String error;

  const DoctorFailure(this.error);

  @override
  List<Object> get props => [error];
}