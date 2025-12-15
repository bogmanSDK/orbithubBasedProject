/// Service for handling authentication
class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  
  factory AuthService() {
    return _instance;
  }
  
  AuthService._internal();
  
  // Simple authentication state
  bool _isAuthenticated = false;
  
  /// Check if user is authenticated
  bool isAuthenticated() {
    return _isAuthenticated;
  }
  
  /// Log in the user
  void login() {
    _isAuthenticated = true;
  }
  
  /// Log out the user
  void logout() {
    _isAuthenticated = false;
  }
}
