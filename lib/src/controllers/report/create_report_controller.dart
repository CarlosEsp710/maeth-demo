import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/controllers/report/const.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/patient_schema.dart';
import 'package:maeth_demo/src/schemas/report_schema.dart';
import 'package:maeth_demo/src/views/report/create_report_view.dart';

class CreateReportController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  final formKey = GlobalKey<FormState>();
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();
  final textController4 = TextEditingController();
  final textController5 = TextEditingController();
  final textController6 = TextEditingController();
  final textController7 = TextEditingController();
  final textController8 = TextEditingController();
  final textController9 = TextEditingController();
  final textController10 = TextEditingController();
  final textController11 = TextEditingController();
  final textController12 = TextEditingController();
  final textController13 = TextEditingController();
  final textController14 = TextEditingController();
  final textController15 = TextEditingController();
  final textController16 = TextEditingController();
  final textController17 = TextEditingController();
  final textController18 = TextEditingController();
  final textController19 = TextEditingController();
  final textController20 = TextEditingController();
  final textController21 = TextEditingController();
  final textController22 = TextEditingController();
  final textController23 = TextEditingController();
  final textController24 = TextEditingController();
  final textController25 = TextEditingController();
  final textController26 = TextEditingController();
  final textController27 = TextEditingController();
  final textController28 = TextEditingController();
  final textController29 = TextEditingController();
  final textController30 = TextEditingController();
  final textController31 = TextEditingController();

  final timeController1 = TextEditingController();
  final timeController2 = TextEditingController();
  final timeController3 = TextEditingController();
  final timeController4 = TextEditingController();
  final timeController5 = TextEditingController();
  final timeController6 = TextEditingController();
  final timeController7 = TextEditingController();
  final timeController8 = TextEditingController();
  final timeController9 = TextEditingController();

  showAlert(BuildContext context) async {
    showConfirmAlert(
      context: context,
      title: 'Antes de continuar',
      subtitle: 'Ten a la mano los siguientes datos...',
      confirmText: 'Listo',
      cancelText: 'Cancelar',
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageTransition(
            child: const CreateReportView(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      },
    );
  }

  void createReport(BuildContext context) async {
    showLoading(context);

    final token = await _credentials.getToken();
    _api.addHeader('Authorization', 'Bearer $token');

    Adapter adapter = _api;
    if (formKey.currentState!.validate()) {
      if (_validateReport()) {
        try {
          Report report = _buildReport(context);

          await adapter.save('reports', report.resourceObject);

          Navigator.pop(context);

          showSuccessAlert(
            context,
            'Reporte creado',
            'El reporte fue create con éxito',
          );
        } catch (e) {
          Navigator.pop(context);

          showErrorAlert(
            context,
            'Algo salió mal',
            'Intenta de nuevo',
          );
        }
      } else {
        Navigator.pop(context);
        showErrorAlert(
          context,
          'Error',
          'Revisa que hayas completado correctamente los campos',
        );
      }
    }
  }

  bool _validateReport() {
    if (radioGroup1 == 0 ||
        radioGroup2 == 0 ||
        radioGroup3 == 0 ||
        radioGroup4 == 0 ||
        radioGroup5 == 0 ||
        radioGroup6 == 0 ||
        radioGroup7 == 0 ||
        radioGroup12 == 0 ||
        radioGroup13 == 0 ||
        radioGroup14 == 0 ||
        radioGroup15 == 0 ||
        radioGroup16 == 0 ||
        radioGroup17 == 0 ||
        radioGroup18 == 0 ||
        radioGroup19 == 0) {
      return false;
    } else if (lifestyle == 'Seleccionar' ||
        person == 'Seleccionar' ||
        appetite == 'Seleccionar' ||
        hungry == 'Seleccionar' ||
        oil == 'Seleccionar') {
      return false;
    } else if (time1 == null ||
        time2 == null ||
        time3 == null ||
        time4 == null ||
        time5 == null ||
        time6 == null ||
        time7 == null ||
        time8 == null ||
        time9 == null) {
      return false;
    } else {
      return true;
    }
  }

  Report _buildReport(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    var indicadoresClinicosJson = jsonEncode({
      'indicadores_clinicos': {
        'lista_indicadores': indicatorsList,
        'otro': text1,
      },
      'enfermedad_diagnosticada': {
        'value': radioGroup1,
        'especifique': text2,
      },
      'medicamentos': {
        'value': radioGroup2,
        'especifique': text3,
      },
      'productos': {
        'lista_productos': productsList,
        'otro': text4,
      }
    });

    var antecedentesFamiliaresJson = jsonEncode({
      'obesidad': {
        'value': radioGroup3,
        'parentezco': text5,
      },
      'diabetes': {
        'value': radioGroup4,
        'parentezco': text6,
      },
      'cancer': {
        'value': radioGroup5,
        'parentezco': text7,
      },
      'hipercolesterolemia': {
        'value': radioGroup6,
        'parentezco': text8,
      },
      'hipertrigliceridemia': {
        'value': radioGroup7,
        'parentezco': text9,
      },
    });

    var historialGinecologicoJson = jsonEncode({
      'embarazo': {
        'value': radioGroup8,
        'especifique': text10,
      },
      'anticonceptivos': {
        'value': radioGroup9,
        'especifique': text11,
      },
      'climaterio': {
        'value': radioGroup10,
        'especifique': text12,
      },
      'tratamiento_hormonal': {
        'value': radioGroup11,
        'especifique': text13,
      }
    });

    var estiloVidaJson = jsonEncode({
      'actividad_fisica': {
        'value': lifestyle,
      },
      'ejercicio': {
        'value': radioGroup12,
        'tipo': text14,
        'dias': excerciseDays,
        'duracion': time
      },
      'cafe': {
        'value': radioGroup13,
        'especifique': text15,
      },
      'fumar': {
        'value': radioGroup14,
        'especifique': text16,
      }
    });

    var rutinaDiariaJson = jsonEncode({
      'hora_levntarse': '${time1!.hour}:${time1!.minute}',
      'desayuno': '${time2!.hour}:${time2!.minute}',
      'comida': '${time3!.hour}:${time3!.minute}',
      'cena': '${time4!.hour}:${time4!.minute}',
      'hora_dormir': '${time5!.hour}:${time5!.minute}'
    });

    var indicadoresDieteticosJson = jsonEncode({
      'comidas_dia': mealsAtDay,
      'persona': person,
      'comidas_casa_entre_semana': {
        'value': mealsInHouseWeekday,
        'time': '${time6!.hour}:${time6!.minute}'
      },
      'comidas_fuera_casa_entre_semana': {
        'value': mealsOutHouseWeekday,
        'time': '${time7!.hour}:${time7!.minute}'
      },
      'comidas_casa_fin_semana': {
        'value': mealsInHouseWeekend,
        'time': '${time8!.hour}:${time8!.minute}'
      },
      'comidas_fuera_casa_fin_semana': {
        'value': mealsOutHouseWeekend,
        'time': '${time9!.hour}:${time9!.minute}'
      },
      'apetito': appetite,
      'hambre': hungry,
      'especifique': text17,
    });

    var alimentosCaracteristicasJson = jsonEncode({
      'alimentos_preferidos': text18,
      'alimentos_no_agradan': text19,
      'alimentos_malestar': text20,
      'alimentos_alergias': {
        'value': radioGroup15,
        'detalles': text21,
      },
      'suplementos': {
        'value': radioGroup16,
        'detalles': text22,
      }
    });

    var consumoVariantesJson = jsonEncode({
      'sal': {
        'value': radioGroup17,
        'detalles': text23,
      },
      'dieta_especial': {
        'value': radioGroup18,
        'detalles': text24,
      },
      'tratamiento_perder_peso': {
        'value': radioGroup19,
        'detalles': text25,
      },
      'aceites': oil,
    });

    var dietaHabitualJson = jsonEncode({
      'desayuno': text26,
      'colacion_1': text27,
      'comida': text28,
      'colacion_2': text29,
      'cena': text30,
      'colacion_3': text31,
    });

    Report report = Report.init('reports');
    report.indicadoresClinicos = indicadoresClinicosJson.toString();
    report.antecedentesFamiliares = antecedentesFamiliaresJson.toString();
    report.historialGinecologico = historialGinecologicoJson.toString();
    report.estiloVida = estiloVidaJson.toString();
    report.indicadoresDieteticos = indicadoresDieteticosJson.toString();
    report.rutinaDiaria = rutinaDiariaJson.toString();
    report.alimentosCaracteristicas = alimentosCaracteristicasJson.toString();
    report.consumoVariantes = consumoVariantesJson.toString();
    report.dietaHabitual = dietaHabitualJson.toString();
    report.patient =
        Patient(userProvider.user.patientProfile as ResourceObject);

    return report;
  }
}
