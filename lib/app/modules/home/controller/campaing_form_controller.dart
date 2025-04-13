import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/home/models/campaign_model.dart';
import 'package:projetosocial/app/modules/home/provider/campaign_provider.dart';
import 'package:uuid/uuid.dart';

class CampaingFormController {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final tipoDoacaoController = TextEditingController();
  final localEntrega = TextEditingController();
  final contatos = TextEditingController();
  final dataFimController = TextEditingController();

  String? dataFimRaw;

  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    tipoDoacaoController.dispose();
    localEntrega.dispose();
    contatos.dispose();
    dataFimController.dispose();
  }

  final CampaignProvider _campanhaProvider = Modular.get<CampaignProvider>();


  Future<bool> salvarCampanha() async {
    final campanhaModel = CampaignModel(
      id: Uuid().v4(),
      titulo: tituloController.text,
      descricao: descricaoController.text,
      tiposDoacao: tipoDoacaoController.text,
      localEntrega: localEntrega.text,
      contato: contatos.text,
      dataFim: dataFimController.text,
    );

    try {
      final sucesso = await _campanhaProvider.criarCampanha(campanhaModel);
      if (sucesso == null) return false;
      return true;
    } catch (e) {
      // Trate o erro conforme necessário
      return false;
    }
  }
}
