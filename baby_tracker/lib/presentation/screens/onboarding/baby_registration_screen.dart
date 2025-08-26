import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/baby_provider.dart';
import '../../providers/mother_provider.dart';
import '../../providers/app_provider.dart';
import '../../../core/utils/validators.dart';
import '../dashboard/dashboard_screen.dart';

class BabyRegistrationScreen extends StatefulWidget {
  const BabyRegistrationScreen({super.key});

  @override
  State<BabyRegistrationScreen> createState() => _BabyRegistrationScreenState();
}

class _BabyRegistrationScreenState extends State<BabyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthTimeController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _headCircumferenceController = TextEditingController();
  final _birthCityController = TextEditingController();
  
  DateTime? _birthDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthTimeController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _headCircumferenceController.dispose();
    _birthCityController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 5 * 365)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  Future<void> _selectBirthTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      _birthTimeController.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen doğum tarihini seçin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final motherProvider = context.read<MotherProvider>();
    final babyProvider = context.read<BabyProvider>();
    final appProvider = context.read<AppProvider>();
    
    if (motherProvider.mother == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final success = await babyProvider.createBaby(
      motherId: motherProvider.mother!.id,
      name: _nameController.text,
      birthDate: _birthDate!,
      birthTime: _birthTimeController.text.isNotEmpty ? _birthTimeController.text : null,
      birthWeight: double.parse(_weightController.text),
      birthHeight: double.parse(_heightController.text),
      birthHeadCircumference: double.parse(_headCircumferenceController.text),
      birthCity: _birthCityController.text.isNotEmpty ? _birthCityController.text : null,
    );

    if (success) {
      await appProvider.completeOnboarding();
      
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
        (route) => false,
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(babyProvider.error ?? 'Bir hata oluştu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bebek Bilgileri'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Şimdi bebeğinizle\ntanışalım',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                const Text(
                  'Bu bilgiler bebeğinizin gelişimini takip etmek için gereklidir.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF718096),
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Baby Name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Bebek Adı *',
                            hintText: 'Örn: Ahmet',
                            border: OutlineInputBorder(),
                          ),
                          validator: Validators.validateName,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Birth Date
                        InkWell(
                          onTap: _selectBirthDate,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Doğum Tarihi *',
                              hintText: 'Tarih seçin',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              _birthDate != null
                                  ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                                  : 'Tarih seçin',
                              style: TextStyle(
                                color: _birthDate != null ? Colors.black : Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Birth Time
                        TextFormField(
                          controller: _birthTimeController,
                          decoration: InputDecoration(
                            labelText: 'Doğum Saati (İsteğe bağlı)',
                            hintText: 'Örn: 14:30',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.access_time),
                              onPressed: _selectBirthTime,
                            ),
                          ),
                          validator: Validators.validateBirthTime,
                          readOnly: true,
                          onTap: _selectBirthTime,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        Row(
                          children: [
                            // Weight
                            Expanded(
                              child: TextFormField(
                                controller: _weightController,
                                decoration: const InputDecoration(
                                  labelText: 'Doğum Kilosu *',
                                  hintText: 'gram',
                                  border: OutlineInputBorder(),
                                  suffixText: 'gr',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => Validators.validateWeight(
                                  value != null && value.isNotEmpty ? double.tryParse(value) : null,
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 12),
                            
                            // Height
                            Expanded(
                              child: TextFormField(
                                controller: _heightController,
                                decoration: const InputDecoration(
                                  labelText: 'Doğum Boyu *',
                                  hintText: 'cm',
                                  border: OutlineInputBorder(),
                                  suffixText: 'cm',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) => Validators.validateHeight(
                                  value != null && value.isNotEmpty ? double.tryParse(value) : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Head Circumference
                        TextFormField(
                          controller: _headCircumferenceController,
                          decoration: const InputDecoration(
                            labelText: 'Baş Çevresi *',
                            hintText: 'cm',
                            border: OutlineInputBorder(),
                            suffixText: 'cm',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => Validators.validateHeadCircumference(
                            value != null && value.isNotEmpty ? double.tryParse(value) : null,
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Birth City
                        TextFormField(
                          controller: _birthCityController,
                          decoration: const InputDecoration(
                            labelText: 'Doğduğu Şehir (İsteğe bağlı)',
                            hintText: 'Örn: İstanbul',
                            border: OutlineInputBorder(),
                          ),
                          validator: Validators.validateCity,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Complete Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B73FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Kaydı Tamamla',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}