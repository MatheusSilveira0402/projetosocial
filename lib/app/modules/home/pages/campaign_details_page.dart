import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CampaignDetailsPage extends StatelessWidget {
  const CampaignDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Agora usamos um Map direto, sem Firebase
    final data = Modular.args.data as Map<String, dynamic>;

    final title = data['title'] ?? '';
    final description = data['description'] ?? '';
    final types = (data['donationTypes'] as List<dynamic>).join(', ');
    final location = data['dropOffLocation'] ?? '';
    final contact = data['contact'] ?? '';
    final endDate = data['endDate'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Campanha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Descrição:', style: Theme.of(context).textTheme.titleMedium),
            Text(description),
            const SizedBox(height: 12),
            Text('Tipos de doação:', style: Theme.of(context).textTheme.titleMedium),
            Text(types),
            const SizedBox(height: 12),
            Text('Local de entrega:', style: Theme.of(context).textTheme.titleMedium),
            Text(location),
            const SizedBox(height: 12),
            Text('Prazo para doações:', style: Theme.of(context).textTheme.titleMedium),
            Text(endDate),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final cleanNumber = contact.replaceAll(RegExp(r'[^0-9]'), '');
                  final url = Uri.parse('https://wa.me/$cleanNumber');
                  Modular.to.pushNamed('/open', arguments: url);
                },
                icon: const Icon(Icons.phone),
                label: const Text('Entrar em contato'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
