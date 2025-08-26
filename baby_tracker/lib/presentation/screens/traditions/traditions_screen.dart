import 'package:flutter/material.dart';

class TraditionsScreen extends StatefulWidget {
  const TraditionsScreen({super.key});

  @override
  State<TraditionsScreen> createState() => _TraditionsScreenState();
}

class _TraditionsScreenState extends State<TraditionsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  
  final List<TraditionItem> _turkishTraditions = [
    TraditionItem(
      name: 'Mevlid Kandili',
      description: 'Hz. Muhammed\'in doğum günü olan Mevlid Kandili\'nde bebek için özel dualar edilir.',
      culture: 'Türk',
      category: 'Dini',
    ),
    TraditionItem(
      name: 'Kırk Çıkarma',
      description: 'Doğumdan 40 gün sonra anne ve bebek ilk kez dışarı çıkar, yakınlara gösterilir.',
      culture: 'Türk',
      category: 'Geleneksel',
    ),
    TraditionItem(
      name: 'Ad Koyma Töreni',
      description: 'Bebeğin adının konulması için yapılan özel tören ve dua.',
      culture: 'Türk',
      category: 'Dini',
    ),
    TraditionItem(
      name: 'Diş Hediği',
      description: 'Bebeğin ilk dişi çıktığında yapılan kutlama ve hediye verme geleneği.',
      culture: 'Türk',
      category: 'Geleneksel',
    ),
    TraditionItem(
      name: 'İlk Adım Kutlaması',
      description: 'Bebeğin ilk adımını attığında yapılan kutlama ve şeker dağıtma.',
      culture: 'Türk',
      category: 'Geleneksel',
    ),
  ];

  final List<TraditionItem> _worldTraditions = [
    TraditionItem(
      name: 'Baby Shower (ABD)',
      description: 'Doğumdan önce anneyi kutlamak ve hediyeler vermek için yapılan parti.',
      culture: 'Amerikan',
      category: 'Modern',
    ),
    TraditionItem(
      name: 'Red Egg Celebration (Çin)',
      description: 'Bebeğin 100. gününde kırmızı yumurta dağıtarak kutlama yapılır.',
      culture: 'Çin',
      category: 'Geleneksel',
    ),
    TraditionItem(
      name: 'Baptism (Hristiyanlık)',
      description: 'Bebeğin vaftiz edilmesi ile dini topluma katılması.',
      culture: 'Hristiyan',
      category: 'Dini',
    ),
    TraditionItem(
      name: 'Jatakarma (Hindistan)',
      description: 'Hint geleneğinde bebeğin doğumundan sonra ilk 10 gün içinde yapılan ritüel.',
      culture: 'Hint',
      category: 'Dini',
    ),
    TraditionItem(
      name: 'Aqiqah (İslam)',
      description: 'Bebeğin 7. gününde yapılan kurban kesme ve isim verme töreni.',
      culture: 'İslami',
      category: 'Dini',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                  _buildTraditionsList(_turkishTraditions),
                  _buildTraditionsList(_worldTraditions),
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
        color: Color(0xFF8B5CF6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.public, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Kültürel Gelenekler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Dünyadan bebek geleneklerini keşfedin',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
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
          color: const Color(0xFF8B5CF6),
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Türk Gelenekleri'),
          Tab(text: 'Dünya Gelenekleri'),
        ],
      ),
    );
  }

  Widget _buildTraditionsList(List<TraditionItem> traditions) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: traditions.length,
      itemBuilder: (context, index) {
        final tradition = traditions[index];
        return _buildTraditionCard(tradition);
      },
    );
  }

  Widget _buildTraditionCard(TraditionItem tradition) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showTraditionDetail(tradition),
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
                        color: _getCategoryColor(tradition.category).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tradition.category,
                        style: TextStyle(
                          color: _getCategoryColor(tradition.category),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  tradition.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tradition.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey[500],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tradition.culture,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Dini':
        return const Color(0xFF10B981);
      case 'Geleneksel':
        return const Color(0xFF8B5CF6);
      case 'Modern':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF6B73FF);
    }
  }

  void _showTraditionDetail(TraditionItem tradition) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              tradition.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3748),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(tradition.category).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              tradition.category,
                              style: TextStyle(
                                color: _getCategoryColor(tradition.category),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey[500], size: 16),
                          const SizedBox(width: 4),
                          Text(
                            tradition.culture,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildDetailSection('Açıklama', tradition.description),
                      const SizedBox(height: 20),
                      _buildDetailSection('Nasıl Yapılır', 'Bu gelenek hakkında daha detaylı bilgi ve uygulama adımları yakında eklenecek.'),
                      const SizedBox(height: 20),
                      _buildDetailSection('Kültürel Önemi', 'Bu geleneğin kültürel ve tarihi önemi hakkında detaylı bilgiler yakında eklenecek.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF718096),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class TraditionItem {
  final String name;
  final String description;
  final String culture;
  final String category;

  TraditionItem({
    required this.name,
    required this.description,
    required this.culture,
    required this.category,
  });
}