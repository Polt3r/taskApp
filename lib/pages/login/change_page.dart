import 'package:flutter/material.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';

class ChangePage extends StatelessWidget {
  ChangePage({super.key});
  // text controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //method login
  void singUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      body: SafeArea(
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
                'Nova senha',
                style: TextStyle(
                  //color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 45),

              //text filed username
              MyTextField(
                controller: usernameController,
                hintText: 'Senha anterior',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              //text Name
              MyTextField(
                controller: passwordController,
                hintText: 'Nova Senha',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              //text Email
              MyTextField(
                controller: passwordController,
                hintText: 'Confirmar Senha',
                obscureText: true,
              ),

              const SizedBox(height: 180),

              //sing in button
              MyButton(
                textLabel: "ALTERAR SENHA",
                onTap: () => {Navigator.pushNamed(context, '/Login')},
              ),

              const SizedBox(height: 15),

              //not a member? Register now
              const Text(
                'Não tem uma conta? Cadastre-se',
                style: TextStyle(
                  //color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
