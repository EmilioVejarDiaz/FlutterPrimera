import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              onPressed: () async {
                // Cerrar sesión
                await FirebaseAuth.instance.signOut();
                // Navegar a la pantalla de inicio de sesión si el widget sigue montado
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: const Text('Cerrar sesión'),
            ),
          ),
        ],
      ),
    );
  }
}