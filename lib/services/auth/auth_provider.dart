import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> Initialze();

  AuthUser? get currentUser;

  Future<AuthUser?> login({required String email, required String password});

  Future<AuthUser> createUser(
      {required String email, required String password});

  Future<void> logOut();

  Future<void> sendEmailVerification();
}
