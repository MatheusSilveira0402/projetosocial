import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/auth/pages/login_pages.dart';
import 'package:projetosocial/app/modules/auth/pages/register_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const LoginPage());
    r.child('/register', child: (_) => const RegisterPage());
  }
}