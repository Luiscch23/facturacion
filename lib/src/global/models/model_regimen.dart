// To parse this JSON data, do
//
//     final regimen = regimenFromJson(jsonString);

import 'dart:convert';

List<Regimen> regimenFromJson(String str) =>
    List<Regimen>.from(json.decode(str).map((x) => Regimen.fromJson(x)));

String regimenToJson(List<Regimen> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Regimen {
  String clave;
  String nombre;
  Fisica fisica;
  Fisica moral;

  Regimen({
    required this.clave,
    required this.nombre,
    required this.fisica,
    required this.moral,
  });

  factory Regimen.fromJson(Map<String, dynamic> json) => Regimen(
        clave: json["clave"],
        nombre: json["nombre"],
        fisica: fisicaValues.map[json["fisica"]]!,
        moral: fisicaValues.map[json["moral"]]!,
      );

  Map<String, dynamic> toJson() => {
        "clave": clave,
        "nombre": nombre,
        "fisica": fisicaValues.reverse[fisica],
        "moral": fisicaValues.reverse[moral],
      };
}

enum Fisica { NO, S }

final fisicaValues = EnumValues({"No": Fisica.NO, "Sí": Fisica.S});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
