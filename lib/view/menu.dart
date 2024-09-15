import 'package:flutter/material.dart';
import 'package:meuapp/view/feriados.screen.dart';
import 'package:meuapp/view/home_screen.dart';
import 'package:meuapp/view/login_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Cursos"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Feriados"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FeriadosScreen(ano: DateTime.now().year),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          )
        ],
      ),
    );
  }
}
