part of 'catatan_dokter_bloc.dart';

abstract class CatatanDokterEvent extends Equatable {
  const CatatanDokterEvent();

  @override
  List<Object> get props => [];
}

class CatatanDokterRequested extends CatatanDokterEvent {}

class CatatanDokterCreated extends CatatanDokterEvent {
  final CatatanDokterModel catatanDokter;

  const CatatanDokterCreated(this.catatanDokter);

  @override
  List<Object> get props => [catatanDokter];
}

class CatatanDokterUpdated extends CatatanDokterEvent {
  final CatatanDokterModel catatanDokter;

  const CatatanDokterUpdated(this.catatanDokter);

  @override
  List<Object> get props => [catatanDokter];
}

class CatatanDokterDeleted extends CatatanDokterEvent {
  final int idCatatanDoctor;

  const CatatanDokterDeleted(this.idCatatanDoctor);

  @override
  List<Object> get props => [idCatatanDoctor];
}
