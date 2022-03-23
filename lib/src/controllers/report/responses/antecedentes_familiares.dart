// To parse this JSON data, do
//
//     final antecedentesFamiliares = antecedentesFamiliaresFromJson(jsonString);

import 'dart:convert';

AntecedentesFamiliares antecedentesFamiliaresFromJson(String str) =>
    AntecedentesFamiliares.fromJson(json.decode(str));

String antecedentesFamiliaresToJson(AntecedentesFamiliares data) =>
    json.encode(data.toJson());

class AntecedentesFamiliares {
  AntecedentesFamiliares({
    required this.obesidad,
    required this.diabetes,
    required this.cancer,
    required this.hipercolesterolemia,
    required this.hipertrigliceridemia,
  });

  Cancer obesidad;
  Cancer diabetes;
  Cancer cancer;
  Cancer hipercolesterolemia;
  Cancer hipertrigliceridemia;

  factory AntecedentesFamiliares.fromJson(Map<String, dynamic> json) =>
      AntecedentesFamiliares(
        obesidad: Cancer.fromJson(json["obesidad"]),
        diabetes: Cancer.fromJson(json["diabetes"]),
        cancer: Cancer.fromJson(json["cancer"]),
        hipercolesterolemia: Cancer.fromJson(json["hipercolesterolemia"]),
        hipertrigliceridemia: Cancer.fromJson(json["hipertrigliceridemia"]),
      );

  Map<String, dynamic> toJson() => {
        "obesidad": obesidad.toJson(),
        "diabetes": diabetes.toJson(),
        "cancer": cancer.toJson(),
        "hipercolesterolemia": hipercolesterolemia.toJson(),
        "hipertrigliceridemia": hipertrigliceridemia.toJson(),
      };
}

class Cancer {
  Cancer({
    required this.value,
    required this.parentezco,
  });

  int value;
  String parentezco;

  factory Cancer.fromJson(Map<String, dynamic> json) => Cancer(
        value: json["value"],
        parentezco: json["parentezco"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "parentezco": parentezco,
      };
}
