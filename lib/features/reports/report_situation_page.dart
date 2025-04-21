import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'report_service.dart';

class ReportSituationPage extends StatefulWidget {
  const ReportSituationPage({super.key});

  @override
  State<ReportSituationPage> createState() => _ReportSituationPageState();
}

class _ReportSituationPageState extends State<ReportSituationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  File? _selectedImage;
  String? _base64Image;
  bool _loading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      final cleanedBase64 = base64Encode(
        bytes,
      ).replaceAll('\n', '').replaceAll('\r', '');
      setState(() {
        _selectedImage = File(picked.path);
        _base64Image = cleanedBase64;
      });
    }
  }

  Future<void> _guardarImagenLocal(String codigo) async {
    if (_selectedImage == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/imagen_$codigo.jpg';
    await _selectedImage!.copy(path);
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _base64Image != null) {
      setState(() => _loading = true);

      final data = await ReportService.reportSituation(
        titulo: _titleController.text,
        descripcion: _descriptionController.text,
        fotoBase64: _base64Image!,
        latitud: _latController.text,
        longitud: _lngController.text,
      );

      setState(() => _loading = false);

      final success = data['exito'] == true;
      final message = data['mensaje'] ?? 'Error desconocido';

      if (success && data['codigo'] != null) {
        final codigo = data['codigo'].toString();
        await _guardarImagenLocal(codigo);
      }

      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('✅ $message')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('⚠️ $message')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Situación'),
        backgroundColor: Colors.deepOrange,
        elevation: 8,
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'El título es requerido'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'La descripción es requerida'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _latController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Latitud',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'La latitud es requerida'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _lngController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Longitud',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty
                                    ? 'La longitud es requerida'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Text('Seleccionar Foto'),
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.deepOrange,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      if (_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(_selectedImage!, height: 150),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.send),
                        label: const Text('Enviar Reporte'),
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
