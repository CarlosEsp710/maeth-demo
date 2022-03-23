import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/patient_schema.dart';
import 'package:maeth_demo/src/views/ui/navigation_view.dart';

class CreatePatientController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descriptionController = TextEditingController();
  final occupationController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String scholarship = "Selecciona tu escolaridad";
  final List<String> scholarshipList = [
    'Selecciona tu escolaridad',
    'Educación preescolar',
    'Educación Primaria',
    'Educación secundaria',
    'Educación media superior',
    'Educación superior',
  ];

  void createProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final userService = Provider.of<UserProvider>(context, listen: false);

      final token = await _credentials.getToken();
      _api.addHeader('Authorization', 'Bearer $token');

      Adapter adapter = _api;

      Patient patient = Patient.init('patients');
      patient.phoneNumber = phoneNumberController.text;
      patient.address = addressController.text;
      patient.description = descriptionController.text;
      patient.scholarship = scholarship;
      patient.occupation = occupationController.text;
      patient.height = double.parse(heightController.text);
      patient.weight = double.parse(weightController.text);
      patient.user = userService.user;
      patient.nutritionist = userService.myNutritionist!;

      try {
        showLoading(context);

        Patient(await adapter.save('patients', patient.resourceObject)
            as ResourceObject);

        Navigator.pop(context);

        await _credentials.saveNutritionistId(
            userService.myNutritionist!.nutritionistProfileId!);

        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const NavigationView(),
            type: PageTransitionType.fade,
          ),
          (route) => false,
        );
      } on InvalidRecordException {
        Patient tempPatient = Patient(patient as ResourceObject);

        _error(context, tempPatient.errors.first['detail']);
      } on NoNetworkError {
        _error(context, 'No tienes conexión a internet');
      } catch (e) {
        _error(context, e.toString());
      }
    }
  }

  _error(BuildContext context, String text) {
    showErrorAlert(context, 'Algo salió mal', text);
  }
}
