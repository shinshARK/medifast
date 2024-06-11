part of 'resep_digital_bloc.dart';

abstract class ResepDigitalState extends Equatable {
  const ResepDigitalState();

  @override
  List<Object> get props => [];
}

class ResepDigitalInitial extends ResepDigitalState {}

class ResepDigitalLoading extends ResepDigitalState {}

class ResepDigitalLoaded extends ResepDigitalState {
  final List<ResepDigital> resepDigitals;

  const ResepDigitalLoaded(this.resepDigitals);

  @override
  List<Object> get props => [resepDigitals];
}

class ResepDigitalFailure extends ResepDigitalState {
  final String error;

  const ResepDigitalFailure(this.error);

  @override
  List<Object> get props => [error];
}
