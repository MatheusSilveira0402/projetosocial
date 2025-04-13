import 'package:flutter/widgets.dart';
import 'package:projetosocial/app/core/env.dart';
import 'package:supabase/supabase.dart';
import '../models/campaign_model.dart';

class CampaignService {
  final _client = SupabaseClient(
    Env.supabaseUrl,
    Env.supabaseAnonKey
  );

  /// Salva uma nova campanha no Supabase
  Future<CampaignModel?> salvarCampanha(CampaignModel campanha) async {
    try {
      final response = await _client
          .from('campanhas')
          .insert(campanha.toMap())
          .select()
          .maybeSingle();

      if (response == null) return null;
      return CampaignModel.fromMap(response);
    } catch (e, stack) {
      debugPrint("Erro ao salvar campanha: $e \nStack: $stack");
      return null;
    }
  }

  /// Busca todas as campanhas cadastradas
  Future<List<CampaignModel>> buscarCampanhas() async {
    try {
      final response = await _client
          .from('campanhas')
          .select()
          .order('datafim', ascending: true);

      return (response as List)
          .map((map) => CampaignModel.fromMap(map))
          .toList();
    } catch (e, stack) {
      debugPrint("Erro ao buscar campanhas: $e \nStack: $stack");
      return [];
    }
  }
}
