class PercentileCalculator {
  // WHO Growth Standards for boys and girls (simplified version)
  // In a real implementation, you would use the complete WHO LMS parameters
  
  static int calculateWeightPercentile({
    required double weight, // in grams
    required int ageInDays,
    required bool isMale,
  }) {
    // Simplified percentile calculation
    // Real implementation would use WHO LMS (Lambda-Mu-Sigma) method
    
    final expectedWeight = _getExpectedWeight(ageInDays, isMale);
    final standardDeviation = expectedWeight * 0.15; // Approximation
    
    final zScore = (weight - expectedWeight) / standardDeviation;
    return _zScoreToPercentile(zScore);
  }
  
  static int calculateHeightPercentile({
    required double height, // in cm
    required int ageInDays,
    required bool isMale,
  }) {
    final expectedHeight = _getExpectedHeight(ageInDays, isMale);
    final standardDeviation = expectedHeight * 0.08; // Approximation
    
    final zScore = (height - expectedHeight) / standardDeviation;
    return _zScoreToPercentile(zScore);
  }
  
  static int calculateHeadCircumferencePercentile({
    required double headCircumference, // in cm
    required int ageInDays,
    required bool isMale,
  }) {
    final expectedHC = _getExpectedHeadCircumference(ageInDays, isMale);
    final standardDeviation = expectedHC * 0.05; // Approximation
    
    final zScore = (headCircumference - expectedHC) / standardDeviation;
    return _zScoreToPercentile(zScore);
  }
  
  // Simplified expected weight calculation (WHO standards approximation)
  static double _getExpectedWeight(int ageInDays, bool isMale) {
    if (ageInDays == 0) {
      return isMale ? 3300.0 : 3200.0; // Birth weight
    }
    
    double baseWeight = isMale ? 3300.0 : 3200.0;
    
    if (ageInDays <= 30) {
      // First month: rapid growth
      return baseWeight + (ageInDays * 30.0); // ~30g per day
    } else if (ageInDays <= 365) {
      // First year
      double monthlyGain = isMale ? 600.0 : 550.0;
      double months = ageInDays / 30.4;
      return baseWeight + 900 + (months - 1) * monthlyGain;
    } else {
      // After first year
      double years = ageInDays / 365.25;
      double firstYearWeight = baseWeight + 900 + 11 * (isMale ? 600.0 : 550.0);
      double yearlyGain = isMale ? 2000.0 : 1800.0;
      return firstYearWeight + (years - 1) * yearlyGain;
    }
  }
  
  // Simplified expected height calculation
  static double _getExpectedHeight(int ageInDays, bool isMale) {
    if (ageInDays == 0) {
      return isMale ? 50.0 : 49.5; // Birth length
    }
    
    double baseHeight = isMale ? 50.0 : 49.5;
    
    if (ageInDays <= 365) {
      // First year: approximately 25cm growth
      return baseHeight + (ageInDays / 365.0) * 25.0;
    } else {
      // After first year: ~12cm per year in early years
      double years = ageInDays / 365.25;
      double firstYearHeight = baseHeight + 25.0;
      return firstYearHeight + (years - 1) * 12.0;
    }
  }
  
  // Simplified expected head circumference calculation
  static double _getExpectedHeadCircumference(int ageInDays, bool isMale) {
    if (ageInDays == 0) {
      return isMale ? 35.0 : 34.5; // Birth head circumference
    }
    
    double baseHC = isMale ? 35.0 : 34.5;
    
    if (ageInDays <= 365) {
      // First year: approximately 12cm growth
      return baseHC + (ageInDays / 365.0) * 12.0;
    } else {
      // After first year: ~2cm per year
      double years = ageInDays / 365.25;
      double firstYearHC = baseHC + 12.0;
      return firstYearHC + (years - 1) * 2.0;
    }
  }
  
  // Convert Z-score to percentile
  static int _zScoreToPercentile(double zScore) {
    // Simplified conversion using normal distribution approximation
    // Real implementation would use more accurate statistical tables
    
    if (zScore <= -3.0) return 1;
    if (zScore <= -2.0) return 3;
    if (zScore <= -1.5) return 7;
    if (zScore <= -1.0) return 16;
    if (zScore <= -0.5) return 31;
    if (zScore <= 0.0) return 50;
    if (zScore <= 0.5) return 69;
    if (zScore <= 1.0) return 84;
    if (zScore <= 1.5) return 93;
    if (zScore <= 2.0) return 97;
    if (zScore <= 3.0) return 99;
    return 99;
  }
  
  // Helper method to determine baby gender from other data
  // In real app, this should be stored in baby profile
  static bool _inferGenderFromName(String name) {
    // Simplified gender inference - in real app this should be explicit
    final maleNames = ['ahmet', 'mehmet', 'ali', 'mustafa', 'kemal', 'ömer', 'ibrahim'];
    final femaleNames = ['fatma', 'ayşe', 'emine', 'zeynep', 'elif', 'selin', 'deniz'];
    
    final lowerName = name.toLowerCase();
    
    if (maleNames.any((n) => lowerName.contains(n))) return true;
    if (femaleNames.any((n) => lowerName.contains(n))) return false;
    
    // Default to male if uncertain
    return true;
  }
  
  // Calculate all percentiles at once
  static Map<String, int> calculateAllPercentiles({
    required double? weight,
    required double? height,
    required double? headCircumference,
    required int ageInDays,
    required String babyName, // Used for gender inference
  }) {
    final isMale = _inferGenderFromName(babyName);
    
    return {
      'weight': weight != null ? calculateWeightPercentile(
        weight: weight,
        ageInDays: ageInDays,
        isMale: isMale,
      ) : 0,
      'height': height != null ? calculateHeightPercentile(
        height: height,
        ageInDays: ageInDays,
        isMale: isMale,
      ) : 0,
      'headCircumference': headCircumference != null ? calculateHeadCircumferencePercentile(
        headCircumference: headCircumference,
        ageInDays: ageInDays,
        isMale: isMale,
      ) : 0,
    };
  }
}