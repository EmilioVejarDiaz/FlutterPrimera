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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  '',
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
                      // Usando el widget TextFieldPassword para la contraseña
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
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: _email.text,
                                password: _password.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('¡Inicio de sesión exitoso!')),
                              );
                            } on FirebaseAuthException catch (e) {
                              String message = '';
                              if (e.code == 'user-not-found') {
                                message =
                                    'No existe ningún usuario con ese correo.';
                              } else if (e.code == 'wrong-password') {
                                message = 'La contraseña es incorrecta.';
                              } else {
                                message =
                                    'Error al iniciar sesión: ${e.message}';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Ocurrió un error inesperado: $e')),
                              );
                            }
                          },
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
