import 'package:flutter/foundation.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/recommendation_repository.dart';
import '../../core/constants/app_constants.dart';

class RecommendationProvider with ChangeNotifier {
  final RecommendationRepository _recommendationRepository;

  List<Recommendation> _todaysRecommendations = [];
  List<Recommendation> _allRecommendations = [];
  String? _selectedCategory;
  bool _isLoading = false;
  String? _error;

  RecommendationProvider({required RecommendationRepository recommendationRepository})
      : _recommendationRepository = recommendationRepository;

  // Getters
  List<Recommendation> get todaysRecommendations => _todaysRecommendations;
  List<Recommendation> get allRecommendations => _allRecommendations;
  String? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  List<String> get categories => AppConstants.recommendationCategories;
  
  List<Recommendation> get filteredRecommendations {
    if (_selectedCategory == null) {
      return _todaysRecommendations;
    }
    return _todaysRecommendations.where((r) => r.category == _selectedCategory).toList();
  }

  // Load recommendations for specific age
  Future<bool> loadRecommendationsForAge(int ageInDays) async {
    _setLoading(true);
    
    final result = await _recommendationRepository.getRecommendationsForAge(ageInDays);
    
    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (recommendations) {
        _todaysRecommendations = recommendations;
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Load recommendations by category
  Future<bool> loadRecommendationsByCategory(String category) async {
    _setLoading(true);
    
    final result = await _recommendationRepository.getRecommendationsByCategory(category);
    
    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (recommendations) {
        _allRecommendations = recommendations;
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Set category filter
  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Seed initial recommendations
  Future<bool> seedRecommendations() async {
    _setLoading(true);
    
    final recommendations = _generateInitialRecommendations();
    final result = await _recommendationRepository.createRecommendations(recommendations);
    
    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (_) {
        _clearError();
        _setLoading(false);
        return true;
      },
    );
  }

  // Generate initial recommendations for testing
  List<Recommendation> _generateInitialRecommendations() {
    final List<Recommendation> recommendations = [];
    final now = DateTime.now();
    
    // Day 1 recommendations
    recommendations.addAll([
      Recommendation(
        id: 'rec_day1_dev',
        ageInDays: 1,
        category: 'Development',
        title: 'Yenidoğan Refleksleri',
        description: 'Bebeğinizin doğuştan gelen reflekslerini gözlemleyin. Çutka refleksi, tutma refleksi ve Moro refleksi normal gelişimin göstergesidir.',
        scientificBasis: 'American Academy of Pediatrics - Newborn Reflexes Guidelines',
        isActive: true,
        createdAt: now,
      ),
      Recommendation(
        id: 'rec_day1_nutrition',
        ageInDays: 1,
        category: 'Nutrition',
        title: 'İlk Emzirme',
        description: 'Doğumdan sonraki ilk saatte emzirme başlatılmalıdır. Kolostrum bebeğiniz için en değerli besindir.',
        scientificBasis: 'WHO - Early Initiation of Breastfeeding',
        isActive: true,
        createdAt: now,
      ),
      Recommendation(
        id: 'rec_day1_sleep',
        ageInDays: 1,
        category: 'Sleep',
        title: 'Güvenli Uyku',
        description: 'Bebeğinizi sırt üstü yatırın. Beşik içinde battaniye, yastık veya oyuncak bulunmamalıdır.',
        scientificBasis: 'American SIDS Institute - Safe Sleep Guidelines',
        isActive: true,
        createdAt: now,
      ),
    ]);

    // Day 7 recommendations
    recommendations.addAll([
      Recommendation(
        id: 'rec_day7_dev',
        ageInDays: 7,
        category: 'Development',
        title: 'Göz Teması',
        description: 'Bebeğinizle göz teması kurmaya başlayın. 20-25 cm mesafeden yüzünüze bakabilir.',
        scientificBasis: 'Journal of Pediatric Psychology - Visual Development',
        isActive: true,
        createdAt: now,
      ),
      Recommendation(
        id: 'rec_day7_activities',
        ageInDays: 7,
        category: 'Activities',
        title: 'Karın Üstü Yatırma',
        description: 'Uyanıkken günde birkaç kez kısa süreli karın üstü yatırın. Boyun kaslarını güçlendirir.',
        scientificBasis: 'American Academy of Pediatrics - Tummy Time Guidelines',
        isActive: true,
        createdAt: now,
      ),
    ]);

    // Day 30 recommendations
    recommendations.addAll([
      Recommendation(
        id: 'rec_day30_dev',
        ageInDays: 30,
        category: 'Development',
        title: 'Sosyal Gülümseme',
        description: 'Bebeğiniz artık sosyal gülümseme başlatabilir. Ses tonunuza tepki verebilir.',
        scientificBasis: 'Child Development Journal - Social Smiling Milestones',
        isActive: true,
        createdAt: now,
      ),
      Recommendation(
        id: 'rec_day30_books',
        ageInDays: 30,
        category: 'Books',
        title: 'İlk Kitaplar',
        description: 'Yüksek kontrastlı siyah-beyaz resimli kitapları gösterebilirsiniz. Yumuşak sesle okuyun.',
        scientificBasis: 'Reading Is Fundamental - Early Literacy Development',
        isActive: true,
        createdAt: now,
      ),
    ]);

    return recommendations;
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

  // Clear all data
  void clear() {
    _todaysRecommendations = [];
    _allRecommendations = [];
    _selectedCategory = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}