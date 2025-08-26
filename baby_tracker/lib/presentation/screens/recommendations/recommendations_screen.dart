import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/recommendation_provider.dart';
import '../../providers/baby_provider.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecommendations();
    });
  }

  Future<void> _loadRecommendations() async {
    final babyProvider = context.read<BabyProvider>();
    final recommendationProvider = context.read<RecommendationProvider>();
    
    if (babyProvider.baby != null) {
      final ageInDays = babyProvider.babyAgeInDays ?? 1;
      await recommendationProvider.loadRecommendationsForAge(ageInDays);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Consumer2<RecommendationProvider, BabyProvider>(
          builder: (context, recommendationProvider, babyProvider, child) {
            return Column(
              children: [
                _buildHeader(babyProvider),
                _buildCategoryFilter(recommendationProvider),
                _buildRecommendationsList(recommendationProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BabyProvider babyProvider) {
    final baby = babyProvider.baby;
    final ageText = babyProvider.humanReadableAge ?? '';
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF6B73FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Günlük Öneriler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            baby != null 
                ? '${baby.name} için ($ageText)'
                : 'Bebeğiniz için öneriler',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(RecommendationProvider provider) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: provider.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCategoryChip(
              'Tümü',
              provider.selectedCategory == null,
              () => provider.setCategory(null),
            );
          }
          
          final category = provider.categories[index - 1];
          return _buildCategoryChip(
            category,
            provider.selectedCategory == category,
            () => provider.setCategory(category),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: const Color(0xFF6B73FF).withValues(alpha: 0.2),
        checkmarkColor: const Color(0xFF6B73FF),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF6B73FF) : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildRecommendationsList(RecommendationProvider provider) {
    if (provider.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF6B73FF)),
        ),
      );
    }

    if (provider.error != null) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Öneriler yüklenemedi',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                provider.error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadRecommendations,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    final recommendations = provider.filteredRecommendations;

    if (recommendations.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lightbulb_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Henüz öneri bulunmuyor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Bu yaş için öneriler yakında eklenecek',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await provider.seedRecommendations();
                  _loadRecommendations();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B73FF),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Örnek Önerileri Yükle'),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: _loadRecommendations,
        child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final recommendation = recommendations[index];
            return _buildRecommendationCard(recommendation);
          },
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(recommendation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(recommendation.category).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    recommendation.category,
                    style: TextStyle(
                      color: _getCategoryColor(recommendation.category),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  _getCategoryIcon(recommendation.category),
                  color: _getCategoryColor(recommendation.category),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              recommendation.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recommendation.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF718096),
                height: 1.5,
              ),
            ),
            if (recommendation.scientificBasis != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.science,
                      color: Color(0xFF6B73FF),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        recommendation.scientificBasis!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B73FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Development':
        return const Color(0xFF10B981);
      case 'Nutrition':
        return const Color(0xFFF59E0B);
      case 'Sleep':
        return const Color(0xFF8B5CF6);
      case 'Activities':
        return const Color(0xFFEF4444);
      case 'Books':
        return const Color(0xFF06B6D4);
      case 'Music':
        return const Color(0xFFEC4899);
      case 'Toys':
        return const Color(0xFF84CC16);
      case 'Safety':
        return const Color(0xFF6366F1);
      default:
        return const Color(0xFF6B73FF);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Development':
        return Icons.trending_up;
      case 'Nutrition':
        return Icons.restaurant;
      case 'Sleep':
        return Icons.bedtime;
      case 'Activities':
        return Icons.sports_handball;
      case 'Books':
        return Icons.menu_book;
      case 'Music':
        return Icons.music_note;
      case 'Toys':
        return Icons.toys;
      case 'Safety':
        return Icons.security;
      default:
        return Icons.lightbulb;
    }
  }
}