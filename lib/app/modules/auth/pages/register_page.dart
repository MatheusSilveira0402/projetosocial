import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/core/extension_size.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final controller = RegisterController();
  bool _loading = false;

  Future<void> _register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final sucesso = await controller.registrar();

    setState(() => _loading = false);

    if (sucesso) {
      Modular.to.navigate('/home/');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao criar conta')));
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
      appBar: AppBar(title: const Text('Criar conta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: context.widthPct(1),
            child: Column(
              spacing: 20.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: context.widthPct(0.8),
                  child: TextFormField(
                    controller: controller.nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    validator:
                        (value) => value == null || value.isEmpty ? 'Informe o nome' : null,
                  ),
                ),
                SizedBox(
                  width: context.widthPct(0.8),
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        (value) => value == null || value.isEmpty ? 'Informe o e-mail' : null,
                  ),
                ),
                SizedBox(
                  width: context.widthPct(0.8),
                  child: TextFormField(
                    controller: controller.senhaController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    validator:
                        (value) => value == null || value.isEmpty ? 'Informe a senha' : null,
                  ),
                ),
                SizedBox(
                  width: context.widthPct(0.8),
                  child: TextFormField(
                    controller: controller.telefoneController,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                    ),
                    keyboardType: TextInputType.phone,
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? 'Informe o telefone' : null,
                  ),
                ),
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                      width: context.widthPct(0.8),
                      child: ElevatedButton(
                        onPressed: _register,
                        child: const Text('Criar conta'),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
