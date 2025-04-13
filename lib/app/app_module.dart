import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/auth/auth_module.dart';
import 'package:projetosocial/app/modules/home/home_module.dart';
import 'package:projetosocial/app/modules/auth/providers/usuario_provider.dart';
import 'package:projetosocial/app/modules/home/provider/campaign_provider.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<UsuarioProvider>(() => UsuarioProvider());
    i.addSingleton<CampaignProvider>(() => CampaignProvider());
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
