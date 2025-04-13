import 'package:projetosocial/app/core/env.dart';
import 'package:supabase/supabase.dart';

import '../models/usuario_model.dart';

class UsuarioService {
  final _client = SupabaseClient(
    Env.supabaseUrl,
    Env.supabaseAnonKey
  );

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

  Future<UsuarioModel?> registrar(UsuarioModel usuario) async {
  final novoUsuario = usuario;

  final response = await _client
      .from('usuarios')
      .insert(novoUsuario.toMap())
      .select()
      .maybeSingle();

  if (response == null) return null;
  return UsuarioModel.fromMap(response);
}

  Future<void> logout() async {
    // logout local apenas
  }
}
