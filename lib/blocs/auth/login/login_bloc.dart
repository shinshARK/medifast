import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/token.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final SharedPreferences sharedPreferences;
  final AuthRepository authRepository;

  LoginBloc(this.sharedPreferences, this.authRepository) : super(LoginInitial()) {
    // on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<LoginReset>((event, emit) => emit(LoginInitial()));
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {

    print(event.email);
    print(event.password);

    emit(LoginLoading());
    try {
      final loginData = await authRepository.login(event.email, event.password);
      if (loginData != null) {
        // final user = UserModel.fromJson(loginData['user']);
        final token = Token.fromJson(loginData['data']);

        await authRepository.saveToken(token.accessToken, token.refreshToken);
        // await authRepository.saveUser(user);

        // print(token.accessToken);
        // print(token.refreshToken);

        // print(user.firstname);
        // print(user.lastname);
        // print(user.email);
        // print(user.telephone);

        emit(LoginSuccess());
      }
      else {
        emit(LoginFailure('Login failed'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await authRepository.logout();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}