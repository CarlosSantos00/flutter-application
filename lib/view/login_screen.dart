import 'package:flutter/material.dart';
import 'package:meuapp/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logotipo_firma.png",
                  width: MediaQuery.sizeOf(context).width * 0.5),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email obrigatório";
                  }
                  return null;
                },
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Insira seu email"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Senha obrigatória";
                  }
                  return null;
                },
                maxLength: 10,
                decoration: const InputDecoration(hintText: "Insira sua senha"),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 48,
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text("Entrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
