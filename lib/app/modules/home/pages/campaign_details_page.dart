import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignDetailsPage extends StatelessWidget {
  const CampaignDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final doc = Modular.args.data as DocumentSnapshot;

    final data = doc.data() as Map<String, dynamic>;

    final title = data['title'] ?? '';
    final description = data['description'] ?? '';
    final types = (data['donationTypes'] as List<dynamic>).join(', ');
    final location = data['dropOffLocation'] ?? '';
    final contact = data['contact'] ?? '';
    final endDate = DateTime.tryParse(data['endDate'])?.toLocal().toString().split(' ').first ?? '';

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
                  final url = Uri.parse('https://wa.me/${contact.replaceAll(RegExp(r'[^0-9]'), '')}');
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
