import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/core/extension_size.dart';
import 'package:projetosocial/app/modules/home/models/campaign_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CampaignDetailsPage extends StatelessWidget {
  const CampaignDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CampaignModel data = Modular.args.data;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Campanha')),
      body: Container(
        margin: EdgeInsets.all(10),
        width: context.widthPct(1),
        height: context.heightPct(1),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(
              width: context.widthPct(1),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      Text(data.titulo, style: Theme.of(context).textTheme.titleLarge),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrição:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(data.descricao),
                        ],
                      ),
                  
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tipos de doação:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(data.tiposDoacao),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Local de entrega:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(data.localEntrega),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prazo para doações:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(data.dataFim),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: context.widthPct(0.9),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final cleanNumber = data.contato;
                    final url = Uri.parse('https://wa.me/$cleanNumber');
                    try {
                      await canLaunchUrl(url);
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } catch (e, stack) {
                      debugPrint("Erro: $e. Stack: $stack");
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Não foi possível abrir o WhatsApp')),
                      );
                    }
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Entrar em contato'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
