// To parse this JSON data, do
//
//     final estiloVida = estiloVidaFromJson(jsonString);

import 'dart:convert';

EstiloVida estiloVidaFromJson(String str) =>
    EstiloVida.fromJson(json.decode(str));

String estiloVidaToJson(EstiloVida data) => json.encode(data.toJson());

class EstiloVida {
  EstiloVida({
    required this.actividadFisica,
    required this.ejercicio,
    required this.cafe,
    required this.fumar,
  });

  ActividadFisica actividadFisica;
  Ejercicio ejercicio;
  Cafe cafe;
  Cafe fumar;

  factory EstiloVida.fromJson(Map<String, dynamic> json) => EstiloVida(
        actividadFisica: ActividadFisica.fromJson(json["actividad_fisica"]),
        ejercicio: Ejercicio.fromJson(json["ejercicio"]),
        cafe: Cafe.fromJson(json["cafe"]),
        fumar: Cafe.fromJson(json["fumar"]),
      );

  Map<String, dynamic> toJson() => {
        "actividad_fisica": actividadFisica.toJson(),
        "ejercicio": ejercicio.toJson(),
        "cafe": cafe.toJson(),
        "fumar": fumar.toJson(),
      };
}

class ActividadFisica {
  ActividadFisica({
    required this.value,
  });

  String value;

  factory ActividadFisica.fromJson(Map<String, dynamic> json) =>
      ActividadFisica(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Cafe {
  Cafe({
    required this.value,
    required this.especifique,
  });

  int value;
  String especifique;

  factory Cafe.fromJson(Map<String, dynamic> json) => Cafe(
        value: json["value"],
        especifique: json["especifique"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "especifique": especifique,
      };
}

class Ejercicio {
  Ejercicio({
    required this.value,
    required this.tipo,
    required this.dias,
    required this.duracion,
  });

  int value;
  String tipo;
  int dias;
  String duracion;

  factory Ejercicio.fromJson(Map<String, dynamic> json) => Ejercicio(
        value: json["value"],
        tipo: json["tipo"],
        dias: json["dias"],
        duracion: json["duracion"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "tipo": tipo,
        "dias": dias,
        "duracion": duracion,
      };
}
