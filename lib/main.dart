import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/login/login_page.dart';
import 'pages/login/register_page.dart';
import 'pages/profile/view_profile_page.dart';
import 'pages/task/new_task_page.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Contatos',
      initialRoute: '/Login',
      routes: {
        // Adicione a tela de login
        '/Home': (context) => const HomePage(),
        '/NewTask': (context) => NewTask(),
        '/Login': (context) => TelaLogin(), // Adicione a tela de login
        '/Register': (context) =>
            RegisterPage(), // Adicione a tela de logi // Adicione a tela de login
        '/Profile': (context) =>
            const ProfilePage(), // Adicione a tela de login
        //'/teste': (context) => MyHomePage(), // Adicione a tela de login
      },
    );
  }
}
