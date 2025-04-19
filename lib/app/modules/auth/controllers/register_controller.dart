import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/auth/models/usuario_model.dart';
import 'package:projetosocial/app/modules/auth/providers/usuario_provider.dart';
import 'package:uuid/uuid.dart';

class RegisterController {
  final UsuarioProvider _usuarioProvider = Modular.get<UsuarioProvider>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final telefoneController = TextEditingController();
  final tipoController = TextEditingController();
  String erroString = "";

  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    telefoneController.dispose();
    tipoController.dispose();
  }

  Future<bool> registrar() async {
    final novoUsuario = UsuarioModel(
      id: Uuid().v4(),
      nome: nomeController.text.trim(),
      email: emailController.text.trim(),
      senha: senhaController.text.trim(),
      telefone: telefoneController.text.trim(),
    );

    final erro = await _usuarioProvider.registrar(novoUsuario);
    erroString = erro ?? '';
    return erro == null;
  }
}
