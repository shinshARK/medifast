import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/catatan_dokter_model.dart';
import 'package:rumah_sakit/repositories/catatan_dokter_repository.dart';

part 'catatan_dokter_event.dart';
part 'catatan_dokter_state.dart';

class CatatanDokterBloc extends Bloc<CatatanDokterEvent, CatatanDokterState> {
  final CatatanDokterRepository catatanDokterRepository;

  CatatanDokterBloc(this.catatanDokterRepository) : super(CatatanDokterInitial()) {
    on<CatatanDokterRequested>(_onCatatanDokterRequested);
    on<CatatanDokterCreated>(_onCatatanDokterCreated);
    on<CatatanDokterUpdated>(_onCatatanDokterUpdated);
    on<CatatanDokterDeleted>(_onCatatanDokterDeleted);
  }

  Future<void> _onCatatanDokterRequested(
      CatatanDokterRequested event, Emitter<CatatanDokterState> emit) async {
    emit(CatatanDokterLoading());

    try {
      final catatanDokterList = await catatanDokterRepository.fetchCatatanDokter();

      emit(CatatanDokterLoaded(catatanDokterList));
    } catch (e) {
      emit(CatatanDokterFailure(e.toString()));
    }
  }

  Future<void> _onCatatanDokterCreated(
      CatatanDokterCreated event, Emitter<CatatanDokterState> emit) async {
    try {
      await catatanDokterRepository.createCatatanDokter(event.catatanDokter);
      
      final catatanDokterList = await catatanDokterRepository.fetchCatatanDokter();

      emit(CatatanDokterLoaded(catatanDokterList));
    } catch (e) {
      emit(CatatanDokterFailure(e.toString()));
    }
  }

  Future<void> _onCatatanDokterUpdated(
      CatatanDokterUpdated event, Emitter<CatatanDokterState> emit) async {
    try {
      await catatanDokterRepository.updateCatatanDokter(event.catatanDokter);
      
      final catatanDokterList = await catatanDokterRepository.fetchCatatanDokter();

      emit(CatatanDokterLoaded(catatanDokterList));
    } catch (e) {
      emit(CatatanDokterFailure(e.toString()));
    }
  }

  Future<void> _onCatatanDokterDeleted(
      CatatanDokterDeleted event, Emitter<CatatanDokterState> emit) async {
    try {
      await catatanDokterRepository.deleteCatatanDokter(event.idCatatanDoctor);
      
      final catatanDokterList = await catatanDokterRepository.fetchCatatanDokter();

      emit(CatatanDokterLoaded(catatanDokterList));
    } catch (e) {
      emit(CatatanDokterFailure(e.toString()));
    }
  }
}
