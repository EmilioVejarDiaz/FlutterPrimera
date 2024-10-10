import 'package:actividad_02/modules/auth/screens/login.dart';
import 'package:actividad_02/modules/auth/screens/nueva_contrasena.dart';
import 'package:actividad_02/modules/auth/screens/recuperar_contrase%C3%B1a.dart';
import 'package:actividad_02/modules/auth/screens/validar_contrasena.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/recuperar': (context) => const RecuperarContrasena(),
        '/validar': (context) => const ValidarCodigo(),
        '/nuevaContraseña': (context) => const NuevaContrasena(),
      },
      
    );
  }
}