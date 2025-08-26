class AppConstants {
  static const String appName = 'Baby Tracker';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'baby_tracker.db';
  static const int databaseVersion = 1;
  
  // Age calculations
  static const int newbornDays = 28;
  static const int dailyRecommendationMaxAge = 1095; // 3 years in days
  static const int maxTrackingAge = 1825; // 5 years in days
  
  // Recommendation categories
  static const List<String> recommendationCategories = [
    'Development',
    'Nutrition',
    'Sleep',
    'Activities',
    'Books',
    'Music',
    'Toys',
    'Safety',
  ];
  
  // Growth tracking
  static const List<String> growthMetrics = [
    'Weight',
    'Height',
    'Head Circumference',
  ];
}