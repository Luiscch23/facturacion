import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/model_regimen.dart';
import 'package:html_unescape/html_unescape.dart';
import 'dart:convert';

import 'dart:convert';

import 'dart:convert';

class Regimendatos extends ChangeNotifier {
  List<Regimen> _platillosList1 = [];
  List<String> _nombresmoral = [];
  List<String> _nombresfisica = [];
  List<String> _clavemoral = [];
  List<String> _clavefisica = [];

  List<String> _uclavemoral = [];
  List<String> _uclavefisica = [];

  List<String> get nombresmoral => _nombresmoral;
  List<String> get nombresfisica => _nombresfisica;

  List<String> _USOmoral = [];
  List<String> _USOfisica = [];

  List<String> get USOmoral => _USOmoral;
  List<String> get USOfisica => _USOfisica;

  List<String> get clavemoral => _clavemoral;
  List<String> get clavefisica => _clavefisica;

  List<String> get uclavemoral => _uclavemoral;
  List<String> get uclavefisica => _uclavefisica;

  Future<void> fetchData6() async {
    var url = Uri.parse('https://www.luishdez.com.mx/regimen.php');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("correcto lo entiendo19");
      // El servidor respondió exitosamente
      var jsonData = response.body;

      List<int> isoBytes = latin1.encode(jsonData);
      String utf8Data = utf8.decode(isoBytes);
      final regimen = regimenFromJson(utf8Data);

      _platillosList1 = regimen;

      List<Regimen> regimens = regimenFromJson(utf8Data);
      List<String> nombre = [];

      List<Regimen> obtenerRegimenesFisicos(List<Regimen> regimenes) {
        return regimenes
            .where((regimen) => regimen.fisica == Fisica.S)
            .toList();
      }

      List<Regimen> regimenes = obtenerRegimenesFisicos(regimens);

      for (var regimen in regimenes) {
        _nombresfisica.add(regimen.nombre);
        _clavefisica.add(regimen.clave);
      }

      List<Regimen> obtenerRegimenesmorales(List<Regimen> regimenes) {
        return regimenes.where((regimen) => regimen.moral == Fisica.S).toList();
      }

      List<Regimen> regimenesmorales = obtenerRegimenesmorales(regimens);

      for (var regimen in regimenesmorales) {
        _nombresmoral.add(regimen.nombre);
        _clavemoral.add(regimen.clave);
      }

      notifyListeners();
    }

    var url1 = Uri.parse('https://www.luishdez.com.mx/USODECFDI.PHP');
    var response1 = await http.get(url1);

    if (response1.statusCode == 200) {
      print("correcto 999999999");
      // El servidor respondió exitosamente
      var jsonData = response1.body;

      List<int> isoBytes = latin1.encode(jsonData);
      String utf8Data = utf8.decode(isoBytes);
      final regimen = regimenFromJson(utf8Data);

      List<Regimen> regimens1 = regimenFromJson(utf8Data);

      List<Regimen> obtenerRegimenesFisicos(List<Regimen> regimenes) {
        return regimenes.where((regimen) => regimen.moral == Fisica.S).toList();
      }

      List<Regimen> regimenes = obtenerRegimenesFisicos(regimens1);

      for (var regimen in regimenes) {
        _USOmoral.add(regimen.nombre);
        _uclavemoral.add(regimen.clave);
      }

      List<Regimen> obtenerRegimenesmorales(List<Regimen> regimenes) {
        return regimenes
            .where((regimen) => regimen.fisica == Fisica.S)
            .toList();
      }

      List<Regimen> regimenesmorales1 = obtenerRegimenesmorales(regimens1);

      for (var regimen in regimenesmorales1) {
        _USOfisica.add(regimen.nombre);
        _uclavefisica.add(regimen.clave);
      }

      notifyListeners();
    } else {
      // Ocurrió un error al hacer la solicitud
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }
}
