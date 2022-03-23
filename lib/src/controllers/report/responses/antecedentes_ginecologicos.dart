// To parse this JSON data, do
//
//     final antecedentesGinecologicos = antecedentesGinecologicosFromJson(jsonString);

import 'dart:convert';

AntecedentesGinecologicos antecedentesGinecologicosFromJson(String str) =>
    AntecedentesGinecologicos.fromJson(json.decode(str));

String antecedentesGinecologicosToJson(AntecedentesGinecologicos data) =>
    json.encode(data.toJson());

class AntecedentesGinecologicos {
  AntecedentesGinecologicos({
    required this.embarazo,
    required this.anticonceptivos,
    required this.climaterio,
    required this.tratamientoHormonal,
  });

  Anticonceptivos embarazo;
  Anticonceptivos anticonceptivos;
  Anticonceptivos climaterio;
  Anticonceptivos tratamientoHormonal;

  factory AntecedentesGinecologicos.fromJson(Map<String, dynamic> json) =>
      AntecedentesGinecologicos(
        embarazo: Anticonceptivos.fromJson(json["embarazo"]),
        anticonceptivos: Anticonceptivos.fromJson(json["anticonceptivos"]),
        climaterio: Anticonceptivos.fromJson(json["climaterio"]),
        tratamientoHormonal:
            Anticonceptivos.fromJson(json["tratamiento_hormonal"]),
      );

  Map<String, dynamic> toJson() => {
        "embarazo": embarazo.toJson(),
        "anticonceptivos": anticonceptivos.toJson(),
        "climaterio": climaterio.toJson(),
        "tratamiento_hormonal": tratamientoHormonal.toJson(),
      };
}

class Anticonceptivos {
  Anticonceptivos({
    required this.value,
    required this.especifique,
  });

  int value;
  String especifique;

  factory Anticonceptivos.fromJson(Map<String, dynamic> json) =>
      Anticonceptivos(
        value: json["value"],
        especifique: json["especifique"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "especifique": especifique,
      };
}
