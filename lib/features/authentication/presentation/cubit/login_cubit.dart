import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/features/authentication/data/models/failure_model.dart';
import 'package:socially/features/authentication/data/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository? _authRepository;
  // ignore: invalid_required_positional_param
  LoginCubit({
    required AuthRepository? authRepository,
  })  : _authRepository = authRepository,
        super(LoginState?.initial());

  void emailChanged(String? value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String? value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void logInWithCredentials() async {
    if (!state.isFormValid || state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository?.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: LoginStatus.error));
    }
  }
}
