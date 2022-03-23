import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/controllers/nutritionist/create_nutritionist_controller.dart';
import 'package:maeth_demo/src/controllers/patient/create_patient_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:maeth_demo/src/views/nutritionist/nutritionist_list_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completar perfil'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Hola ${user.firstName}, ayúdanos a completar la información de tu perfil',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            user.userType == 'Paciente'
                ? const _PatientForm()
                : const _NutritionistForm(),
            const SizedBox(height: 20),
            const LogoUnicla(color: Color(0xff132E4D)),
          ],
        ),
      ),
    );
  }
}

class _PatientForm extends StatefulWidget {
  const _PatientForm({Key? key}) : super(key: key);

  @override
  __PatientFormState createState() => __PatientFormState();
}

class __PatientFormState extends State<_PatientForm> {
  final CreatePatientController _controller = CreatePatientController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Form(
      key: _controller.formKey,
      child: Column(
        children: <Widget>[
          if (userProvider.myNutritionist != null)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nutriólogo',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ),
          const SizedBox(height: 30),
          (userProvider.myNutritionist == null)
              ? GFButton(
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      child: const NutritionistListView(),
                      type: PageTransitionType.bottomToTop,
                    ),
                  ),
                  text: 'Escoger nutriólogo',
                  color: const Color(0xff01C473),
                  textColor: Colors.white,
                  fullWidthButton: true,
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                )
              : _nutritionistListTile(userProvider.myNutritionist!),
          const SizedBox(height: 30),
          if (userProvider.myNutritionist != null)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Datos personales',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ),
          const SizedBox(height: 30),
          if (userProvider.myNutritionist != null)
            TextFormField(
              controller: _controller.phoneNumberController,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Número de teléfono',
                hintText: 'Ingresa tu número de teléfono',
              ),
              validator: (value) => Validator().validateText(value!),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30.0),
          if (userProvider.myNutritionist != null)
            TextFormField(
              autocorrect: true,
              controller: _controller.addressController,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Dirección',
                hintText: 'Ingresa tu dirección',
              ),
              validator: (value) => Validator().validateText(value!),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30.0),
          if (userProvider.myNutritionist != null)
            TextFormField(
              autocorrect: true,
              controller: _controller.descriptionController,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Añade una descripción sobre ti',
                hintText: '',
              ),
              validator: (value) => Validator().validateText(value!),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30),
          if (userProvider.myNutritionist != null)
            TextFormField(
              autocorrect: true,
              controller: _controller.occupationController,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Ocupación',
                hintText: 'Dinos a que te dedicas',
              ),
              validator: (value) => Validator().validateText(value!),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30),
          if (userProvider.myNutritionist != null)
            DropdownButtonFormField(
              value: _controller.scholarship,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Escolaridad',
                hintText: 'Escolaridad',
              ),
              onChanged: (String? value) => setState(() {
                _controller.scholarship = value!;
              }),
              items: _controller.scholarshipList
                  .map((value) =>
                      DropdownMenuItem(child: Text(value), value: value))
                  .toList(),
              validator: (value) => Validator().validateDropdown(
                  _controller.scholarship, _controller.scholarshipList[0]),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30),
          if (userProvider.myNutritionist != null)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Datos médicos',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 15),
          if (userProvider.myNutritionist != null)
            TextFormField(
              controller: _controller.weightController,
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Peso',
                hintText: 'Ingresa tu peso (60.5)',
              ),
              validator: (value) => Validator().validateDigit(value!),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30.0),
          if (userProvider.myNutritionist != null)
            TextFormField(
              autocorrect: true,
              controller: _controller.heightController,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                context: context,
                lableText: 'Altura',
                hintText: 'Ingresa tu altura (1.70)',
              ),
              validator: (value) => Validator().validateDigit(value!),
            ),
          if (userProvider.myNutritionist != null) const SizedBox(height: 30),
          if (userProvider.myNutritionist != null)
            GFButton(
              onPressed: () => _controller.createProfile(context),
              text: 'Completar perfil',
              color: const Color(0xff01C473),
              textColor: Colors.white,
              fullWidthButton: true,
              shape: GFButtonShape.pills,
              size: GFSize.LARGE,
            ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _nutritionistListTile(User user) => ListTile(
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: const Text('Toca para cambiar'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.imageProfile),
        ),
        trailing: const Icon(
          Icons.verified,
          color: Colors.blueAccent,
        ),
      );
}

class _NutritionistForm extends StatefulWidget {
  const _NutritionistForm({Key? key}) : super(key: key);

  @override
  __NutritionistFormState createState() => __NutritionistFormState();
}

class __NutritionistFormState extends State<_NutritionistForm> {
  final CreateNutritionistController _controller =
      CreateNutritionistController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _controller.phoneNumberController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Número de teléfono',
              hintText: 'Ingresa tu número de teléfono',
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            autocorrect: true,
            controller: _controller.addressController,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Dirección',
              hintText: 'Ingresa tu dirección',
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            autocorrect: true,
            controller: _controller.descriptionController,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Añade una descripción sobre ti',
              hintText: '',
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Datos profesionales',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _controller.curriculumController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Curriculum URL',
              hintText: 'Ingresa la url de tu curriculum',
            ),
            validator: (value) => Validator().validateUrl(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: _controller.identificationCardController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Cédula Profesional',
              hintText: 'Ingresa tu cédula profesional',
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: _controller.specialityController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Presiona el botón para agregar una especialidad',
              hintText: 'Agregar especialidad',
              suffixIcon: true,
              icon: IconButton(
                onPressed: () {
                  var specialization = _controller.specialityController;
                  var specializations = _controller.specializations;

                  if (specialization.text.isNotEmpty) {
                    specializations.add(specialization.text);
                    specialization.text = "";
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.add),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            validator: (value) =>
                Validator().validateList(_controller.specializations),
          ),
          const SizedBox(height: 30.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: _controller.specializations
                .map((specialization) => _buildChip(specialization))
                .toList(),
          ),
          const SizedBox(height: 30.0),
          GFButton(
            onPressed: () => {},
            text: 'Completar registro',
            color: Colors.white,
            textColor: Colors.black,
            fullWidthButton: true,
            shape: GFButtonShape.pills,
            size: GFSize.LARGE,
          ),
          GFButton(
            onPressed: () => _controller.createProfile(context),
            text: 'Completar perfil',
            color: const Color(0xff01C473),
            textColor: Colors.white,
            fullWidthButton: true,
            shape: GFButtonShape.pills,
            size: GFSize.LARGE,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return ActionChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(8.0),
      onPressed: () {
        _controller.specializations.remove(label);
        setState(() {});
      },
    );
  }
}
