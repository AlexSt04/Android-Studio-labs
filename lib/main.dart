import 'package:flutter/material.dart';

void main() {
  runApp(const ImcApp());
}

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ImcScreen(),
    );
  }
}

class ImcScreen extends StatefulWidget {
  const ImcScreen({super.key});

  @override
  State<ImcScreen> createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _result = '';
  Color _resultColor = Colors.black;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    // Înlocuim virgula cu punct, ca să accepte și "70,5"
    final weight =
    double.tryParse(_weightController.text.replaceAll(',', '.'));
    final heightCm =
    double.tryParse(_heightController.text.replaceAll(',', '.'));

    // Validare
    if (weight == null || heightCm == null || weight <= 0 || heightCm <= 0) {
      setState(() {
        _result = 'Introduceți valori valide (numere pozitive).';
        _resultColor = Colors.red;
      });
      return;
    }

    final heightM = heightCm / 100;
    final bmi = weight / (heightM * heightM);

    String category;
    Color color;

    if (bmi < 18.5) {
      category = 'Subponderal';
      color = Colors.blue;
    } else if (bmi < 25) {
      category = 'Normal';
      color = Colors.green;
    } else if (bmi < 30) {
      category = 'Supraponderal';
      color = Colors.orange;
    } else {
      category = 'Obezitate';
      color = Colors.red;
    }

    setState(() {
      _result = 'IMC: ${bmi.toStringAsFixed(1)}\nCategorie: $category';
      _resultColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator IMC'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Greutate (kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Înălțime (cm)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _calculateBmi,
                child: const Text(
                  'Calculează',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _resultColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}