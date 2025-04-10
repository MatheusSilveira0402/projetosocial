import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final campaignsRef = FirebaseFirestore.instance
        .collection('campaigns')
        .orderBy('endDate');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campanhas Ativas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Modular.to.navigate('/');
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: campaignsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text('Nenhuma campanha cadastrada.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(data['title'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Local: ${data['dropOffLocation'] ?? '---'}'),
                      Text('Doações: ${(data['donationTypes'] as List<dynamic>).join(', ')}'),
                      Text('Até: ${DateTime.tryParse(data['endDate'])?.toLocal().toString().split(' ').first ?? '---'}'),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Modular.to.pushNamed('/home/details', arguments: docs[index]);
                  },
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
