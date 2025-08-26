import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/baby_provider.dart';
import '../../providers/mother_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Consumer2<BabyProvider, MotherProvider>(
          builder: (context, babyProvider, motherProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildProfileCard(motherProvider, babyProvider),
                  const SizedBox(height: 20),
                  if (motherProvider.mother?.astrologyEnabled == true) ...[
                    _buildAstrologyCard(babyProvider),
                    const SizedBox(height: 20),
                  ],
                  _buildSettingsCard(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Icon(Icons.person, color: Color(0xFF6B73FF), size: 28),
        SizedBox(width: 12),
        Text(
          'Profil',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(MotherProvider motherProvider, BabyProvider babyProvider) {
    final mother = motherProvider.mother;
    final baby = babyProvider.baby;

    return Container(
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
          const Row(
            children: [
              Icon(Icons.family_restroom, color: Color(0xFF6B73FF), size: 20),
              SizedBox(width: 8),
              Text(
                'Aile Bilgileri',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Mother Info
          if (mother != null) ...[
            const Text(
              'Anne',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mother.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
            if (mother.birthDate != null) ...[
              const SizedBox(height: 4),
              Text(
                'Doğum Tarihi: ${mother.birthDate!.day}/${mother.birthDate!.month}/${mother.birthDate!.year}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                ),
              ),
            ],
            if (mother.birthCity != null) ...[
              const SizedBox(height: 4),
              Text(
                'Doğum Yeri: ${mother.birthCity}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                ),
              ),
            ],
          ],

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),

          // Baby Info
          if (baby != null) ...[
            const Text(
              'Bebek',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              baby.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Doğum Tarihi: ${baby.birthDate.day}/${baby.birthDate.month}/${baby.birthDate.year}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF718096),
              ),
            ),
            if (baby.birthTime != null) ...[
              const SizedBox(height: 4),
              Text(
                'Doğum Saati: ${baby.birthTime}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                ),
              ),
            ],
            const SizedBox(height: 4),
            Text(
              'Yaş: ${babyProvider.humanReadableAge ?? ""}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAstrologyCard(BabyProvider babyProvider) {
    final baby = babyProvider.baby;
    if (baby == null) return const SizedBox.shrink();

    final zodiacSign = _getZodiacSign(baby.birthDate);

    return Container(
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
              Icon(Icons.star, color: _getZodiacColor(zodiacSign), size: 20),
              const SizedBox(width: 8),
              const Text(
                'Astroloji',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getZodiacColor(zodiacSign).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getZodiacIcon(zodiacSign),
                  color: _getZodiacColor(zodiacSign),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      zodiacSign,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${baby.name}\'in burcu',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Burç Özellikleri',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getZodiacDescription(zodiacSign),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.settings, color: Color(0xFF6B73FF), size: 20),
                SizedBox(width: 8),
                Text(
                  'Ayarlar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),
          
          _buildSettingItem(
            icon: Icons.edit,
            title: 'Profil Düzenle',
            subtitle: 'Anne ve bebek bilgilerini düzenle',
            onTap: () {},
          ),
          
          _buildSettingItem(
            icon: Icons.star_outline,
            title: 'Astroloji Ayarları',
            subtitle: 'Astroloji özelliklerini yönet',
            onTap: () {},
          ),
          
          _buildSettingItem(
            icon: Icons.file_download,
            title: 'Verileri Dışa Aktar',
            subtitle: 'Sağlık kayıtlarını dışa aktar',
            onTap: () {},
          ),
          
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'Hakkında',
            subtitle: 'Uygulama bilgileri ve sürüm',
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(icon, color: const Color(0xFF718096), size: 20),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF718096),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.grey[200], height: 1),
          ),
      ],
    );
  }

  String _getZodiacSign(DateTime birthDate) {
    final month = birthDate.month;
    final day = birthDate.day;

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return 'Koç';
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return 'Boğa';
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return 'İkizler';
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return 'Yengeç';
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return 'Aslan';
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return 'Başak';
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return 'Terazi';
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return 'Akrep';
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return 'Yay';
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return 'Oğlak';
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return 'Kova';
    return 'Balık'; // February 19 - March 20
  }

  Color _getZodiacColor(String sign) {
    switch (sign) {
      case 'Koç': return const Color(0xFFEF4444);
      case 'Boğa': return const Color(0xFF10B981);
      case 'İkizler': return const Color(0xFFF59E0B);
      case 'Yengeç': return const Color(0xFF3B82F6);
      case 'Aslan': return const Color(0xFFF59E0B);
      case 'Başak': return const Color(0xFF10B981);
      case 'Terazi': return const Color(0xFF8B5CF6);
      case 'Akrep': return const Color(0xFFEF4444);
      case 'Yay': return const Color(0xFF6366F1);
      case 'Oğlak': return const Color(0xFF059669);
      case 'Kova': return const Color(0xFF0EA5E9);
      case 'Balık': return const Color(0xFF8B5CF6);
      default: return const Color(0xFF6B73FF);
    }
  }

  IconData _getZodiacIcon(String sign) {
    switch (sign) {
      case 'Koç': return Icons.pets;
      case 'Boğa': return Icons.agriculture;
      case 'İkizler': return Icons.people;
      case 'Yengeç': return Icons.pest_control;
      case 'Aslan': return Icons.star;
      case 'Başak': return Icons.eco;
      case 'Terazi': return Icons.balance;
      case 'Akrep': return Icons.bug_report;
      case 'Yay': return Icons.sports_score;
      case 'Oğlak': return Icons.landscape;
      case 'Kova': return Icons.water_drop;
      case 'Balık': return Icons.waves;
      default: return Icons.star;
    }
  }

  String _getZodiacDescription(String sign) {
    switch (sign) {
      case 'Koç': return 'Liderlik yetisi olan, cesur ve enerjik. Girişimci ruhlu ve bağımsız.';
      case 'Boğa': return 'Sabırlı, kararlı ve güvenilir. Sanatsal yetenekleri olan, konfordan hoşlanan.';
      case 'İkizler': return 'İletişim yeteneği yüksek, meraklı ve uyumlu. Çok yönlü ve sosyal.';
      case 'Yengeç': return 'Duygusal, koruyucu ve şefkatli. Aile bağları güçlü, sezgileri gelişmiş.';
      case 'Aslan': return 'Özgüvenli, yaratıcı ve cömert. Doğal liderlik yetenekleri olan, sadık.';
      case 'Başak': return 'Analitik, düzenli ve mükemmeliyetçi. Detaycı ve yardımsever.';
      case 'Terazi': return 'Adaletli, diplomaisi, uyumlu. Estetik anlayışı gelişmiş, sosyal.';
      case 'Akrep': return 'Tutkulu, kararlı ve sezgisel. Derinlemesine düşünen, sadık.';
      case 'Yay': return 'Özgür ruhlu, iyimser ve maceraperest. Felsefi düşünce yapısına sahip.';
      case 'Oğlak': return 'Disiplinli, sorumlu ve hedef odaklı. Kararlı ve çalışkan.';
      case 'Kova': return 'Bağımsız, yaratıcı ve insancıl. Yenilikçi ve özgün düşünce yapısı.';
      case 'Balık': return 'Hayal gücü gelişmiş, empatik ve şefkatli. Sanatsal yetenekleri olan.';
      default: return 'Her burcun kendine özgü güzel özellikleri vardır.';
    }
  }
}