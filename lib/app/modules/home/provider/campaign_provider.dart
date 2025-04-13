import 'package:flutter/material.dart';
import 'package:projetosocial/app/modules/home/models/campaign_model.dart';
import 'package:projetosocial/app/modules/home/service/campaign_service.dart';

class CampaignProvider with ChangeNotifier {
  final CampaignService _service = CampaignService();

  List<CampaignModel> _campanhas = [];
  bool _loading = false;
  String? _error;

  List<CampaignModel> get campanhas => _campanhas;
  bool get loading => _loading;
  String? get error => _error;

  /// Buscar campanhas
  Future<void> fetchCampanhas() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final resultado = await _service.buscarCampanhas();
      _campanhas = resultado;
    } catch (e) {
      _error = 'Erro ao buscar campanhas: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Criar nova campanha
  Future<CampaignModel?> criarCampanha(CampaignModel campanha) async {
    try {
      final novaCampanha = await _service.salvarCampanha(campanha);
      if (novaCampanha != null) {
        _campanhas.add(novaCampanha);
        notifyListeners();
      }
      return novaCampanha;
    } catch (e) {
      _error = 'Erro ao criar campanha: $e';
      notifyListeners();
      return null;
    }
  }
}
