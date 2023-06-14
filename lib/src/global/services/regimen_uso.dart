import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import 'estadosgenerales.dart';

List<dynamic> articulos = [];
double total = 0;

Future<List<dynamic>> fetchAPI3(int entero, String texto) async {
  final response = await http.post(
    Uri.parse('http://localhost/buscarfolio.php'),
    body: {
      'entero': entero.toString(),
      'texto': texto,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<dynamic> articulos =
        data.values.where((value) => value is Map).toList();
    String total = data['Total'].toString();
    return articulos;
  } else {
    print(
        'Error en la solicitud HTTP. Código de estado: ${response.statusCode}');
    return [];
  }
}

double total1() {
  return total;
}
