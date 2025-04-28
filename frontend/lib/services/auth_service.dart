class AuthService {

  static AuthService? _instance;

  AuthService._internal();

  factory AuthService() {
    _instance ??= AuthService._internal();
    return _instance!;
  }

  int _login = 1;

  int get getLogin => _login;

  void login(int login) {
    _login = login;
  }

  void logout() {
    _login = 1;
  }

}