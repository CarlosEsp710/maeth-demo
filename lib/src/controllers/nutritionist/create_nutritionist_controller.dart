import 'package:flutter/material.dart';

import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/auth/credentials_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/nutritionist_schema.dart';
import 'package:maeth_demo/src/views/nutritionist/checking_view.dart';

class CreateNutritionistController {
  final CredentialsController _credentials = CredentialsController();
  final ApiController _api =
      ApiController('maeth-unicla.herokuapp.com', '/api/v1');

  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descriptionController = TextEditingController();
  final curriculumController = TextEditingController();
  final identificationCardController = TextEditingController();
  final specialityController = TextEditingController();

  final List<String> specializations = [];

  void createProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final user = Provider.of<UserProvider>(context, listen: false).user;

      final token = await _credentials.getToken();
      _api.addHeader('Authorization', 'Bearer $token');

      Adapter adapter = _api;

      Nutritionist nutritionist = Nutritionist.init('nutritionists');
      nutritionist.phoneNumber = phoneNumberController.text.toString();
      nutritionist.address = addressController.text.toString();
      nutritionist.description = descriptionController.text.toString();
      nutritionist.curriculum = curriculumController.text.toString();
      nutritionist.identificationCard =
          identificationCardController.text.toString();
      nutritionist.specializations = specializations;
      nutritionist.user = user;

      try {
        showLoading(context);

        Nutritionist(await adapter.save(
            'nutritionists', nutritionist.resourceObject) as ResourceObject);
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const CheckingView(),
            type: PageTransitionType.fade,
          ),
          (route) => false,
        );
      } on InvalidRecordException {
        Nutritionist tempNutritionist =
            Nutritionist(nutritionist as ResourceObject);

        _error(context, tempNutritionist.errors.first['detail']);
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
