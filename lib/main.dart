import 'package:facturacion/src/global/models/model_regimen.dart';
import 'package:facturacion/src/global/pages/page_infolio.dart';
import 'package:facturacion/src/global/pages/widgets/formulario1.dart';
import 'package:facturacion/src/global/pages/widgets/formulariotiket.dart';

import 'package:facturacion/src/global/services/estadosgenerales.dart';
import 'package:facturacion/src/global/services/regimen.dart';
import 'package:facturacion/src/global/services/regimen_uso.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MiModelo()),
        ChangeNotifierProvider(
          create: (context) => Regimendatos()..fetchData6(),
        ),
        // Agrega más providers según tus necesidades
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: "Facturacion"),
    );
  }
}
