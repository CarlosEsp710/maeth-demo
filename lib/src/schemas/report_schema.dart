import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/schemas/patient_schema.dart';

class Report extends Schema {
  // Constructors
  Report(ResourceObject resourceObject) : super(resourceObject);
  Report.init(String type) : super.init(type);

  /// Attributes

  String get indicadoresClinicos => getAttribute<String>('clinical_indicators');
  set indicadoresClinicos(String value) =>
      setAttribute<String>('clinical_indicators', value);

  String get antecedentesFamiliares =>
      getAttribute<String>('family_background');
  set antecedentesFamiliares(String value) =>
      setAttribute<String>('family_background', value);

  String get historialGinecologico =>
      getAttribute<String>('gynecological_history');
  set historialGinecologico(String value) =>
      setAttribute<String>('gynecological_history', value);

  String get estiloVida => getAttribute<String>('life_style');
  set estiloVida(String value) => setAttribute<String>('life_style', value);

  String get indicadoresDieteticos =>
      getAttribute<String>('dietary_indicators');
  set indicadoresDieteticos(String value) =>
      setAttribute<String>('dietary_indicators', value);

  String get rutinaDiaria => getAttribute<String>('daily_routine');
  set rutinaDiaria(String value) =>
      setAttribute<String>('daily_routine', value);

  String get alimentosCaracteristicas =>
      getAttribute<String>('food_characteristics');
  set alimentosCaracteristicas(String value) =>
      setAttribute<String>('food_characteristics', value);

  String get consumoVariantes => getAttribute<String>('consumption_variants');
  set consumoVariantes(String value) =>
      setAttribute<String>('consumption_variants', value);

  String get dietaHabitual => getAttribute<String>('usual_diet');
  set dietaHabitual(String value) => setAttribute<String>('usual_diet', value);

  set patient(Patient model) => setHasOne('patient', model);
}
