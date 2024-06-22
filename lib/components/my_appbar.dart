import 'package:flutter/material.dart';

import '../api/auth.dart';
import '../api/logout.dart';

AppBar buildAppBar(BuildContext context, IconData actionIcon) {
  return AppBar(
    leading: BackButton(
      color: Colors.black,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(
          actionIcon,
          color: Colors.black,
        ),
        onPressed: () async {
          if (actionIcon == Icons.logout) {
            var token = await getToken();
            await logoutUser(token: token);
            Navigator.pushNamed(context, '/Login');
          } else {
            Navigator.pop(context);
          }
          // Adicione a ação desejada aqui
        },
      ),
    ],
  );
}
