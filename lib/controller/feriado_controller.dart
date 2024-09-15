import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meuapp/model/feriado_model.dart';

class FeriadoController {
  Future<List<FeriadoModel>> fetchFeriados(int ano) async {
    final response = await http
        .get(Uri.parse('https://brasilapi.com.br/api/feriados/v1/$ano'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => FeriadoModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar feriados');
    }
  }
}
