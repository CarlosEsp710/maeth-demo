// To parse this JSON data, do
//
//     final alimentosCaracteristicas = alimentosCaracteristicasFromJson(jsonString);

import 'dart:convert';

AlimentosCaracteristicas alimentosCaracteristicasFromJson(String str) =>
    AlimentosCaracteristicas.fromJson(json.decode(str));

String alimentosCaracteristicasToJson(AlimentosCaracteristicas data) =>
    json.encode(data.toJson());

class AlimentosCaracteristicas {
  AlimentosCaracteristicas({
    required this.alimentosPreferidos,
    required this.alimentosNoAgradan,
    required this.alimentosMalestar,
    required this.alimentosAlergias,
    required this.suplementos,
  });

  String alimentosPreferidos;
  String alimentosNoAgradan;
  String alimentosMalestar;
  AlimentosAlergias alimentosAlergias;
  AlimentosAlergias suplementos;

  factory AlimentosCaracteristicas.fromJson(Map<String, dynamic> json) =>
      AlimentosCaracteristicas(
        alimentosPreferidos: json["alimentos_preferidos"],
        alimentosNoAgradan: json["alimentos_no_agradan"],
        alimentosMalestar: json["alimentos_malestar"],
        alimentosAlergias:
            AlimentosAlergias.fromJson(json["alimentos_alergias"]),
        suplementos: AlimentosAlergias.fromJson(json["suplementos"]),
      );

  Map<String, dynamic> toJson() => {
        "alimentos_preferidos": alimentosPreferidos,
        "alimentos_no_agradan": alimentosNoAgradan,
        "alimentos_malestar": alimentosMalestar,
        "alimentos_alergias": alimentosAlergias.toJson(),
        "suplementos": suplementos.toJson(),
      };
}

class AlimentosAlergias {
  AlimentosAlergias({
    required this.value,
    required this.detalles,
  });

  int value;
  String detalles;

  factory AlimentosAlergias.fromJson(Map<String, dynamic> json) =>
      AlimentosAlergias(
        value: json["value"],
        detalles: json["detalles"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "detalles": detalles,
      };
}
