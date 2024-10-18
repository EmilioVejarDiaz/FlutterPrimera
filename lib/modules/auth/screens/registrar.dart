import 'package:actividad_02/kernel/widgets/custom_text_field_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  @override
  State<Registrarse> createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  Future<void> _registrarUsuario() async {
    if (_formKey.currentState?.validate() == true) {
      if (_password.text != _confirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Registro exitoso!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'email-already-in-use') {
          message = 'El correo ya está en uso.';
        } else if (e.code == 'invalid-email') {
          message = 'El correo electrónico no es válido.';
        } else if (e.code == 'weak-password') {
          message = 'La contraseña es muy débil.';
        } else {
          message = 'Error al registrarse: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ocurrió un error inesperado: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://raw.githubusercontent.com/vishans/Nintendo-Switch-Profile-Icons-Avatars/refs/heads/main/avatars/2fbce2e8ec5a0eea573c35f4cb6b4119ad2eeb99b7af7ed113d3936a74a0b2d7.png',
                  width: 200,
                  height: 200,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Correo electrónico',
                          labelText: 'Correo electrónico',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo electrónico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFieldPassword(
                        controller: _password,
                        hintText: 'Contraseña',
                        labelText: 'Contraseña',
                      ),
                      const SizedBox(height: 16),
                      TextFieldPassword(
                        controller: _confirmPassword,
                        hintText: 'Confirmar contraseña',
                        labelText: 'Confirmar contraseña',
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _registrarUsuario,
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 134, 10, 10),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('Crear cuenta'),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
