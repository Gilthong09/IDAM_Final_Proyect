import 'package:flutter/material.dart';
import 'volunteer_form_page.dart';

class RequirementsPage extends StatelessWidget {
  const RequirementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Requisitos para ser voluntario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Para ser voluntario necesitas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Ser mayor de edad\n- Tener disposición para ayudar\n- Participar en actividades comunitarias\n- Completar el formulario',
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VolunteerFormPage(),
                    ),
                  );
                },
                child: const Text('Quiero ser voluntario'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
