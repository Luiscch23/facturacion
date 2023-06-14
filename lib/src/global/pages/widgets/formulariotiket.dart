import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../services/estadosgenerales.dart';
import '../../services/regimen.dart';

class formulario_folio extends StatefulWidget {
  const formulario_folio({super.key});

  @override
  State<formulario_folio> createState() => _formulario_folioState();
}

class _formulario_folioState extends State<formulario_folio> {
  String responseText = '';

  @override
  Widget build(BuildContext context) {
    final folio = TextEditingController();
    final total = TextEditingController();

    return Center(
      child: Consumer<MiModelo>(builder: (context, dataModel, child) {
        folio.text = "SB0587388";

        return Container(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,

                          offset: Offset(0, 3),
                          // Controla la posición de la sombra
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Ingresa tu numero de tiket y total de la cuenta"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: folio,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Folio',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: total,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Total de la cuenta',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<MiModelo>(
                              builder: (context, snapshot, _) {
                            if (snapshot.botonbusc) {
                              return ElevatedButton(
                                onPressed: () {
                                  snapshot.actualizar = false;
                                  snapshot.actualizarDato1 = 0;

                                  try {
                                    if (total.text == null ||
                                        total.text.isEmpty) {
                                      dataModel.total1 = 0;
                                      snapshot.fetchAPI(folio.text);
                                    } else {
                                      dataModel.total1 =
                                          double.parse(total.text);
                                      snapshot.fetchAPI(folio.text);
                                    }
                                  } catch (e) {
                                    dataModel.total1 = 0;
                                    snapshot.fetchAPI(folio.text);
                                  }

                                  print('Se presionó el botón');
                                },
                                child: Text('Presionar'),
                              );
                            } else
                              return CircularProgressIndicator();
                          }),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
