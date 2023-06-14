import 'dart:async';

import 'package:facturacion/src/global/pages/widgets/formulario1.dart';
import 'package:facturacion/src/global/pages/widgets/formulariotiket.dart';
import 'package:facturacion/src/global/pages/widgets/tabla1.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/estadosgenerales.dart';
import '../services/regimen_uso.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<MiModelo>(builder: (context, snapshot, _) {
        print(snapshot.datoss);

        return Consumer<MiModelo>(builder: (context, snapshot, _) {
          print("sasdasadsad");
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              pagina(formulario_folio(), 0, snapshot.datoss),
              pagina(pruebas(), 1, snapshot.datoss),
              pagina(formulario_folio1(), 1, 0),
            ],
          );
        });
      }),
    );
  }

  Widget pagina(Widget contenido, int currentPageIndex, int currentPageIndex1) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          contenido,
          if (currentPageIndex1 >
              0) // Mostrar el botón "anterior" solo si no es la primera página
            Consumer<MiModelo>(builder: (context, snapshot, _) {
              if (snapshot.folio_ok) {
                _pageController.nextPage(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
                snapshot.actualizarfolio = false;
              }
              return Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (_pageController.hasClients) {
                        _pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Icon(Icons.navigate_next),
                  ),
                ),
              );
            }),
          if (currentPageIndex > 0)
            Align(
              alignment: Alignment.bottomLeft,
              child: Consumer<MiModelo>(builder: (context, snapshot, _) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (_pageController.hasClients) {
                        int pag = _pageController.page?.round() ?? 0;

                        if (pag == 1) {
                          snapshot.actualizarDato1 = 0;
                        }

                        _pageController.previousPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Icon(Icons.navigate_before_outlined),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
