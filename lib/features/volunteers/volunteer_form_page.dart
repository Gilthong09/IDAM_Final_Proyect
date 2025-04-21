import 'package:flutter/material.dart';
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

  Color get primaryColor => Colors.deepOrange; // Color principal para los textos y botones

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
      //-------------------------------------------------

      //-------------------------------------------------

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
      appBar: AppBar(
        title: const Text(
          'Formulario de Voluntario',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Negrita
            fontSize: 22,
          ),
        ),
        backgroundColor: primaryColor.withOpacity(0.95),
        elevation: 10,
        shadowColor: Colors.deepOrangeAccent,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(
                      controller: cedulaController,
                      label: 'Cédula',
                    ),
                    _buildTextField(
                      controller: nombreController,
                      label: 'Nombre',
                    ),
                    _buildTextField(
                      controller: apellidoController,
                      label: 'Apellido',
                    ),
                    _buildTextField(
                      controller: correoController,
                      label: 'Correo',
                    ),
                    _buildTextField(
                      controller: telefonoController,
                      label: 'Teléfono',
                    ),
                    _buildTextField(
                      controller: passwordController,
                      label: 'Contraseña',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, // Usamos backgroundColor
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // Bordes más suaves
                        ),
                      ),
                      child: const Text(
                        'Enviar solicitud',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // Texto blanco
                          fontWeight: FontWeight.bold, // Negrita
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  TextFormField _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: primaryColor, // Color del texto del label
          fontWeight: FontWeight.bold, // Hacer el label en negrita
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Espaciado más amplio entre label y campo
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      obscureText: obscureText,
      validator: _required,
    );
  }

  String? _required(String? value) =>
      (value == null || value.isEmpty) ? 'Este campo es requerido' : null;
}
