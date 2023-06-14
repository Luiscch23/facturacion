import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../services/estadosgenerales.dart';

class pruebas extends StatefulWidget {
  const pruebas({super.key});

  @override
  State<pruebas> createState() => _pruebasState();
}

class _pruebasState extends State<pruebas> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MiModelo>(builder: (context, snapshot, _) {
      return Padding(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: Container(
              width: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Controla la posición de la sombra
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          DataTable(
                            columns: [
                              DataColumn(label: Text('Nombre')),
                              DataColumn(label: Text('Unidades')),
                              DataColumn(label: Text('Precio Unitario')),
                              DataColumn(label: Text('Descuento')),
                            ],
                            rows: articulos.map((articulo) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(articulo['nombre'])),
                                  DataCell(
                                      Text(articulo['unidades'].toString())),
                                  DataCell(Text(
                                      articulo['precio_unitario_impuesto']
                                          .toString())),
                                  DataCell(
                                      Text(articulo['pctje_dscto'].toString())),
                                ],
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total: \$${snapshot.total}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
