import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/auth/auth_module.dart';
import 'package:projetosocial/app/modules/home/home_module.dart';


class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}