import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:projetosocial/app/modules/home/controller/campaing_form_controller.dart';

class CampaignFormPage extends StatefulWidget {
  const CampaignFormPage({super.key});

  @override
  State<CampaignFormPage> createState() => _CampaignFormPageState();
}

class _CampaignFormPageState extends State<CampaignFormPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = CampaingFormController();
  bool _loading = false;

  Future<void> _pickEndDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selected != null) {
      // Exibe a data no formato dd/MM/yyyy para o usuário
      final displayDate = DateFormat('dd/MM/yyyy').format(selected);
      controller.dataFimController.text = displayDate;

      // Armazena a data no formato yyyyMMdd para uso interno
      controller.dataFimRaw = DateFormat('yyyyMMdd').format(selected);
    }
  }

  Future<void> _saveCampaign() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);



    final sucesso = await controller.salvarCampanha();
    if (sucesso) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Campanha salva com sucesso!')));
      Modular.to.pop();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao salvar a campanha!')));
    }

    setState(() => _loading = false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                controller: controller.tituloController,
                decoration: const InputDecoration(labelText: 'Título da campanha'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.tipoDoacaoController,
                decoration: const InputDecoration(
                  labelText: 'Tipos de doação (separados por vírgula)',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.localEntrega,
                decoration: const InputDecoration(labelText: 'Local de entrega'),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.contatos,
                decoration: const InputDecoration(
                  labelText: 'Contato (WhatsApp, e-mail...)',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.dataFimController,
                decoration: const InputDecoration(
                  labelText: 'Data de término (yyyyMMdd)',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _pickEndDate,
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
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
