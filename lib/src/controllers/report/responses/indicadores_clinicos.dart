// To parse this JSON data, do
//
//     final indicadoresClinicos = indicadoresClinicosFromJson(jsonString);

import 'dart:convert';

IndicadoresClinicos indicadoresClinicosFromJson(String str) =>
    IndicadoresClinicos.fromJson(json.decode(str));

String indicadoresClinicosToJson(IndicadoresClinicos data) =>
    json.encode(data.toJson());

class IndicadoresClinicos {
  IndicadoresClinicos({
    required this.indicadoresClinicos,
    required this.enfermedadDiagnosticada,
    required this.medicamentos,
    required this.productos,
  });

  IndicadoresClinicosClass indicadoresClinicos;
  EnfermedadDiagnosticada enfermedadDiagnosticada;
  EnfermedadDiagnosticada medicamentos;
  Productos productos;

  factory IndicadoresClinicos.fromJson(Map<String, dynamic> json) =>
      IndicadoresClinicos(
        indicadoresClinicos:
            IndicadoresClinicosClass.fromJson(json["indicadores_clinicos"]),
        enfermedadDiagnosticada:
            EnfermedadDiagnosticada.fromJson(json["enfermedad_diagnosticada"]),
        medicamentos: EnfermedadDiagnosticada.fromJson(json["medicamentos"]),
        productos: Productos.fromJson(json["productos"]),
      );

  Map<String, dynamic> toJson() => {
        "indicadores_clinicos": indicadoresClinicos.toJson(),
        "enfermedad_diagnosticada": enfermedadDiagnosticada.toJson(),
        "medicamentos": medicamentos.toJson(),
        "productos": productos.toJson(),
      };
}

class EnfermedadDiagnosticada {
  EnfermedadDiagnosticada({
    required this.value,
    required this.especifique,
  });

  int value;
  String especifique;

  factory EnfermedadDiagnosticada.fromJson(Map<String, dynamic> json) =>
      EnfermedadDiagnosticada(
        value: json["value"],
        especifique: json["especifique"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "especifique": especifique,
      };
}

class IndicadoresClinicosClass {
  IndicadoresClinicosClass({
    required this.listaIndicadores,
    required this.otro,
  });

  List<Lista> listaIndicadores;
  String otro;

  factory IndicadoresClinicosClass.fromJson(Map<String, dynamic> json) =>
      IndicadoresClinicosClass(
        listaIndicadores: List<Lista>.from(
            json["lista_indicadores"].map((x) => Lista.fromJson(x))),
        otro: json["otro"],
      );

  Map<String, dynamic> toJson() => {
        "lista_indicadores":
            List<dynamic>.from(listaIndicadores.map((x) => x.toJson())),
        "otro": otro,
      };
}

class Lista {
  Lista({
    required this.name,
    required this.value,
  });

  String name;
  bool value;

  factory Lista.fromJson(Map<String, dynamic> json) => Lista(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class Productos {
  Productos({
    required this.listaProductos,
    required this.otro,
  });

  List<Lista> listaProductos;
  String otro;

  factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        listaProductos: List<Lista>.from(
            json["lista_productos"].map((x) => Lista.fromJson(x))),
        otro: json["otro"],
      );

  Map<String, dynamic> toJson() => {
        "lista_productos":
            List<dynamic>.from(listaProductos.map((x) => x.toJson())),
        "otro": otro,
      };
}
