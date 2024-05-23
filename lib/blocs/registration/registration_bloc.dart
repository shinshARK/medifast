import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/auth_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;

  RegistrationBloc(this.authRepository) : super(RegistrationInitial()) {
    on<RegisterRequest>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(RegisterRequest event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    try {
      final success = await authRepository.register(
        event.namaDepan, event.namaBelakang, event.email, event.telephone, event.password
      );
      if (success) {
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFailure('Registration failed'));
      }
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }
}