// To parse this JSON data, do
//
//     final indicadoresDieteticos = indicadoresDieteticosFromJson(jsonString);

import 'dart:convert';

IndicadoresDieteticos indicadoresDieteticosFromJson(String str) =>
    IndicadoresDieteticos.fromJson(json.decode(str));

String indicadoresDieteticosToJson(IndicadoresDieteticos data) =>
    json.encode(data.toJson());

class IndicadoresDieteticos {
  IndicadoresDieteticos({
    required this.comidasDia,
    required this.persona,
    required this.comidasCasaEntreSemana,
    required this.comidasFueraCasaEntreSemana,
    required this.comidasCasaFinSemana,
    required this.comidasFueraCasaFinSemana,
    required this.apetito,
    required this.hambre,
    required this.especifique,
  });

  int comidasDia;
  String persona;
  ComidasSemana comidasCasaEntreSemana;
  ComidasSemana comidasFueraCasaEntreSemana;
  ComidasSemana comidasCasaFinSemana;
  ComidasSemana comidasFueraCasaFinSemana;
  String apetito;
  String hambre;
  String especifique;

  factory IndicadoresDieteticos.fromJson(Map<String, dynamic> json) =>
      IndicadoresDieteticos(
        comidasDia: json["comidas_dia"],
        persona: json["persona"],
        comidasCasaEntreSemana:
            ComidasSemana.fromJson(json["comidas_casa_entre_semana"]),
        comidasFueraCasaEntreSemana:
            ComidasSemana.fromJson(json["comidas_fuera_casa_entre_semana"]),
        comidasCasaFinSemana:
            ComidasSemana.fromJson(json["comidas_casa_fin_semana"]),
        comidasFueraCasaFinSemana:
            ComidasSemana.fromJson(json["comidas_fuera_casa_fin_semana"]),
        apetito: json["apetito"],
        hambre: json["hambre"],
        especifique: json["especifique"],
      );

  Map<String, dynamic> toJson() => {
        "comidas_dia": comidasDia,
        "persona": persona,
        "comidas_casa_entre_semana": comidasCasaEntreSemana.toJson(),
        "comidas_fuera_casa_entre_semana": comidasFueraCasaEntreSemana.toJson(),
        "comidas_casa_fin_semana": comidasCasaFinSemana.toJson(),
        "comidas_fuera_casa_fin_semana": comidasFueraCasaFinSemana.toJson(),
        "apetito": apetito,
        "hambre": hambre,
        "especifique": especifique,
      };
}

class ComidasSemana {
  ComidasSemana({
    required this.value,
    required this.time,
  });

  int value;
  String time;

  factory ComidasSemana.fromJson(Map<String, dynamic> json) => ComidasSemana(
        value: json["value"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "time": time,
      };
}
