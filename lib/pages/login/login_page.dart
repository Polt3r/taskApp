import 'package:flutter/material.dart';

import '../../api/auth.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    try {
      await authenticateAndStoreToken(
          usernameController.text, passwordController.text);
      Navigator.pushReplacementNamed(context, '/Home');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro de autenticação: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Logo
              const Text(
                'TASKS',
                style: TextStyle(
                  fontSize: 32,
                  letterSpacing: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 10),

              // Welcome text
              const Text(
                'Faça login para acessar suas tarefas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 45),

              // Text field email
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              // Text field password
              MyTextField(
                controller: passwordController,
                hintText: 'Senha',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: const Text(
                        "Esqueceu a senha?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/Forgot'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 120),

              // Sign in button
              MyButton(
                textLabel: "LOGIN",
                onTap: () => _login(context),
              ),

              const SizedBox(height: 15),

              // Not a member? Register now
              InkWell(
                child: const Text(
                  "Não tem uma conta? Cadastre-se",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
