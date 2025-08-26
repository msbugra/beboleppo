import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/baby.dart';
import '../../domain/repositories/baby_repository.dart';
import '../../core/utils/age_calculator.dart';

class BabyProvider with ChangeNotifier {
  final BabyRepository _babyRepository;
  final Uuid _uuid = const Uuid();

  Baby? _baby;
  List<Baby> _babies = [];
  bool _isLoading = false;
  String? _error;

  BabyProvider({required BabyRepository babyRepository})
      : _babyRepository = babyRepository;

  // Getters
  Baby? get baby => _baby;
  List<Baby> get babies => _babies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasBaby => _baby != null;

  // Age-related getters for current baby
  int? get babyAgeInDays => _baby != null ? AgeCalculator.calculateAgeInDays(_baby!.birthDate) : null;
  int? get babyAgeInWeeks => _baby != null ? AgeCalculator.calculateAgeInWeeks(_baby!.birthDate) : null;
  int? get babyAgeInMonths => _baby != null ? AgeCalculator.calculateAgeInMonths(_baby!.birthDate) : null;
  int? get babyAgeInYears => _baby != null ? AgeCalculator.calculateAgeInYears(_baby!.birthDate) : null;
  String? get humanReadableAge => _baby != null ? AgeCalculator.getHumanReadableAge(_baby!.birthDate) : null;
  AgeCategory? get ageCategory => _baby != null ? AgeCalculator.getAgeCategory(_baby!.birthDate) : null;
  bool get isNewborn => _baby != null ? AgeCalculator.isNewborn(_baby!.birthDate) : false;

  // Load baby for mother
  Future<bool> loadBaby(String motherId) async {
    _setLoading(true);
    
    final result = await _babyRepository.getBaby(motherId);
    
    result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (baby) {
        _baby = baby;
        _clearError();
        _setLoading(false);
        return true;
      },
    );
    
    return _baby != null;
  }

  // Load all babies for mother
  Future<bool> loadBabies(String motherId) async {
    _setLoading(true);
    
    final result = await _babyRepository.getBabies(motherId);
    
    result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (babies) {
        _babies = babies;
        if (babies.isNotEmpty) {
          _baby = babies.first; // Set the first baby as active
        }
        _clearError();
        _setLoading(false);
        return true;
      },
    );
    
    return true;
  }

  // Create new baby
  Future<bool> createBaby({
    required String motherId,
    required String name,
    required DateTime birthDate,
    String? birthTime,
    required double birthWeight,
    required double birthHeight,
    required double birthHeadCircumference,
    String? birthCity,
  }) async {
    _setLoading(true);

    final now = DateTime.now();
    final baby = Baby(
      id: _uuid.v4(),
      motherId: motherId,
      name: name.trim(),
      birthDate: birthDate,
      birthTime: birthTime?.trim(),
      birthWeight: birthWeight,
      birthHeight: birthHeight,
      birthHeadCircumference: birthHeadCircumference,
      birthCity: birthCity?.trim(),
      createdAt: now,
      updatedAt: now,
    );

    final result = await _babyRepository.createBaby(baby);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (createdBaby) {
        _baby = createdBaby;
        _babies.add(createdBaby);
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Update existing baby
  Future<bool> updateBaby({
    String? name,
    DateTime? birthDate,
    String? birthTime,
    double? birthWeight,
    double? birthHeight,
    double? birthHeadCircumference,
    String? birthCity,
  }) async {
    if (_baby == null) return false;

    _setLoading(true);

    final updatedBaby = _baby!.copyWith(
      name: name ?? _baby!.name,
      birthDate: birthDate ?? _baby!.birthDate,
      birthTime: birthTime ?? _baby!.birthTime,
      birthWeight: birthWeight ?? _baby!.birthWeight,
      birthHeight: birthHeight ?? _baby!.birthHeight,
      birthHeadCircumference: birthHeadCircumference ?? _baby!.birthHeadCircumference,
      birthCity: birthCity ?? _baby!.birthCity,
      updatedAt: DateTime.now(),
    );

    final result = await _babyRepository.updateBaby(updatedBaby);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (baby) {
        _baby = baby;
        // Update in babies list
        final index = _babies.indexWhere((b) => b.id == baby.id);
        if (index != -1) {
          _babies[index] = baby;
        }
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Set active baby
  void setActiveBaby(Baby baby) {
    _baby = baby;
    notifyListeners();
  }

  // Delete baby
  Future<bool> deleteBaby(String babyId) async {
    _setLoading(true);

    final result = await _babyRepository.deleteBaby(babyId);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (_) {
        _babies.removeWhere((baby) => baby.id == babyId);
        if (_baby?.id == babyId) {
          _baby = _babies.isNotEmpty ? _babies.first : null;
        }
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
    _baby = null;
    _babies = [];
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}