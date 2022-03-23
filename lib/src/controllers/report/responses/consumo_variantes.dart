// To parse this JSON data, do
//
//     final consumoVariantes = consumoVariantesFromJson(jsonString);

import 'dart:convert';

ConsumoVariantes consumoVariantesFromJson(String str) =>
    ConsumoVariantes.fromJson(json.decode(str));

String consumoVariantesToJson(ConsumoVariantes data) =>
    json.encode(data.toJson());

class ConsumoVariantes {
  ConsumoVariantes({
    required this.sal,
    required this.dietaEspecial,
    required this.tratamientoPerderPeso,
    required this.aceites,
  });

  DietaEspecial sal;
  DietaEspecial dietaEspecial;
  DietaEspecial tratamientoPerderPeso;
  String aceites;

  factory ConsumoVariantes.fromJson(Map<String, dynamic> json) =>
      ConsumoVariantes(
        sal: DietaEspecial.fromJson(json["sal"]),
        dietaEspecial: DietaEspecial.fromJson(json["dieta_especial"]),
        tratamientoPerderPeso:
            DietaEspecial.fromJson(json["tratamiento_perder_peso"]),
        aceites: json["aceites"],
      );

  Map<String, dynamic> toJson() => {
        "sal": sal.toJson(),
        "dieta_especial": dietaEspecial.toJson(),
        "tratamiento_perder_peso": tratamientoPerderPeso.toJson(),
        "aceites": aceites,
      };
}

class DietaEspecial {
  DietaEspecial({
    required this.value,
    required this.detalles,
  });

  int value;
  String detalles;

  factory DietaEspecial.fromJson(Map<String, dynamic> json) => DietaEspecial(
        value: json["value"],
        detalles: json["detalles"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "detalles": detalles,
      };
}
