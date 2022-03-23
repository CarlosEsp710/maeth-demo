import 'dart:io';

import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/controllers/auth/register_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class RegisterView extends StatelessWidget {
  final String type;

  const RegisterView({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Registrarme como $type ',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _Form(type: type),
            const SizedBox(height: 20),
            const LogoUnicla(color: Color(0xff132E4D)),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final String type;

  const _Form({Key? key, required this.type}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final RegisterController _registerController = RegisterController();

  ImagePicker? _imagePicker;

  @override
  void initState() {
    _imagePicker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerController.registerFormKey,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: _setImage,
            child: _ImagePicker(controller: _registerController),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _registerController.firstNameController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Nombre',
              hintText: 'Ingresa tu nombre completo',
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: _registerController.lastNameController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Apellidos',
              hintText: 'Ingresa tu nombre completo',
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: _registerController.emailController,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Email',
              hintText: 'Introduce tu dirección de correo electrónico',
            ),
            validator: (value) => Validator().validateEmail(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: _registerController.passwordController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Contraseña',
              hintText: 'Ingresa una contraseña',
            ),
            validator: (value) => Validator().validatePassword(value!),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: _registerController.confirmPasswordController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Verifica tu contraseña',
              hintText: 'Repite tu contraseña',
            ),
            validator: (value) => Validator().validateConfirmPassword(
                value!, _registerController.passwordController.text),
          ),
          const SizedBox(height: 30.0),
          DropdownButtonFormField(
            value: _registerController.gender,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Sexo',
              hintText: 'Especifica tu sexo',
            ),
            onChanged: (String? value) => setState(() {
              _registerController.gender = value!;
            }),
            items: _registerController.genderList
                .map((value) =>
                    DropdownMenuItem(child: Text(value), value: value))
                .toList(),
            validator: (value) => Validator().validateDropdown(
                _registerController.gender, _registerController.genderList[0]),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _registerController.dateController,
            autocorrect: true,
            readOnly: true,
            keyboardType: TextInputType.datetime,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Fecha de nacimiento',
              hintText: 'Selecciona tu fecha de nacimiento',
              suffixIcon: true,
              icon: IconButton(
                onPressed: () => _datePicker(context),
                icon: const Icon(Icons.calendar_today_outlined),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            validator: (value) =>
                Validator().validateDate(_registerController.date),
          ),
          const SizedBox(height: 40),
          GFButton(
            onPressed: () => _registerController.register(context, widget.type),
            text: 'Registrarme',
            color: const Color(0xff01C473),
            textColor: Colors.white,
            fullWidthButton: true,
            shape: GFButtonShape.pills,
            size: GFSize.LARGE,
          ),
        ],
      ),
    );
  }

  void _setImage() async {
    XFile? image = await _imagePicker!.pickImage(source: ImageSource.gallery);

    setState(() {
      _registerController.imageProfile = File(image!.path);
    });
  }

  _datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          _registerController.date = value;
          _registerController.dateController.text =
              DateFormat.yMMMd().format(_registerController.date!);
        });
      }
    });
  }
}

class _ImagePicker extends StatelessWidget {
  const _ImagePicker({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            image: (controller.imageProfile != null)
                ? DecorationImage(
                    image: FileImage(controller.imageProfile),
                    fit: BoxFit.fill,
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: (controller.imageProfile == null)
              ? Icon(
                  Icons.person,
                  color: Colors.grey.shade300,
                  size: 80.0,
                )
              : null,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
          child: Icon(
            Icons.add_circle,
            color: (controller.imageProfile == null)
                ? Colors.grey.shade700
                : Colors.white,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}
