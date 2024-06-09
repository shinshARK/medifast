part of 'doctor_bloc.dart';

sealed class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class DoctorRequested extends DoctorEvent {}

class DoctorByIdRequested extends DoctorEvent {
  final int id;

  DoctorByIdRequested({required this.id});

  @override
  List<Object> get props => [id];
}
