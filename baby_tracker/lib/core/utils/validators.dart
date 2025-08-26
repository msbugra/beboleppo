class Validators {
  /// Validate if name is not empty and has minimum length
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'İsim gereklidir';
    }
    if (value.trim().length < 2) {
      return 'İsim en az 2 karakter olmalıdır';
    }
    if (value.trim().length > 50) {
      return 'İsim en fazla 50 karakter olabilir';
    }
    return null;
  }
  
  /// Validate birth date
  static String? validateBirthDate(DateTime? value) {
    if (value == null) {
      return 'Doğum tarihi gereklidir';
    }
    
    final now = DateTime.now();
    if (value.isAfter(now)) {
      return 'Doğum tarihi gelecekte olamaz';
    }
    
    // Check if date is too far in the past (reasonable limit)
    final tooOld = now.subtract(Duration(days: 150 * 365)); // 150 years
    if (value.isBefore(tooOld)) {
      return 'Geçerli bir doğum tarihi giriniz';
    }
    
    return null;
  }
  
  /// Validate baby birth date (should not be more than 5 years ago)
  static String? validateBabyBirthDate(DateTime? value) {
    final basicValidation = validateBirthDate(value);
    if (basicValidation != null) return basicValidation;
    
    final now = DateTime.now();
    final fiveYearsAgo = now.subtract(Duration(days: 5 * 365));
    
    if (value!.isBefore(fiveYearsAgo)) {
      return 'Bebek 5 yaşından büyük olamaz';
    }
    
    return null;
  }
  
  /// Validate weight (in grams)
  static String? validateWeight(double? value) {
    if (value == null) {
      return 'Kilo gereklidir';
    }
    if (value <= 0) {
      return 'Kilo 0\'dan büyük olmalıdır';
    }
    if (value < 500) { // 500 grams minimum for premature babies
      return 'Kilo en az 500 gram olmalıdır';
    }
    if (value > 10000) { // 10 kg maximum reasonable birth weight
      return 'Kilo çok yüksek görünüyor';
    }
    return null;
  }
  
  /// Validate height (in centimeters)
  static String? validateHeight(double? value) {
    if (value == null) {
      return 'Boy gereklidir';
    }
    if (value <= 0) {
      return 'Boy 0\'dan büyük olmalıdır';
    }
    if (value < 25) { // 25 cm minimum for premature babies
      return 'Boy en az 25 cm olmalıdır';
    }
    if (value > 100) { // 100 cm maximum reasonable for babies
      return 'Boy çok yüksek görünüyor';
    }
    return null;
  }
  
  /// Validate head circumference (in centimeters)
  static String? validateHeadCircumference(double? value) {
    if (value == null) {
      return 'Baş çevresi gereklidir';
    }
    if (value <= 0) {
      return 'Baş çevresi 0\'dan büyük olmalıdır';
    }
    if (value < 20) { // 20 cm minimum
      return 'Baş çevresi en az 20 cm olmalıdır';
    }
    if (value > 60) { // 60 cm maximum reasonable
      return 'Baş çevresi çok yüksek görünüyor';
    }
    return null;
  }
  
  /// Validate city name
  static String? validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // City is optional
    }
    if (value.trim().length < 2) {
      return 'Şehir adı en az 2 karakter olmalıdır';
    }
    if (value.trim().length > 50) {
      return 'Şehir adı en fazla 50 karakter olabilir';
    }
    return null;
  }
  
  /// Validate birth time
  static String? validateBirthTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Birth time is optional
    }
    
    // Check format HH:MM
    final timeRegex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
    if (!timeRegex.hasMatch(value.trim())) {
      return 'Geçerli bir saat formatı giriniz (ÖR: 14:30)';
    }
    
    return null;
  }
  
  /// Validate notes or descriptions
  static String? validateNotes(String? value, {int maxLength = 500}) {
    if (value == null || value.trim().isEmpty) {
      return null; // Notes are optional
    }
    if (value.trim().length > maxLength) {
      return 'Not en fazla $maxLength karakter olabilir';
    }
    return null;
  }
}