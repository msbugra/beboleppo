import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/baby_provider.dart';
import '../../providers/mother_provider.dart';
import '../recommendations/recommendations_screen.dart';
import '../health/health_tracking_screen.dart';
import '../traditions/traditions_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6B73FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Sağlık',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Öneriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Gelenekler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildHealthTab();
      case 2:
        return _buildRecommendationsTab();
      case 3:
        return _buildTraditionsTab();
      case 4:
        return _buildProfileTab();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return Consumer2<BabyProvider, MotherProvider>(
      builder: (context, babyProvider, motherProvider, child) {
        final baby = babyProvider.baby;
        final mother = motherProvider.mother;

        if (baby == null || mother == null) {
          return const Center(
            child: Text('Bebek bilgileri yüklenemedi'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Merhaba ${mother.name}!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${baby.name} bugün ${babyProvider.humanReadableAge ?? ""} yaşında',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF718096),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B73FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.child_care,
                      color: Color(0xFF6B73FF),
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Baby Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Color(0xFF6B73FF),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Bebek Bilgileri',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('İsim', baby.name),
                    _buildInfoRow('Doğum Tarihi', '${baby.birthDate.day}/${baby.birthDate.month}/${baby.birthDate.year}'),
                    _buildInfoRow('Doğum Kilosu', '${baby.birthWeight.toInt()} gram'),
                    _buildInfoRow('Doğum Boyu', '${baby.birthHeight.toInt()} cm'),
                    _buildInfoRow('Yaş', babyProvider.humanReadableAge ?? ''),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Quick Actions
              const Text(
                'Hızlı İşlemler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      'Büyüme\nKaydı',
                      Icons.trending_up,
                      () => setState(() => _currentIndex = 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      'Günlük\nÖneriler',
                      Icons.lightbulb_outline,
                      () => setState(() => _currentIndex = 2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF718096),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF6B73FF), size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthTab() {
    return const HealthTrackingScreen();
  }

  Widget _buildRecommendationsTab() {
    return const RecommendationsScreen();
  }

  Widget _buildTraditionsTab() {
    return const TraditionsScreen();
  }

  Widget _buildProfileTab() {
    return const ProfileScreen();
  }
}