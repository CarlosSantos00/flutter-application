import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meuapp/controller/feriado_controller.dart';
import 'package:meuapp/model/feriado_model.dart';
import 'package:meuapp/view/menu.dart';

class FeriadosScreen extends StatefulWidget {
  final int ano;

  FeriadosScreen({Key? key, required this.ano}) : super(key: key);

  @override
  State<FeriadosScreen> createState() => _FeriadosScreenState();
}

class _FeriadosScreenState extends State<FeriadosScreen> {
  late Future<List<FeriadoModel>> futureFeriados;
  final TextEditingController _yearController = TextEditingController();
  FeriadoController controller = FeriadoController();
  int anoAtual = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    anoAtual = widget.ano;
    futureFeriados = getFeriados(anoAtual);
  }

  Future<List<FeriadoModel>> getFeriados(int ano) async {
    return await controller.fetchFeriados(ano);
  }

  void _updateFeriados() {
    final int? ano = int.tryParse(_yearController.text);
    if (ano != null) {
      setState(() {
        anoAtual = ano;
        futureFeriados = getFeriados(anoAtual);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text("Feriados de $anoAtual"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _updateFeriados,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ano',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _updateFeriados,
                  child: Text('Buscar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FeriadoModel>>(
              future: futureFeriados,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Erro ao carregar os feriados: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      FeriadoModel feriado = snapshot.data![index];
                      return Card(
                        elevation: 5,
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                },
                                icon: Icons.edit,
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.black,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Confirmação"),
                                      content: Text(
                                          "Deseja realmente excluir o feriado ${feriado.name}?"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Cancelar"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Não é possível deletar da API pública, mas simular uma ação
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Feriado não pode ser excluído!")));
                                            Navigator.pop(context);
                                          },
                                          child: Text("Confirmar"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(feriado.date.split('-')[2]), // Exibe o dia do feriado
                            ),
                            title: Text(feriado.name),
                            subtitle: Text(feriado.formattedDate), // Usa a data formatada
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Nenhum feriado encontrado.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
