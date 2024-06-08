import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/repositories/doctor_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final SharedPreferences sharedPreferences;
  final DoctorRepository doctorRepository;

  DoctorBloc(this.sharedPreferences, this.doctorRepository) : super(DoctorInitial()) {
    on<DoctorRequested>(_onDoctorRequested);
  }

  Future<void> _onDoctorRequested(DoctorRequested event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      final data_dokter = await doctorRepository.fetchDokter();

      emit(DoctorLoaded(data_dokter));
    } catch (e) {
      emit(DoctorFailure(e.toString()));
    }
  }
}
