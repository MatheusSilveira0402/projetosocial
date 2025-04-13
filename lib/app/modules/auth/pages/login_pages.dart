import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/core/extension_size.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final controller = LoginController();
  bool _loading = false;

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final sucesso = await controller.login();

    setState(() => _loading = false);

    if (sucesso) {
      Modular.to.navigate('/home/');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('E-mail ou senha inválidos')));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(10),
          width: context.widthPct(1),
          height: context.heightPct(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              SizedBox(
                width: context.widthPct(0.8),
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Informe o e-mail' : null,
                ),
              ),
              SizedBox(
                width: context.widthPct(0.8),
                child: TextFormField(
                  controller: controller.senhaController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Informe a senha' : null,
                ),
              ),
              _loading
                  ? SizedBox(width: 30, height: 30, child: CircularProgressIndicator())
                  : SizedBox(
                    width: context.widthPct(0.8),
                    child: ElevatedButton(onPressed: _login, child: const Text('Entrar')),
                  ),
              TextButton(
                onPressed: () => Modular.to.pushNamed('/register'),
                child: const Text('Criar conta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
