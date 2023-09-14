import 'package:flutter/material.dart';
import 'package:imc_dio_flutter/imc.dart';

void main() {
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
      home: const MyHomePage(title: 'IMC - Flutter Dio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController pesoController = TextEditingController(text: '100');
  TextEditingController alturaController = TextEditingController(text: '1.75');
  final _formKey = GlobalKey<FormState>();
  final List<Imc> imcList = [];
  late Imc imc;

  void calcular() {
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    imc = Imc(
        altura: double.parse(alturaController.text),
        peso: double.parse(pesoController.text));

    imc.calcularImc();

    adicionarImc(imc);
  }

  void adicionarImc(Imc imc) {
    setState(() {
      imcList.add(imc);
    });
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o valor do campo';
    }

    return null;
  }

  void limparLista() {
    if (imcList.isEmpty) {
      return;
    }

    setState(() {
      imcList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) => validate(value),
                      controller: pesoController,
                      decoration:
                          const InputDecoration(hintText: 'Informe o peso'),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) => validate(value),
                      controller: alturaController,
                      decoration:
                          const InputDecoration(hintText: 'Informe a altura'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: calcular,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calcular IMC'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: limparLista,
                      icon: const Icon(Icons.cleaning_services_outlined),
                      label: const Text('Limpar lista'),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const Text('Resultados'),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:
                          imcList.map((Imc e) => _ImcTile(imc: e)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImcTile extends StatelessWidget {
  const _ImcTile({required this.imc});

  final Imc imc;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('Peso: ${imc.peso}'),
                Text('Altura: ${imc.altura}'),
              ],
            ),
            Text('Resultado: ${imc.resultado}'),
          ],
        ),
      ),
    );
  }
}
