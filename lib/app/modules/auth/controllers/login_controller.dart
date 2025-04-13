import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/auth/providers/usuario_provider.dart';

class LoginController {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final UsuarioProvider _usuarioProvider = Modular.get<UsuarioProvider>();

  Future<bool> login() async {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) return false;

    return await _usuarioProvider.login(email, senha);
  }

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
  }
}
