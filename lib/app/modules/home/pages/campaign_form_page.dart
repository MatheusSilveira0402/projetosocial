import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CampaignFormPage extends StatefulWidget {
  const CampaignFormPage({super.key});

  @override
  State<CampaignFormPage> createState() => _CampaignFormPageState();
}

class _CampaignFormPageState extends State<CampaignFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _typesController = TextEditingController(); // lista separada por vírgula
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  DateTime? _endDate;

  bool _loading = false;

  Future<void> _saveCampaign() async {
    if (!_formKey.currentState!.validate() || _endDate == null) return;

    setState(() => _loading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('campaigns').add({
        'userId': user?.uid,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'donationTypes': _typesController.text.split(',').map((e) => e.trim()).toList(),
        'dropOffLocation': _locationController.text.trim(),
        'contact': _contactController.text.trim(),
        'endDate': _endDate!.toIso8601String(),
        'createdAt': DateTime.now().toIso8601String(),
      });

      Modular.to.pop(); // Volta pra Home
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar campanha: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _pickEndDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selected != null) {
      setState(() => _endDate = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Campanha')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título da campanha'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _typesController,
                decoration: const InputDecoration(
                  labelText: 'Tipos de doação (separados por vírgula)',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Local de entrega'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contato (WhatsApp, e-mail...)',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _endDate == null
                          ? 'Sem data selecionada'
                          : 'Até: ${_endDate!.toLocal().toString().split(' ').first}',
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _pickEndDate,
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Selecionar data'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                    onPressed: _saveCampaign,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar Campanha'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
