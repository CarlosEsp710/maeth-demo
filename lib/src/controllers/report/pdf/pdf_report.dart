import 'dart:io';

import 'package:flutter/material.dart' as material;
import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:maeth_demo/src/controllers/report/responses/alimentos_caracteristicas.dart';
import 'package:maeth_demo/src/controllers/report/responses/antecedentes_familiares.dart';
import 'package:maeth_demo/src/controllers/report/responses/antecedentes_ginecologicos.dart';
import 'package:maeth_demo/src/controllers/report/responses/consumo_variantes.dart';
import 'package:maeth_demo/src/controllers/report/responses/dieta_habitual.dart';
import 'package:maeth_demo/src/controllers/report/responses/estilo_vida.dart';
import 'package:maeth_demo/src/controllers/report/responses/indicadores_clinicos.dart';
import 'package:maeth_demo/src/controllers/report/responses/indicadores_dieteticos.dart';
import 'package:maeth_demo/src/controllers/report/responses/rutina_diaira.dart';

import 'package:maeth_demo/src/helpers/helpers.dart';

import 'package:maeth_demo/src/schemas/patient_schema.dart';
import 'package:maeth_demo/src/schemas/report_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';

import 'package:maeth_demo/src/views/report/pdf/report_pdf_viewer.dart';

reportView(
  material.BuildContext context,
  Report report,
  User user,
) async {
  final Document pdf = Document();

  final age = calculateAge(DateTime.parse(user.birthday));
  final Patient patient = Patient(user.patientProfile as ResourceObject);

  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return Text(
            'ID: #maeth-hc-${report.id}',
            style: Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.blueGrey),
          );
        }
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: PdfColors.grey, width: 0.5 * PdfPageFormat.mm),
            ),
          ),
          child: Text(
            'Historia clínica',
            style: Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.grey),
          ),
        );
      },
      footer: (Context context) {
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
          child: Text(
            'Página ${context.pageNumber} de ${context.pagesCount}',
            style: Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.grey),
          ),
        );
      },
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Historia clínica', textScaleFactor: 2),
              PdfLogo(),
            ],
          ),
        ),
        Header(level: 1, text: 'Datos generales'),
        Paragraph(
          text:
              'Nombre del paciente: ${user.firstName} ${user.lastName}\nEdad: $age años\nSexo: ${user.gender}\nPeso: ${patient.weight} Kg.\nEstatura: ${patient.height} m',
        ),
        Header(level: 1, text: 'Indicadores clínicos'),
        _indicadoresClinicos(context, report),
        Header(level: 1, text: 'Antecedentes familiares'),
        _antecedentesFamiliares(context, report),
        if (user.gender == 'Femenino')
          Header(level: 1, text: 'Historial ginecológico'),
        if (user.gender == 'Femenino')
          _antecedentesGinecologicos(context, report),
        Header(level: 1, text: 'Estilo de vida'),
        _estiloVida(context, report),
        Header(level: 1, text: 'Rutina diaria'),
        _rutinaDiaria(context, report),
        Header(level: 1, text: 'Indicadores dietéticos'),
        _indicadoresDieteticos(context, report),
        Header(level: 1, text: 'Alimentos y características'),
        _alimentosCaracteristicas(context, report),
        Header(level: 1, text: 'Consumo y variantes'),
        _consumoVariantes(context, report),
        Header(level: 1, text: 'Dieta habitual'),
        _dietaHabitual(context, report),
      ],
    ),
  );
  //save PDF

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  file.writeAsBytes(List.from(await pdf.save()));
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => ReportPDFViewer(path: path),
    ),
  );
}

_indicadoresClinicos(context, report) {
  final indicadoresClinicos =
      indicadoresClinicosFromJson(report.indicadoresClinicos);

  final sintomas = indicadoresClinicos.indicadoresClinicos.listaIndicadores;
  final enfermedad = indicadoresClinicos.enfermedadDiagnosticada;
  final medicamento = indicadoresClinicos.medicamentos;
  final productos = indicadoresClinicos.productos.listaProductos;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('¿Presenta alguno de los siguientes síntomas?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Síntoma', 'Sí', 'No'],
          ...sintomas.map((sintoma) {
            return <String>[
              sintoma.name,
              sintoma.value ? 'X' : '',
              sintoma.value == false ? 'X' : '',
            ];
          }).toList()
        ],
      ),
      SizedBox(height: 10),
      Text('Otro: ${indicadoresClinicos.indicadoresClinicos.otro}'),
      SizedBox(height: 10),
      Text('¿Tiene alguna enfermedad diagnosticada?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí', 'No', 'Especifique'],
          <String>[
            enfermedad.value == 1 ? 'X' : '',
            enfermedad.value != 1 ? 'X' : '',
            enfermedad.especifique,
          ],
        ],
      ),
      SizedBox(height: 30),
      Text('¿Toma algún medicamento?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí', 'No', 'Cuál medicamento'],
          <String>[
            medicamento.value == 1 ? 'X' : '',
            medicamento.value != 1 ? 'X' : '',
            medicamento.especifique,
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Consume actualmente alguno de estos productos?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Síntoma', 'Sí', 'No'],
          ...productos.map((producto) {
            return <String>[
              producto.name,
              producto.value ? 'X' : '',
              producto.value == false ? 'X' : '',
            ];
          }).toList()
        ],
      ),
      SizedBox(height: 10),
      Text('Otro: ${indicadoresClinicos.productos.otro}'),
    ],
  );
}

_antecedentesFamiliares(context, report) {
  final antecedentesFamiliares =
      antecedentesFamiliaresFromJson(report.antecedentesFamiliares);

  final obesidad = antecedentesFamiliares.obesidad;
  final cancer = antecedentesFamiliares.cancer;
  final diabetes = antecedentesFamiliares.diabetes;
  final hipercolesterolemia = antecedentesFamiliares.hipercolesterolemia;
  final hipertrigliceridemia = antecedentesFamiliares.hipertrigliceridemia;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('¿Alguno de tus familiares padece alguna de estas enfermedades?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Enfermedad', 'Sí', 'No', 'Parentezco'],
          <String>[
            'Obesidad',
            obesidad.value == 1 ? 'X' : '',
            obesidad.value != 1 ? 'X' : '',
            obesidad.parentezco
          ],
          <String>[
            'Cáncer',
            cancer.value == 1 ? 'X' : '',
            cancer.value != 1 ? 'X' : '',
            cancer.parentezco
          ],
          <String>[
            'Diabetes',
            diabetes.value == 1 ? 'X' : '',
            diabetes.value != 1 ? 'X' : '',
            diabetes.parentezco
          ],
          <String>[
            'Hipercolesterolemia',
            hipercolesterolemia.value == 1 ? 'X' : '',
            hipercolesterolemia.value != 1 ? 'X' : '',
            hipercolesterolemia.parentezco
          ],
          <String>[
            'Hipertrigliceridemia',
            hipertrigliceridemia.value == 1 ? 'X' : '',
            hipertrigliceridemia.value != 1 ? 'X' : '',
            hipertrigliceridemia.parentezco
          ],
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}

_antecedentesGinecologicos(context, report) {
  final antecedentes =
      antecedentesGinecologicosFromJson(report.historialGinecologico);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('¿Está embarazada actualmente?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', 'Especifique meses de embarazo'],
          <String>[
            antecedentes.embarazo.value == 1 ? 'Sí' : 'No',
            antecedentes.embarazo.especifique,
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Usas anticonceptivos?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', 'Especifique'],
          <String>[
            antecedentes.anticonceptivos.value == 1 ? 'Sí' : 'No',
            antecedentes.anticonceptivos.especifique,
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Pacedes climaterio?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', 'Especifique'],
          <String>[
            antecedentes.climaterio.value == 1 ? 'Sí' : 'No',
            antecedentes.climaterio.especifique,
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Lleva a cabo algún tratamiento de reemplazo hormonal?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', 'Especifique'],
          <String>[
            antecedentes.tratamientoHormonal.value == 1 ? 'Sí' : 'No',
            antecedentes.tratamientoHormonal.especifique,
          ],
        ],
      ),
    ],
  );
}

_estiloVida(context, report) {
  final estiloVida = estiloVidaFromJson(report.estiloVida);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Tipo de actividad física: ${estiloVida.actividadFisica.value}'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['¿Haces ejercicio?', 'Tipo', 'Días', 'Duración'],
          <String>[
            estiloVida.ejercicio.value == 1 ? 'Sí' : 'No',
            estiloVida.ejercicio.tipo,
            '${estiloVida.ejercicio.dias} días a la semana',
            estiloVida.ejercicio.duracion,
          ],
        ],
      ),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>[
            '¿Cosumes alguno de los siguientes productos?',
            'Sí/No',
            'Cuánto'
          ],
          <String>[
            'Café',
            estiloVida.cafe.value == 1 ? 'Sí' : 'No',
            estiloVida.cafe.especifique,
          ],
          <String>[
            'Cigarrillos',
            estiloVida.fumar.value == 1 ? 'Sí' : 'No',
            estiloVida.fumar.especifique,
          ],
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}

_rutinaDiaria(context, report) {
  final rutinaDiaria = rutinaDiariaFromJson(report.rutinaDiaria);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Actividad', 'Hora del día'],
          <String>['Hora que me levanto', '${rutinaDiaria.horaLevntarse} hrs'],
          <String>['Desayuno', '${rutinaDiaria.desayuno} hrs'],
          <String>['Comida', '${rutinaDiaria.comida} hrs'],
          <String>['Cena', '${rutinaDiaria.cena} hrs'],
          <String>['Hora que me acuesto', '${rutinaDiaria.horaDormir} hrs'],
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}

_indicadoresDieteticos(context, report) {
  var indicadoresDieteticos =
      indicadoresDieteticosFromJson(report.indicadoresDieteticos);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('¿Cuántas comidas tienes al día?'),
      SizedBox(height: 10),
      Text('${indicadoresDieteticos.comidasDia}'),
      SizedBox(height: 10),
      Text('¿Quién prepara sus alimentos?'),
      SizedBox(height: 10),
      Text(indicadoresDieteticos.persona),
      SizedBox(height: 10),
      Text('Comidas de entre semana'),
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          Table.fromTextArray(
            context: context,
            data: <List<dynamic>>[
              <String>['Comidas en casa', 'Horario'],
              <String>[
                '${indicadoresDieteticos.comidasCasaEntreSemana.value}',
                indicadoresDieteticos.comidasCasaEntreSemana.time,
              ],
            ],
          ),
          SizedBox(width: 10),
          Table.fromTextArray(
            context: context,
            data: <List<dynamic>>[
              <String>['Comidas fuera de casa', 'Horario'],
              <String>[
                '${indicadoresDieteticos.comidasFueraCasaEntreSemana.value}',
                indicadoresDieteticos.comidasFueraCasaEntreSemana.time,
              ],
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Text('Comidas del fin de semana'),
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          Table.fromTextArray(
            context: context,
            data: <List<dynamic>>[
              <String>['Comidas en casa', 'Horario'],
              <String>[
                '${indicadoresDieteticos.comidasCasaFinSemana.value}',
                indicadoresDieteticos.comidasCasaFinSemana.time,
              ],
            ],
          ),
          SizedBox(width: 10),
          Table.fromTextArray(
            context: context,
            data: <List<dynamic>>[
              <String>['Comidas fuera de casa', 'Horario'],
              <String>[
                '${indicadoresDieteticos.comidasFueraCasaFinSemana.value}',
                indicadoresDieteticos.comidasFueraCasaFinSemana.time,
              ],
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Text('¿Cómo es mi apetito?'),
      SizedBox(height: 10),
      Text(indicadoresDieteticos.apetito),
      SizedBox(height: 10),
      Text('¿En qué horario tiene más hambre?'),
      SizedBox(height: 10),
      Text(indicadoresDieteticos.hambre),
      SizedBox(height: 10),
      Text('Especifique por qué tiene más hambre en ese horario'),
      SizedBox(height: 10),
      Text(indicadoresDieteticos.especifique),
      SizedBox(height: 10),
    ],
  );
}

_alimentosCaracteristicas(context, report) {
  final alimentos =
      alimentosCaracteristicasFromJson(report.alimentosCaracteristicas);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Alimentos', 'Especificaciones'],
          <String>['Alimentos preferidos', alimentos.alimentosPreferidos],
          <String>[
            'Alimentos que no te agradan o no acostumbras',
            alimentos.alimentosNoAgradan
          ],
          <String>[
            'Alimentos que te causan malestar',
            alimentos.alimentosMalestar
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Tienes alergia a algún alimento?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', 'Especifique'],
          <String>[
            alimentos.alimentosAlergias.value == 1 ? 'Sí' : 'No',
            alimentos.alimentosAlergias.detalles,
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Tomas algún suplemento alimenticio?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', 'Especifique'],
          <String>[
            alimentos.suplementos.value == 1 ? 'Sí' : 'No',
            alimentos.suplementos.detalles,
          ],
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}

_consumoVariantes(context, report) {
  final consumo = consumoVariantesFromJson(report.consumoVariantes);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('¿Agrega sal a las comidas ya preparadas?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', '¿Qué tipo de sal?'],
          <String>[consumo.sal.value == 1 ? 'Sí' : 'No', consumo.sal.detalles],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Ha llevado alguna dieta especial?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', '¿Cuál dieta?'],
          <String>[
            consumo.dietaEspecial.value == 1 ? 'Sí' : 'No',
            consumo.dietaEspecial.detalles
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Ha utilizado algún tratamiento para bajar de eso?'),
      SizedBox(height: 10),
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Sí / No', '¿Cuál tratamiento?'],
          <String>[
            consumo.tratamientoPerderPeso.value == 1 ? 'Sí' : 'No',
            consumo.tratamientoPerderPeso.detalles
          ],
        ],
      ),
      SizedBox(height: 10),
      Text('¿Qué tipo de aceite utilizas para cocinar?'),
      SizedBox(height: 10),
      Text(consumo.aceites),
      SizedBox(height: 10),
    ],
  );
}

_dietaHabitual(context, report) {
  final dieta = dietaHabitialFromJson(report.dietaHabitual);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Table.fromTextArray(
        context: context,
        data: <List<dynamic>>[
          <String>['Comida', 'Descripción'],
          <String>['Desayuno', dieta.desayuno],
          <String>['Colación', dieta.colacion1],
          <String>['Comida', dieta.comida],
          <String>['Colación', dieta.colacion2],
          <String>['Cena', dieta.cena],
          <String>['Colación', dieta.colacion3],
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}
