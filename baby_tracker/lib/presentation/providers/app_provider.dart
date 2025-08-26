import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  bool _isFirstTime = true;
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isFirstTime => _isFirstTime;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize app state
  Future<void> initializeApp() async {
    _setLoading(true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      _isFirstTime = prefs.getBool('is_first_time') ?? true;
      
      _clearError();
    } catch (e) {
      _setError('Failed to initialize app: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Mark as not first time
  Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_first_time', false);
      _isFirstTime = false;
      notifyListeners();
    } catch (e) {
      _setError('Failed to complete onboarding: ${e.toString()}');
    }
  }

  // Reset app to first time (useful for testing)
  Future<void> resetApp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_first_time', true);
      _isFirstTime = true;
      notifyListeners();
    } catch (e) {
      _setError('Failed to reset app: ${e.toString()}');
    }
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}