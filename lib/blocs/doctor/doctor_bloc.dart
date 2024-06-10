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
    on<DoctorByIdRequested>(_onDoctorByIdRequested);
  }

  Future<void> _onDoctorRequested(DoctorRequested event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    
    try {
      final data_dokter = await doctorRepository.fetchDokter();
      
      emit(DoctorLoaded(data_dokter));
    } catch (e) {
      print("failet");
      emit(DoctorFailure(e.toString()));
    }
  }

  Future<void> _onDoctorByIdRequested(DoctorByIdRequested event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    
    try {
      final dokter = await doctorRepository.fetchDokterById(event.id);
      
      emit(DoctorLoadedById(dokter));
    } catch (e) {
      print("Failed to load doctor by id");
      emit(DoctorFailure(e.toString()));
    }
  }

}
