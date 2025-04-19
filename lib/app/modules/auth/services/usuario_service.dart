import 'package:flutter/cupertino.dart';
import 'package:projetosocial/app/core/env.dart';
import 'package:projetosocial/app/modules/auth/controllers/register_controller.dart';
import 'package:supabase/supabase.dart';

import '../models/usuario_model.dart';

class UsuarioService {
  final _client = SupabaseClient(Env.supabaseUrl, Env.supabaseAnonKey);
  final controller = RegisterController();

  Future<UsuarioModel?> login(String email, String senha) async {
    final response =
        await _client
            .from('usuarios')
            .select()
            .eq('email', email)
            .eq('senha', senha)
            .maybeSingle();

    if (response == null) return null;
    return UsuarioModel.fromMap(response);
  }

  Future<String?> registrar(UsuarioModel usuario) async {
    try {
      final response =
          await _client.from('usuarios').insert(usuario.toMap()).select().maybeSingle();

      if (response == null) return 'Erro ao registrar usuário.';

      return null; // sucesso
    } catch (e) {
      if (e is PostgrestException && e.code == '409') {
        return 'Este e-mail já está cadastrado.';
      }
      return 'Erro inesperado. Tente novamente.';
    }
  }

  Future<void> logout() async {
    // logout local apenas
  }
}
