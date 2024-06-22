import 'package:flutter/material.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';

class CodePage extends StatelessWidget {
  CodePage({super.key});
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

              //welcome back, you've been missed!
              const Text(
                'Verifica codigo',
                style: TextStyle(
                  //color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 45),

              //text filed email
              MyTextField(
                controller: usernameController,
                hintText: 'Código',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'Informe o codigo recebido por email para recuperar a conta.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 280),

              //sing in button
              MyButton(
                textLabel: "VERIFICAR",
                onTap: () => {Navigator.pushNamed(context, '/Change')},
              ),

              const SizedBox(height: 15),

              //not a member? Register now
              InkWell(
                child: const Text(
                  "Desistir do processo? Faça login",
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
    );
  }
}
