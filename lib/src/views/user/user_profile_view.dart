import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/controllers/auth/logout_controller.dart';
import 'package:maeth_demo/src/controllers/user/update_user_info_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

final _currentContext = ContextHolder.currentContext;
final _user = Provider.of<UserProvider>(_currentContext).user;

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LogoutController _logoutController = LogoutController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de usuario'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const _UserForm(),
              const SizedBox(height: 20),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'Datos de perfil',
              //     style: TextStyle(
              //       fontSize: 15,
              //       color: Colors.black54,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              // _user.userType == 'Paciente'
              //     ? const _PatientForm()
              //     : const _NutritionistForm(),
              // const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Otras opciones',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GFButton(
                onPressed: () => _logoutController.logout(context),
                text: 'Cerrar sesión',
                color: Colors.red,
                textColor: Colors.red,
                fullWidthButton: true,
                shape: GFButtonShape.square,
                size: GFSize.LARGE,
                type: GFButtonType.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserForm extends StatefulWidget {
  const _UserForm({Key? key}) : super(key: key);

  @override
  State<_UserForm> createState() => __UserFormState();
}

class __UserFormState extends State<_UserForm> {
  final UpdateUserInfoController _userController = UpdateUserInfoController();
  final _user = Provider.of<UserProvider>(_currentContext).user;

  @override
  void initState() {
    _userController.firstNameController.text = _user.firstName;
    _userController.lastNameController.text = _user.lastName;
    _userController.emailController.text = _user.email;
    _userController.genderController.text = _user.gender;
    _userController.gender = _user.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _userController.formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          CircleImage(imagePath: _user.imageProfile),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Datos de usuario',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _userController.firstNameController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Nombre(s)',
              hintText: 'Modificar nombre',
              radius: 5,
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _userController.lastNameController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Apellidos',
              hintText: 'Modificar apellidos',
              radius: 5,
            ),
            validator: (value) => Validator().validateText(value!),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _userController.emailController,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Email',
              hintText: 'Modificar email',
              radius: 5,
            ),
            validator: (value) => Validator().validateEmail(value!),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            value: _userController.gender,
            decoration: MaethInputDecoration().textInputDecoration(
              context: context,
              lableText: 'Sexo',
              hintText: 'Especifica tu sexo',
              radius: 5,
            ),
            onChanged: (String? value) => setState(() {
              _userController.gender = value!;
            }),
            items: _userController.genderList
                .map((value) =>
                    DropdownMenuItem(child: Text(value), value: value))
                .toList(),
            validator: (value) => Validator().validateDropdown(
                _userController.gender, _userController.genderList[0]),
          ),
          const SizedBox(height: 20),
          GFButton(
            onPressed: () => _userController.update(context),
            text: 'Guardar cambios',
            color: const Color(0xff01C473),
            textColor: const Color(0xff01C473),
            fullWidthButton: true,
            shape: GFButtonShape.square,
            size: GFSize.LARGE,
            type: GFButtonType.outline,
          ),
        ],
      ),
    );
  }
}
