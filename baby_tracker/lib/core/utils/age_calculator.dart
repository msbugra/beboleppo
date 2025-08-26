import '../constants/app_constants.dart';

class AgeCalculator {
  /// Calculate baby age in days from birth date
  static int calculateAgeInDays(DateTime birthDate) {
    final now = DateTime.now();
    return now.difference(birthDate).inDays;
  }
  
  /// Calculate baby age in weeks
  static int calculateAgeInWeeks(DateTime birthDate) {
    return (calculateAgeInDays(birthDate) / 7).floor();
  }
  
  /// Calculate baby age in months (approximate)
  static int calculateAgeInMonths(DateTime birthDate) {
    final now = DateTime.now();
    int months = (now.year - birthDate.year) * 12 + (now.month - birthDate.month);
    if (now.day < birthDate.day) {
      months--;
    }
    return months;
  }
  
  /// Calculate baby age in years
  static int calculateAgeInYears(DateTime birthDate) {
    final now = DateTime.now();
    int years = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      years--;
    }
    return years;
  }
  
  /// Get age category for recommendations
  static AgeCategory getAgeCategory(DateTime birthDate) {
    final ageInDays = calculateAgeInDays(birthDate);
    
    if (ageInDays <= AppConstants.newbornDays) {
      return AgeCategory.newborn;
    } else if (ageInDays <= AppConstants.dailyRecommendationMaxAge) {
      return AgeCategory.infant;
    } else if (ageInDays <= AppConstants.maxTrackingAge) {
      return AgeCategory.toddler;
    } else {
      return AgeCategory.outOfRange;
    }
  }
  
  /// Check if baby is newborn (0-28 days)
  static bool isNewborn(DateTime birthDate) {
    return calculateAgeInDays(birthDate) <= AppConstants.newbornDays;
  }
  
  /// Get human readable age string
  static String getHumanReadableAge(DateTime birthDate) {
    final ageInDays = calculateAgeInDays(birthDate);
    final ageInWeeks = calculateAgeInWeeks(birthDate);
    final ageInMonths = calculateAgeInMonths(birthDate);
    final ageInYears = calculateAgeInYears(birthDate);
    
    if (ageInDays <= 28) {
      return '$ageInDays gün';
    } else if (ageInMonths < 1) {
      return '$ageInWeeks hafta';
    } else if (ageInYears < 1) {
      return '$ageInMonths ay';
    } else if (ageInYears == 1 && ageInMonths == 12) {
      return '1 yaş';
    } else {
      final remainingMonths = ageInMonths - (ageInYears * 12);
      if (remainingMonths == 0) {
        return '$ageInYears yaş';
      } else {
        return '$ageInYears yaş $remainingMonths ay';
      }
    }
  }
}

enum AgeCategory {
  newborn,   // 0-28 days
  infant,    // 29 days - 3 years
  toddler,   // 3-5 years
  outOfRange // >5 years
}