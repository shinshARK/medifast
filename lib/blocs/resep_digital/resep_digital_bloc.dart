import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/resep_digital.dart';
import 'package:rumah_sakit/repositories/resep_digital_repository.dart';

part 'resep_digital_event.dart';
part 'resep_digital_state.dart';

class ResepDigitalBloc extends Bloc<ResepDigitalEvent, ResepDigitalState> {
  final ResepDigitalRepository resepDigitalRepository;

  ResepDigitalBloc(this.resepDigitalRepository) : super(ResepDigitalInitial()) {
    on<ResepDigitalRequested>(_onResepDigitalRequested);
    on<ResepDigitalCreated>(_onResepDigitalCreated);
    on<ResepDigitalUpdated>(_onResepDigitalUpdated);
    on<ResepDigitalDeleted>(_onResepDigitalDeleted);
  }

  Future<void> _onResepDigitalRequested(
      ResepDigitalRequested event, Emitter<ResepDigitalState> emit) async {
    emit(ResepDigitalLoading());

    try {
      final resepDigitals = await resepDigitalRepository.fetchResepDigitals();

      emit(ResepDigitalLoaded(resepDigitals));
    } catch (e) {
      emit(ResepDigitalFailure(e.toString()));
    }
  }

  Future<void> _onResepDigitalCreated(
      ResepDigitalCreated event, Emitter<ResepDigitalState> emit) async {
    try {
      await resepDigitalRepository.createResepDigital(event.resepDigital);
      
      final resepDigitals = await resepDigitalRepository.fetchResepDigitals();

      emit(ResepDigitalLoaded(resepDigitals));
    } catch (e) {
      emit(ResepDigitalFailure(e.toString()));
    }
  }

  Future<void> _onResepDigitalUpdated(
      ResepDigitalUpdated event, Emitter<ResepDigitalState> emit) async {
    try {
      await resepDigitalRepository.updateResepDigital(event.resepDigital);
      
      final resepDigitals = await resepDigitalRepository.fetchResepDigitals();

      emit(ResepDigitalLoaded(resepDigitals));
    } catch (e) {
      emit(ResepDigitalFailure(e.toString()));
    }
  }

  Future<void> _onResepDigitalDeleted(
      ResepDigitalDeleted event, Emitter<ResepDigitalState> emit) async {
    try {
      await resepDigitalRepository.deleteResepDigital(event.idResepDigital);
      
      final resepDigitals = await resepDigitalRepository.fetchResepDigitals();

      emit(ResepDigitalLoaded(resepDigitals));
    } catch (e) {
      emit(ResepDigitalFailure(e.toString()));
    }
  }
}
