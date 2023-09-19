import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_dio_flutter/models/imc.dart';

class ImcListPage extends StatefulWidget {
  const ImcListPage({super.key});

  @override
  State<ImcListPage> createState() => _ImcListPageState();
}

class _ImcListPageState extends State<ImcListPage> {
  late final Box<Imc> box;

  @override
  void initState() {
    super.initState();

    box = Hive.box('imcBox');
  }

  void clearBox() {
    box.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Resultados armazenados'),
            backgroundColor: Colors.blue.shade100,
            actions: [
              IconButton(
                  onPressed: clearBox,
                  icon: const Icon(Icons.cleaning_services_outlined))
            ],
          ),
          body: ValueListenableBuilder<Box<Imc>>(
              valueListenable: box.listenable(),
              builder: (_, imcBox, __) {
                if (imcBox.isEmpty) {
                  return const Center(
                    child: Text('Armazenamento vazio'),
                  );
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: box.length,
                    itemBuilder: (_, index) {
                      final imc = imcBox.getAt(index);
                      return _ImcTile(imc: imc!);
                    });
              }),
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
