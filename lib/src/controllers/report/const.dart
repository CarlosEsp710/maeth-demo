import 'package:flutter/material.dart';

class ClinicalIndicator {
  final String name;
  bool value;

  ClinicalIndicator({
    required this.name,
    this.value = false,
  });

  Map toJson() => {'name': name, 'value': value};
}

class MedicalProduct {
  final String name;
  bool value;

  MedicalProduct({
    required this.name,
    this.value = false,
  });

  Map toJson() => {'name': name, 'value': value};
}

List<ClinicalIndicator> indicatorsList = [
  ClinicalIndicator(name: 'Diarrea'),
  ClinicalIndicator(name: 'Estreñimiento'),
  ClinicalIndicator(name: 'Gastritis'),
  ClinicalIndicator(name: 'Úlcera'),
  ClinicalIndicator(name: 'Nauceas'),
  ClinicalIndicator(name: 'Pirosis'),
  ClinicalIndicator(name: 'Vómito'),
  ClinicalIndicator(name: 'Colitis'),
];

List<MedicalProduct> productsList = [
  MedicalProduct(name: 'Laxantes'),
  MedicalProduct(name: 'Diuréticos'),
  MedicalProduct(name: 'Antiácidos'),
];

List<String> lifestyleList = [
  "Seleccionar",
  "Ninguna",
  "Ligera",
  "Moderada",
  "Pesada",
  "Excepcional"
];

List<String> timeList = [
  'Seleccionar',
  '0 - 15 minutos',
  '15 - 30 minutos',
  '30 - 45 minutos',
  '45 - 60 minutos',
  '1 - 1:30 horas',
  '1:30 - 2 horas',
  'Más de 2 horas'
];

List<String> personsList = [
  'Seleccionar',
  'Yo mismo(a)',
  'Esposo(a)',
  'Familiar',
  'La compro',
  'Otro',
];

List<String> appetiteList = [
  'Seleccionar',
  'Bueno',
  'Regular',
  'Malo',
];

List<String> hungryList = [
  'Seleccionar',
  'Mañana',
  'Tarde',
  'Noche',
];

List<String> oilsList = [
  'Seleccionar',
  'Margarina',
  'Mantequilla',
  'Aceite vegetal',
  'Manteca',
  'Otro'
];

String time = 'Seleccionar';

String lifestyle = "Seleccionar";

String person = "Seleccionar";

String appetite = 'Seleccionar';

String hungry = 'Seleccionar';

String oil = 'Seleccionar';

// Form 1 - A
String text1 = '';
String text2 = '';
String text3 = '';
String text4 = '';
int radioGroup1 = 0;
int radioGroup2 = 0;

// Form 1 - B
String text5 = '';
String text6 = '';
String text7 = '';
String text8 = '';
String text9 = '';
int radioGroup3 = 0;
int radioGroup4 = 0;
int radioGroup5 = 0;
int radioGroup6 = 0;
int radioGroup7 = 0;

// Form 2
String text10 = '';
String text11 = '';
String text12 = '';
String text13 = '';
int radioGroup8 = 0;
int radioGroup9 = 0;
int radioGroup10 = 0;
int radioGroup11 = 0;

// Form 3
String text14 = '';
String text15 = '';
String text16 = '';
int excerciseDays = 0;
int radioGroup12 = 0;
int radioGroup13 = 0;
int radioGroup14 = 0;

// Form 4 - A
TimeOfDay? time1;
TimeOfDay? time2;
TimeOfDay? time3;
TimeOfDay? time4;
TimeOfDay? time5;

// Form 4 - B
int mealsAtDay = 0;
int mealsInHouseWeekday = 0;
int mealsOutHouseWeekday = 0;
int mealsInHouseWeekend = 0;
int mealsOutHouseWeekend = 0;
TimeOfDay? time6;
TimeOfDay? time7;
TimeOfDay? time8;
TimeOfDay? time9;

// Form 5 - A
String text17 = '';

// Form 5 - B
String text18 = '';
String text19 = '';
String text20 = '';
String text21 = '';
String text22 = '';
int radioGroup15 = 0;
int radioGroup16 = 0;

// Form 6 -A
int radioGroup17 = 0;
int radioGroup18 = 0;
int radioGroup19 = 0;
String text23 = '';
String text24 = '';
String text25 = '';

// Form 6 - B
String text26 = '';
String text27 = '';
String text28 = '';
String text29 = '';
String text30 = '';
String text31 = '';
