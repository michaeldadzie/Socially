part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final auth.User? user;
  final AuthStatus? satus;

  const AuthState({
    this.user,
    this.satus = AuthStatus.unknown,
  });

  factory AuthState.unknown() => const AuthState();

  factory AuthState.authenticated({required auth.User? user}) {
    return AuthState(user: user, satus: AuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() =>
      const AuthState(satus: AuthStatus.unauthenticated);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user, satus];
}
