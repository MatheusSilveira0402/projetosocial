import 'package:projetosocial/app/core/env.dart';
import 'package:supabase/supabase.dart';
import '../models/campanha_model.dart';

class CampanhaService {
  final _client = SupabaseClient(
    Env.supabaseUrl,
    Env.supabaseAnonKey
  );

  /// Salva uma nova campanha no Supabase
  Future<CampanhaModel?> salvarCampanha(CampanhaModel campanha) async {
    try {
      final response = await _client
          .from('campanhas')
          .insert(campanha.toMap())
          .select()
          .maybeSingle();

      if (response == null) return null;
      return CampanhaModel.fromMap(response);
    } catch (e, stack) {
      print("Erro ao salvar campanha: $e \nStack: $stack");
      return null;
    }
  }

  /// Busca todas as campanhas cadastradas
  Future<List<CampanhaModel>> buscarCampanhas() async {
    try {
      final response = await _client
          .from('campanhas')
          .select()
          .order('datafim', ascending: true);

      return (response as List)
          .map((map) => CampanhaModel.fromMap(map))
          .toList();
    } catch (e, stack) {
      print("Erro ao buscar campanhas: $e \nStack: $stack");
      return [];
    }
  }
}
