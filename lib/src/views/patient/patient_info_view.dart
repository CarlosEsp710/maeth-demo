import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laravel_json_api/laravel_json_api.dart';

import 'package:maeth_demo/src/controllers/patient/get_patient_controller.dart';
import 'package:maeth_demo/src/controllers/report/pdf/pdf_report.dart';
import 'package:maeth_demo/src/schemas/patient_schema.dart';
import 'package:maeth_demo/src/schemas/report_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class PatientInfoView extends StatelessWidget {
  final User user;

  const PatientInfoView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetPatientController _controller = GetPatientController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del paciente'),
      ),
      body: FutureBuilder(
        future: _controller.getPatient(context, user.patientProfileId!),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? _profile(context, snapshot.data)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  ListView _profile(BuildContext context, Patient profile) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      children: <Widget>[
        const SizedBox(height: 24),
        CircleImage(imagePath: user.imageProfile),
        const SizedBox(height: 24),
        buildInfo(user),
        const SizedBox(height: 24),
        PatientStatistics(patient: profile),
        const SizedBox(height: 24),
        ProfileDescription(description: profile.description),
        const SizedBox(height: 24),
        const Text(
          'Historias clínicas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: profile.reports
              .map<Widget>((report) =>
                  _listTileItem(context, Report(report as ResourceObject)))
              .toList(),
        ),
      ],
    );
  }

  _listTileItem(BuildContext context, Report report) {
    return ListTile(
      title: Text('Historía clínica ${report.id}'),
      subtitle: Text('mateth-hc-#${report.id}'),
      leading: CircleAvatar(
        backgroundColor: Colors.pink[400],
        child: const Icon(
          Icons.document_scanner_outlined,
          color: Colors.white,
        ),
      ),
      trailing: const Icon(
        FontAwesomeIcons.filePdf,
        color: Color(0xffFF6B37),
      ),
      onTap: () => reportView(context, report, user),
    );
  }
}
