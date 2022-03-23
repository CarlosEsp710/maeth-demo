// To parse this JSON data, do
//
//     final rutinaDiaria = rutinaDiariaFromJson(jsonString);

import 'dart:convert';

RutinaDiaria rutinaDiariaFromJson(String str) =>
    RutinaDiaria.fromJson(json.decode(str));

String rutinaDiariaToJson(RutinaDiaria data) => json.encode(data.toJson());

class RutinaDiaria {
  RutinaDiaria({
    required this.horaLevntarse,
    required this.desayuno,
    required this.comida,
    required this.cena,
    required this.horaDormir,
  });

  String horaLevntarse;
  String desayuno;
  String comida;
  String cena;
  String horaDormir;

  factory RutinaDiaria.fromJson(Map<String, dynamic> json) => RutinaDiaria(
        horaLevntarse: json["hora_levntarse"],
        desayuno: json["desayuno"],
        comida: json["comida"],
        cena: json["cena"],
        horaDormir: json["hora_dormir"],
      );

  Map<String, dynamic> toJson() => {
        "hora_levntarse": horaLevntarse,
        "desayuno": desayuno,
        "comida": comida,
        "cena": cena,
        "hora_dormir": horaDormir,
      };
}
