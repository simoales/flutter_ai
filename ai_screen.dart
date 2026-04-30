import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  File? _immagine;
  String _risultato = '';
  final _picker = ImagePicker();

  Future getImmagine(ImageSource sorgente) async {
    try {
      final fileSelezionato = await _picker.pickImage(source: sorgente);
      setState(() {
        if (fileSelezionato != null) {
          _immagine = File(fileSelezionato.path);
        }
      });
    } on Exception catch (_) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker e IA')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (_immagine != null)
              Image.file(_immagine!, height: 200, width: 200),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => getImmagine(ImageSource.camera),
                  child: const Text('Scatta una foto'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => getImmagine(ImageSource.gallery),
                  child: const Text('Scegli dalla galleria'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Analizza Immagine'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_risultato.isNotEmpty)
              Text(
                'Result:\n$_risultato',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
