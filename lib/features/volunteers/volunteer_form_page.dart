import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'volunteer_service.dart';

class VolunteerFormPage extends StatefulWidget {
  const VolunteerFormPage({super.key});

  @override
  State<VolunteerFormPage> createState() => _VolunteerFormPageState();
}

class _VolunteerFormPageState extends State<VolunteerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final success = await VolunteerService.registerVolunteer(
        cedula: cedulaController.text,
        nombre: nombreController.text,
        apellido: apellidoController.text,
        correo: correoController.text,
        telefono: telefonoController.text,
        password: passwordController.text,
      );

      setState(() => _loading = false);

      final message =
          success ? 'Registro exitoso' : 'Hubo un problema al registrar';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));

      if (success) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Voluntario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _loading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: cedulaController,
                        decoration: const InputDecoration(labelText: 'Cédula'),
                        validator: _required,
                      ),
                      TextFormField(
                        controller: nombreController,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        validator: _required,
                      ),
                      TextFormField(
                        controller: apellidoController,
                        decoration: const InputDecoration(
                          labelText: 'Apellido',
                        ),
                        validator: _required,
                      ),
                      TextFormField(
                        controller: correoController,
                        decoration: const InputDecoration(labelText: 'Correo'),
                        validator: _required,
                      ),
                      TextFormField(
                        controller: telefonoController,
                        decoration: const InputDecoration(
                          labelText: 'Teléfono',
                        ),
                        validator: _required,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                        ),
                        obscureText: true,
                        validator: _required,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Enviar solicitud'),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  String? _required(String? value) =>
      (value == null || value.isEmpty) ? 'Este campo es requerido' : null;
}
