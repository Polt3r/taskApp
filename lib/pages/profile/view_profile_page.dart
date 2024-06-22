import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../api/get_user.dart';
import '/components/my_photo.dart';
import '../../components/my_appbar.dart';
import '../../components/my_dash.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController emailController;
  String nickName = 'Apelido';
  String userName = 'Nome';
  String userEmail = 'Email';
  
  get userData => null;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userData = await getUserData();
    setState(() {
      nickName = userData['UsuarioApelido'] ?? 'No user data';
      userName = userData['UsuarioNome'] ?? 'No user data';
      userEmail = userData['UsuarioEmail'] ?? 'No user data';
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: buildAppBar(context, Icons.logout),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          MyPhoto(
            imagePath: "user?.foto",
            onClicked: () async {
              // Função ao clicar na foto
            },
          ),
          const SizedBox(height: 24),
          buildDisplayFields(),
          const SizedBox(height: 24),
          MyDash(), // Condicional para esconder MyDash
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildDisplayFields() {
    return Column(
      children: [
        Text(
          nickName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          userEmail,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SpeedDial(
              backgroundColor: Colors.black,
              overlayColor: Colors.black,
              overlayOpacity: 0.2,
              animatedIcon: AnimatedIcons.menu_close,
              spacing: 16,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.delete, color: Colors.white),
                  backgroundColor: Colors.red.shade300,
                  label: 'Excluir Conta',
                ),
                SpeedDialChild(
                  child: const Icon(Icons.logout),
                  label: 'Sair',
                ),
                SpeedDialChild(
                  child: const Icon(Icons.lock),
                  label: 'Altera Senha',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
