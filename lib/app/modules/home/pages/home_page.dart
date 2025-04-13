import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/home/provider/campaign_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CampaignProvider campanhaProvider;

  @override
  void initState() {
    super.initState();
    campanhaProvider = context.read<CampaignProvider>();
    campanhaProvider.fetchCampanhas(); // Carrega campanhas ao iniciar
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampaignProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campanhas Ativas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Modular.to.navigate('/'),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final campanhas = provider.campanhas;

          if (campanhas.isEmpty) {
            return const Center(child: Text('Nenhuma campanha encontrada.'));
          }

          return ListView.builder(
            itemCount: campanhas.length,
            itemBuilder: (context, index) {
              final data = campanhas[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(data.titulo, style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Local: ${data.localEntrega}', style: Theme.of(context).textTheme.bodySmall),
                      Text('Doações: ${data.tiposDoacao}', style: Theme.of(context).textTheme.bodySmall),
                      Text('Até: ${data.dataFim}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => Modular.to.pushNamed('/home/details', arguments: data),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/home/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
