import 'package:flutter/material.dart';
import 'change_password_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  bool _loading = false;

  Future<void> _handleChangePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      try {
        final result = await ChangePasswordService.changePassword(
          oldPassword: _oldController.text.trim(),
          newPassword: _newController.text.trim(),
        );

        final success = result['exito'] == true;
        final message = result['mensaje'] ?? 'Error desconocido';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? '✅ $message' : '⚠️ $message'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );

        if (success) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Error: $e')));
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cambiar Contraseña')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _oldController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña actual',
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _newController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Nueva contraseña',
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Requerido';
                          if (val.length < 6) return 'Mínimo 6 caracteres';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _handleChangePassword,
                        icon: const Icon(Icons.lock_reset),
                        label: const Text('Cambiar Contraseña'),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
