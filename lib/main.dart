import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_dio_flutter/calcular_imc.dart';
import 'package:imc_dio_flutter/imc_list_page.dart';
import 'package:imc_dio_flutter/models/imc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IMC - Flutter Dio com Hive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double? resultado;
  late Box<Imc> imcBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ImcAdapter());
    }

    imcBox = await Hive.openBox<Imc>('imcBox');
  }

  Future<void> calcular() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    Imc imc = Imc(
        altura: double.parse(alturaController.text),
        peso: double.parse(pesoController.text));

    imc.resultado = calcularImc(imc.peso, imc.altura);
    imcBox.add(imc);

    setState(() {
      resultado = imc.resultado!;
    });
  }

  String? validate(String? value, {bool ehPeso = false}) {
    if (value == null || value.isEmpty) {
      return 'Informe o valor do campo';
    }

    if (ehPeso == false && double.parse(value) > 3) {
      return 'Informe uma altura valida';
    }

    return null;
  }

  Future<void> onPressed() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ImcListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) => validate(value, ehPeso: true),
                  controller: pesoController,
                  decoration: const InputDecoration(hintText: 'Informe o peso'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) => validate(value),
                  controller: alturaController,
                  decoration:
                      const InputDecoration(hintText: 'Informe a altura'),
                ),
                const SizedBox(height: 16),
                if (resultado != null)
                  Text(
                    'Resultado : $resultado',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                if (resultado != null) const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: calcular,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular IMC'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.menu),
                  label: const Text('Resultados armazenados'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
