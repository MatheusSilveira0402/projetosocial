import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/home/models/campaign_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CampaignDetailsPage extends StatelessWidget {
  const CampaignDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Agora usamos um Map direto, sem Firebase
    CampaignModel data = Modular.args.data;

    final title = data.titulo;
    final description = data.descricao;
    final types = data.tiposDoacao;
    final location = data.localEntrega;
    final contact = data.contato;
    final endDate = data.dataFim;

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
                onPressed: () async {
                  final cleanNumber = contact;
                  final url = Uri.parse('https://wa.me/$cleanNumber');
                  try {
                    await canLaunchUrl(url);
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e, stack) {
                    debugPrint("Erro: $e. Stack: $stack");
                    if (!context.mounted)  return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Não foi possível abrir o WhatsApp')),
                    );
                  }
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
