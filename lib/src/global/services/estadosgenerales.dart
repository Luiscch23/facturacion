import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

List<dynamic> articulos = [];
double total = 0;

class MiModelo extends ChangeNotifier {
  bool _folio_ok = false;
  bool _folio_correcto = false;
  int _dato = 0;
  bool _botonbusc = true;
  String _total = "";
  double _total_int = 0;

  List _datos = [];
  int get datoss => _dato;
  bool get botonbusc => _botonbusc;
  List get datosss => _datos;

  String get total => _total;

  bool get folio_ok => _folio_ok;
  bool get folio_correcto => _folio_correcto;

  double get total_int => _total_int;

  Future<List<dynamic>> fetchAPI(String folio) async {
    final response = await http.post(
      Uri.parse('http://localhost/buscarfolio.php'),
      // Opcional: Puedes enviar datos adicionales en el cuerpo de la solicitud POST
      body: {
        'folio': folio,
        //   'key2': 'value2',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      articulos = data.values.where((value) => value is Map).toList();

      _total = data['Total'].toString();
      _botonbusc = true;
      _datos.toString();

      _datos = articulos;

      if (double.parse(_total) > 0) {
        print("mayor a cero");
      }
      if (double.parse(_total) == _total_int) {
        _dato = 1;
        _folio_ok = true;
        _folio_correcto = true;
      }

      notifyListeners();
      print(articulos.toString());
      return articulos.toList();
    } else {
      print(
          'Error en la solicitud HTTP. Código de estado: ${response.statusCode}');
      return [];
    }
  }

  set actualizarDato1(int nuevoDato) {
    _dato = nuevoDato;
    _datos = _datos;
    print(_datos.toString());
    print("el dato es" + nuevoDato.toString());
    notifyListeners();
  }

  set actualizarfolio(bool nuevoDato) {
    _folio_ok = nuevoDato;
    notifyListeners();
  }

  set actualizar(bool nuevoDato) {
    _botonbusc = nuevoDato;
    notifyListeners();
  }

  set foliocorrecto(bool nuevoDato) {
    _folio_correcto = nuevoDato;
    notifyListeners();
  }

  set total1(double nuevoDato) {
    _total_int = nuevoDato;
    notifyListeners();
  }
}
