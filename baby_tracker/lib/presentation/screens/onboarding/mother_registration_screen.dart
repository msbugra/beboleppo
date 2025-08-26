import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/mother_provider.dart';
import '../../../core/utils/validators.dart';
import 'baby_registration_screen.dart';

class MotherRegistrationScreen extends StatefulWidget {
  const MotherRegistrationScreen({super.key});

  @override
  State<MotherRegistrationScreen> createState() => _MotherRegistrationScreenState();
}

class _MotherRegistrationScreenState extends State<MotherRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthCityController = TextEditingController();
  
  DateTime? _birthDate;
  bool _astrologyEnabled = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthCityController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final motherProvider = context.read<MotherProvider>();
    
    final success = await motherProvider.createMother(
      name: _nameController.text,
      birthDate: _birthDate,
      birthCity: _birthCityController.text.isNotEmpty ? _birthCityController.text : null,
      astrologyEnabled: _astrologyEnabled,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const BabyRegistrationScreen(),
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(motherProvider.error ?? 'Bir hata oluştu'),
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
        title: const Text('Anne Bilgileri'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                  'Öncelikle sizinle\ntanışalım',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                const Text(
                  'Bu bilgiler bebeğiniz için kişiselleştirilmiş öneriler oluşturmamıza yardımcı olur.',
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
                        // Name Field
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Adınız *',
                            hintText: 'Örn: Ayşe Demir',
                            border: OutlineInputBorder(),
                          ),
                          validator: Validators.validateName,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Birth Date Field
                        InkWell(
                          onTap: _selectBirthDate,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Doğum Tarihiniz (İsteğe bağlı)',
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
                        
                        // Birth City Field
                        TextFormField(
                          controller: _birthCityController,
                          decoration: const InputDecoration(
                            labelText: 'Doğduğunuz Şehir (İsteğe bağlı)',
                            hintText: 'Örn: İstanbul',
                            border: OutlineInputBorder(),
                          ),
                          validator: Validators.validateCity,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Astrology Switch
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_outline,
                                color: Color(0xFF6B73FF),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Astroloji Özellikleri',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xFF2D3748),
                                      ),
                                    ),
                                    Text(
                                      'Anne-bebek uyumu ve burç özellikleri',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF718096),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _astrologyEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    _astrologyEnabled = value;
                                  });
                                },
                                activeColor: const Color(0xFF6B73FF),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Continue Button
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
                            'Devam Et',
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