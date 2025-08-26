import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/mother.dart';
import '../../domain/repositories/mother_repository.dart';

class MotherProvider with ChangeNotifier {
  final MotherRepository _motherRepository;
  final Uuid _uuid = const Uuid();

  Mother? _mother;
  bool _isLoading = false;
  String? _error;

  MotherProvider({required MotherRepository motherRepository})
      : _motherRepository = motherRepository;

  // Getters
  Mother? get mother => _mother;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMother => _mother != null;

  // Check if mother exists
  Future<bool> checkMotherExists() async {
    _setLoading(true);
    
    final result = await _motherRepository.getMother();
    
    result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (mother) {
        _mother = mother;
        _clearError();
        _setLoading(false);
        return mother != null;
      },
    );
    
    return _mother != null;
  }

  // Create new mother
  Future<bool> createMother({
    required String name,
    DateTime? birthDate,
    String? birthCity,
    required bool astrologyEnabled,
  }) async {
    _setLoading(true);

    final now = DateTime.now();
    final mother = Mother(
      id: _uuid.v4(),
      name: name.trim(),
      birthDate: birthDate,
      birthCity: birthCity?.trim(),
      astrologyEnabled: astrologyEnabled,
      createdAt: now,
      updatedAt: now,
    );

    final result = await _motherRepository.createMother(mother);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (createdMother) {
        _mother = createdMother;
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Update existing mother
  Future<bool> updateMother({
    String? name,
    DateTime? birthDate,
    String? birthCity,
    bool? astrologyEnabled,
  }) async {
    if (_mother == null) return false;

    _setLoading(true);

    final updatedMother = _mother!.copyWith(
      name: name ?? _mother!.name,
      birthDate: birthDate ?? _mother!.birthDate,
      birthCity: birthCity ?? _mother!.birthCity,
      astrologyEnabled: astrologyEnabled ?? _mother!.astrologyEnabled,
      updatedAt: DateTime.now(),
    );

    final result = await _motherRepository.updateMother(updatedMother);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (mother) {
        _mother = mother;
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Delete mother
  Future<bool> deleteMother() async {
    if (_mother == null) return false;

    _setLoading(true);

    final result = await _motherRepository.deleteMother(_mother!.id);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (_) {
        _mother = null;
        _clearError();
        _setLoading(false);
        return true;
      },
    );
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

  // Clear all data (useful for logout/reset)
  void clear() {
    _mother = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}