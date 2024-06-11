part of 'catatan_dokter_bloc.dart';

abstract class CatatanDokterState extends Equatable {
  const CatatanDokterState();

  @override
  List<Object> get props => [];
}

class CatatanDokterInitial extends CatatanDokterState {}

class CatatanDokterLoading extends CatatanDokterState {}

class CatatanDokterLoaded extends CatatanDokterState {
  final List<CatatanDokterModel> catatanDokterList;

  const CatatanDokterLoaded(this.catatanDokterList);

  @override
  List<Object> get props => [catatanDokterList];
}

class CatatanDokterFailure extends CatatanDokterState {
  final String error;

  const CatatanDokterFailure(this.error);

  @override
  List<Object> get props => [error];
}
