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
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF3E0), Color(0xFFFFCCBC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white.withOpacity(0.95),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: 'Título',
                                prefixIcon: const Icon(Icons.title),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'El título es requerido'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Descripción',
                                prefixIcon: const Icon(Icons.description),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'La descripción es requerida'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _latController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: 'Latitud',
                                prefixIcon: const Icon(Icons.place),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'La latitud es requerida'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _lngController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: 'Longitud',
                                prefixIcon: const Icon(Icons.place_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'La longitud es requerida'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.image),
                              label: const Text('Seleccionar Foto'),
                              onPressed: _pickImage,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Colors.deepOrangeAccent,
                                textStyle: const TextStyle(fontSize: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            if (_selectedImage != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(_selectedImage!, height: 160),
                                ),
                              ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.send),
                              label: const Text('Enviar Reporte'),
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Colors.green,
                                textStyle: const TextStyle(fontSize: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
