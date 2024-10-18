import 'package:actividad_02/modules/auth/screens/validar_contrasena.dart';
import 'package:flutter/material.dart';

class RecuperarContrasena extends StatefulWidget {
  const RecuperarContrasena({super.key});

  @override
  State<RecuperarContrasena> createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo';
    }
    String emailPattern = r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/528/528111.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  TextFormField(
                    validator: _validateEmail,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Correo Electrónico',
                      label: Text('Correo Electrónico'),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ValidarCodigo(),
                              ),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 134, 10, 10),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Enviar Codigo'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ValidarCodigo(), 
                          ),
                        );
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
