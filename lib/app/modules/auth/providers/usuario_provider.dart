import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/usuario_service.dart';

class UsuarioProvider with ChangeNotifier {
  final UsuarioService _service = UsuarioService();

  UsuarioModel? _usuarioLogado;

  UsuarioModel? get usuarioLogado => _usuarioLogado;

  Future<bool> login(String email, String senha) async {
    final user = await _service.login(email, senha);
    if (user == null) return false;
    _usuarioLogado = user;
    notifyListeners();
    return true;
  }

  Future<bool> registrar(UsuarioModel usuario) async {
    try {
      final user = await _service.registrar(usuario);
      if (user == null) return false;
    _usuarioLogado = user;
    } catch (e) {
      return false;
    }
    
    
    notifyListeners();
    return true;
  }

  void logout() {
    _usuarioLogado = null;
    notifyListeners();
  }
}
