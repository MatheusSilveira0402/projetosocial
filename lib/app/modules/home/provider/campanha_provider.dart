import 'package:flutter/material.dart';
import 'package:projetosocial/app/modules/home/models/campanha_model.dart';
import 'package:projetosocial/app/modules/home/service/campanha_service.dart';

class CampanhaProvider with ChangeNotifier {
  final CampanhaService _service = CampanhaService();

  List<CampanhaModel> _campanhas = [];
  bool _loading = false;
  String? _error;

  List<CampanhaModel> get campanhas => _campanhas;
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
  Future<CampanhaModel?> criarCampanha(CampanhaModel campanha) async {
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
