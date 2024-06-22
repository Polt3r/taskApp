import 'package:flutter/material.dart';

import '../../api/register_user.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  // text controllers
  final nicknameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),

                //logo
                const Text(
                  'TASKS',
                  style: TextStyle(
                    //color: Color(0xff000000),
                    fontSize: 32,
                    letterSpacing: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 10),

                //register to access the app
                const Text(
                  'Cadastre-se para ter acesso a ferramenta',
                  style: TextStyle(
                    //color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 45),

                //text filed username
                MyTextField(
                  controller: nicknameController,
                  hintText: 'Como deseja ser chamado(a)?',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //text Name
                MyTextField(
                  controller: usernameController,
                  hintText: 'Nome Completo',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //text Email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //text Senha
                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //text Confirmar Senha
                MyTextField(
                  controller: cpasswordController,
                  hintText: 'Confirmar Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //sing in button
                MyButton(
                    textLabel: "CRIAR CONTA",
                    onTap: () async {
                      if (passwordController.text == cpasswordController.text) {
                        try {
                          await cadastrarUsuario(
                            apelido: nicknameController.text,
                            nome: usernameController.text,
                            email: emailController.text,
                            senha: passwordController.text,
                          );
                          Navigator.pushNamed(context, '/Home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Falha ao cadastrar usuário: $e'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('As senhas não coincidem!'),
                        ));
                      }
                    }),

                const SizedBox(height: 15),

                //not a member? Register now
                InkWell(
                  child: const Text(
                    "Já tem uma conta? Faça login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () => {Navigator.pushNamed(context, '/Login')},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
