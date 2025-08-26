import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/baby_provider.dart';

class HealthTrackingScreen extends StatefulWidget {
  const HealthTrackingScreen({super.key});

  @override
  State<HealthTrackingScreen> createState() => _HealthTrackingScreenState();
}

class _HealthTrackingScreenState extends State<HealthTrackingScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGrowthTab(),
                  _buildVaccineTab(),
                  _buildSleepTab(),
                  _buildNutritionTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF10B981),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.health_and_safety, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Sağlık Takibi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Consumer<BabyProvider>(
            builder: (context, babyProvider, child) {
              final baby = babyProvider.baby;
              return Text(
                baby != null 
                    ? '${baby.name} için sağlık kayıtları'
                    : 'Bebeğinizin sağlık kayıtları',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF10B981),
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        tabs: const [
          Tab(text: 'Büyüme'),
          Tab(text: 'Aşılar'),
          Tab(text: 'Uyku'),
          Tab(text: 'Beslenme'),
        ],
      ),
    );
  }

  Widget _buildGrowthTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Growth Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildGrowthSummaryCard(
                  'Kilo',
                  '4.2 kg',
                  '65. Percentil',
                  Icons.monitor_weight,
                  const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGrowthSummaryCard(
                  'Boy',
                  '62 cm',
                  '70. Percentil',
                  Icons.height,
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildGrowthSummaryCard(
            'Baş Çevresi',
            '40 cm',
            '55. Percentil',
            Icons.face,
            const Color(0xFFF59E0B),
            isWide: true,
          ),
          
          const SizedBox(height: 24),
          
          // Add Measurement Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _showAddMeasurementDialog,
              icon: const Icon(Icons.add),
              label: const Text('Yeni Ölçüm Ekle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Growth Chart Placeholder
          Expanded(
            child: Container(
              width: double.infinity,
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
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.show_chart, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Büyüme Grafiği',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Yakında eklenecek',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthSummaryCard(
    String title,
    String value,
    String percentile,
    IconData icon,
    Color color,
    {bool isWide = false}
  ) {
    return Container(
      width: isWide ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isWide ? Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(percentile, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ) : Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(percentile, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildVaccineTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.vaccines, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Aşı Takibi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('Bu özellik geliştiriliyor...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSleepTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bedtime, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Uyku Takibi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('Bu özellik geliştiriliyor...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Beslenme Takibi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('Bu özellik geliştiriliyor...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  void _showAddMeasurementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yeni Ölçüm Ekle'),
        content: const Text('Bu özellik yakında eklenecek.\n\nÖlçüm ekleme formu geliştiriliyor...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}