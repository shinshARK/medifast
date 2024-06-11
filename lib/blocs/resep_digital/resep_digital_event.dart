part of 'resep_digital_bloc.dart';

abstract class ResepDigitalEvent extends Equatable {
  const ResepDigitalEvent();

  @override
  List<Object> get props => [];
}

class ResepDigitalRequested extends ResepDigitalEvent {}

class ResepDigitalCreated extends ResepDigitalEvent {
  final ResepDigital resepDigital;

  const ResepDigitalCreated(this.resepDigital);

  @override
  List<Object> get props => [resepDigital];
}

class ResepDigitalUpdated extends ResepDigitalEvent {
  final ResepDigital resepDigital;

  const ResepDigitalUpdated(this.resepDigital);

  @override
  List<Object> get props => [resepDigital];
}

class ResepDigitalDeleted extends ResepDigitalEvent {
  final int idResepDigital;

  const ResepDigitalDeleted(this.idResepDigital);

  @override
  List<Object> get props => [idResepDigital];
}
