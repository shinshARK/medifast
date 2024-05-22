import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;

  AuthBloc(this.sharedPreferences, this.authRepository) : super(AuthInitial()) {
    // on<AppStarted>(_onAppStarted);
    // on<AuthRegisterRequested>(_onAuthRegisterRequested);
    // on<LoginRequest>(_onLoginRequested);
  }

  // Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
  //   emit(AuthInitial());
  //   final user = await authRepository.getUser();
  //   if (user != null) {
  //     emit(AuthSuccess());
  //   }
  // }

  // Future<void> _onAuthRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     final success = await authRepository.register(
  //       event.namaDepan, event.namaBelakang, event.email, event.telpon, event.password
  //     );
  //     if (success) {
  //       emit(AuthSuccess());
  //     } else {
  //       emit(AuthFailure('Registration failed'));
  //     }
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }
}
