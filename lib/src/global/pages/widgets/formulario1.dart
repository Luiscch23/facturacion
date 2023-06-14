import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../models/model_regimen.dart';
import '../../services/estadosgenerales.dart';
import '../../services/mandar_datos_fiscales.dart';
import '../../services/regimen.dart';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:http/http.dart' as http;

class formulario_folio1 extends StatefulWidget {
  const formulario_folio1({super.key});

  @override
  State<formulario_folio1> createState() => _formulario_folio1State();
}

class _formulario_folio1State extends State<formulario_folio1> {
  String emailErrorText = "";
  TextEditingController correoController = TextEditingController();
  int luiss = 0;
  List<String> REGIMEN = [];
  List<String> USO = [];
  String FoM = "";
  String clave_regimen = "";
  String clava_uso = "";
  final RFC = TextEditingController();
  final NOMBRE = TextEditingController();
  final CORREO = TextEditingController();
  final POSTAL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<Regimendatos>(builder: (context, snapshot, _) {
        return Padding(
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
                Container(
                    width: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<MiModelo>(builder: (context, snapshot, _) {
                          return Text(snapshot.total);
                        }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextDropdownFormField(
                            onSaved: (dynamic str) {},
                            options: ["Fisica", "Moral"],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: "Fisica o Moral:"),
                            dropdownHeight: 120,
                            onChanged: (dynamic str) {
                              FoM = str;

                              if (str == "Fisica") {
                                REGIMEN = snapshot.nombresfisica;
                                USO = snapshot.USOfisica;
                              } else if (str == "Moral") {
                                REGIMEN = snapshot.nombresmoral;
                                USO = snapshot.USOmoral;
                              }

                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextDropdownFormField(
                            onSaved: (dynamic str) {},
                            options: USO,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: "uso"),
                            dropdownHeight: 120,
                            onChanged: (dynamic str) {
                              if (FoM == "Fisica") {
                                int usof = snapshot.USOfisica.indexWhere(
                                    (elemento) => elemento == str);

                                clava_uso = snapshot.uclavefisica[usof];
                                print(snapshot.USOfisica[usof]);
                                print(snapshot.uclavefisica[usof]);
                              } else if (FoM == "Moral") {
                                int usom = snapshot.USOmoral.indexWhere(
                                    (elemento) => elemento == str);
                                clava_uso = snapshot.uclavemoral[usom];
                                print(snapshot.USOmoral[usom]);
                                print(snapshot.uclavemoral[usom]);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextDropdownFormField(
                            onSaved: (dynamic str) {},
                            options: REGIMEN,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: "regimen"),
                            dropdownHeight: 120,
                            onChanged: (dynamic str) {
                              if (FoM == "Fisica") {
                                int usof = snapshot.nombresfisica
                                    .indexWhere((elemento) => elemento == str);
                                print(snapshot.nombresfisica[usof]);
                                print(snapshot.clavefisica[usof]);
                              } else if (FoM == "Moral") {
                                int usom = snapshot.nombresmoral
                                    .indexWhere((elemento) => elemento == str);
                                print(snapshot.nombresmoral[usom]);
                                print(snapshot.clavemoral[usom]);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            child: TextField(
                              controller: NOMBRE,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nombre',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextField(
                              controller: RFC,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'RFC',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextField(
                              controller: CORREO,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Correo',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextField(
                              controller: POSTAL,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Codigo Postal',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                ElevatedButton(
                  onPressed: () {
                    // Lógica o acción a realizar cuando se presiona el botón
                    print('Se presionó el botón');

                    postData("assasa", "asas", "", "", "carreon", "hola");
                  },
                  child: Text('Presionar'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
