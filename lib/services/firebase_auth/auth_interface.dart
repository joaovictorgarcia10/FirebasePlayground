abstract class AuthInterface {
  Future<bool> doLogin({required String email, required String password});
  Future<bool> registerUser({required String email, required String password});
  bool isValidInputs({required String email, required String password});
}
