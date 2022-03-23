// To parse this JSON data, do
//
//     final dietaHabitial = dietaHabitialFromJson(jsonString);

import 'dart:convert';

DietaHabitial dietaHabitialFromJson(String str) =>
    DietaHabitial.fromJson(json.decode(str));

String dietaHabitialToJson(DietaHabitial data) => json.encode(data.toJson());

class DietaHabitial {
  DietaHabitial({
    required this.desayuno,
    required this.colacion1,
    required this.comida,
    required this.colacion2,
    required this.cena,
    required this.colacion3,
  });

  String desayuno;
  String colacion1;
  String comida;
  String colacion2;
  String cena;
  String colacion3;

  factory DietaHabitial.fromJson(Map<String, dynamic> json) => DietaHabitial(
        desayuno: json["desayuno"],
        colacion1: json["colacion_1"],
        comida: json["comida"],
        colacion2: json["colacion_2"],
        cena: json["cena"],
        colacion3: json["colacion_3"],
      );

  Map<String, dynamic> toJson() => {
        "desayuno": desayuno,
        "colacion_1": colacion1,
        "comida": comida,
        "colacion_2": colacion2,
        "cena": cena,
        "colacion_3": colacion3,
      };
}
