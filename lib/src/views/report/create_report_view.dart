import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/controllers/report/const.dart';
import 'package:maeth_demo/src/controllers/report/create_report_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class CreateReportView extends StatelessWidget {
  const CreateReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateReportController controller = CreateReportController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva historia clínica'),
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            const _SlideForm(),
            _Button(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _SlideForm extends StatelessWidget {
  const _SlideForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    return Expanded(
      child: Slideshow(
        topDots: true,
        primaryColor: const Color(0xff4FCC8A),
        secondaryColor: const Color(0xffC4C4C4),
        primaryBullet: 50,
        secondaryBullet: 30,
        height: 3,
        padding: 15,
        shape: BoxShape.rectangle,
        slides: [
          const _Form1(),
          if (user.gender == 'Femenino') const _Form2(),
          const _Form3(),
          const _Form4(),
          const _Form5(),
          const _Form6(),
        ],
      ),
    );
  }
}

// Forms
class _Form1 extends StatefulWidget {
  const _Form1({Key? key}) : super(key: key);

  @override
  __Form1State createState() => __Form1State();
}

class __Form1State extends State<_Form1> {
  CreateReportController controller = CreateReportController();

  @override
  void initState() {
    super.initState();
    controller.textController1
        .addListener(() => text1 = controller.textController1.text);
    controller.textController2
        .addListener(() => text2 = controller.textController2.text);
    controller.textController3
        .addListener(() => text3 = controller.textController3.text);
    controller.textController4
        .addListener(() => text4 = controller.textController4.text);
    controller.textController5
        .addListener(() => text5 = controller.textController5.text);
    controller.textController6
        .addListener(() => text6 = controller.textController6.text);
    controller.textController7
        .addListener(() => text7 = controller.textController7.text);
    controller.textController8
        .addListener(() => text8 = controller.textController8.text);
    controller.textController9
        .addListener(() => text9 = controller.textController9.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              const _Title(text: 'Indicadores Clínicos'),
              const _Separator(
                  text: '¿Presenta alguno de los siguientes síntomas?'),
              _indicators(),
              const _Subtitle(text: 'Otro síntoma'),
              TextFormField(
                controller: controller.textController1,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: 'Espeficique',
                ),
              ),
              const _Separator(
                  text: '¿Tiene alguna enfermedad diagnosticada? *'),
              _radioGroup1(),
              if (radioGroup1 == 1)
                const _Subtitle(text: '¿Cuál enfermedad? *'),
              if (radioGroup1 == 1)
                TextFormField(
                  controller: controller.textController2,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup1 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Separator(text: '¿Toma algún medicamento? *'),
              _radioGroup2(),
              if (radioGroup2 == 1)
                const _Subtitle(text: '¿Cuál medicamento? *'),
              if (radioGroup2 == 1)
                TextFormField(
                  controller: controller.textController3,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup2 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Separator(
                  text: '¿Consume actualemte alguno de estos productos?'),
              _products(),
              const _Subtitle(text: 'Otro medicamento'),
              TextFormField(
                controller: controller.textController4,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: 'Espeficique',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              const _Title(text: 'Antecedentes familiares'),
              const _Separator(
                  text:
                      '¿Alguno de tus familiares padece alguna de estas enfermedades?'),
              const _Subtitle(text: 'Obecidad *'),
              _radioGroup3(),
              if (radioGroup3 == 1)
                const _Subtitle(text: 'Especifique parentezco *'),
              if (radioGroup3 == 1)
                TextFormField(
                  controller: controller.textController5,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup3 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Subtitle(text: 'Diabetes *'),
              _radioGroup4(),
              if (radioGroup4 == 1)
                const _Subtitle(text: 'Especifique parentezco *'),
              if (radioGroup4 == 1)
                TextFormField(
                  controller: controller.textController6,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup4 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Subtitle(text: 'Cáncer *'),
              _radioGroup5(),
              if (radioGroup5 == 1)
                const _Subtitle(text: 'Especifique parentezco *'),
              if (radioGroup5 == 1)
                TextFormField(
                  controller: controller.textController7,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup5 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Subtitle(text: 'Hipercolesterolemia *'),
              _radioGroup6(),
              if (radioGroup6 == 1)
                const _Subtitle(text: 'Especifique parentezco *'),
              if (radioGroup6 == 1)
                TextFormField(
                  controller: controller.textController8,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup6 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Subtitle(text: 'Hipertrigliceridemia *'),
              _radioGroup7(),
              if (radioGroup7 == 1)
                const _Subtitle(text: 'Especifique parentezco *'),
              if (radioGroup7 == 1)
                TextFormField(
                  controller: controller.textController9,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup7 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioGroup1() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup1,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup1 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup1,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup1 = value),
        ),
      ],
    );
  }

  Widget _radioGroup2() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup2,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup2 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup2,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup2 = value),
        ),
      ],
    );
  }

  Widget _radioGroup3() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup3,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup3 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup3,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup3 = value),
        ),
      ],
    );
  }

  Widget _radioGroup4() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup4,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup4 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup4,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup4 = value),
        ),
      ],
    );
  }

  Widget _radioGroup5() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup5,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup5 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup5,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup5 = value),
        ),
      ],
    );
  }

  Widget _radioGroup6() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup6,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup6 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup6,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup6 = value),
        ),
      ],
    );
  }

  Widget _radioGroup7() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup7,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup7 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup7,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup7 = value),
        ),
      ],
    );
  }

  Widget _indicators() {
    return Column(
      children: indicatorsList
          .map(
            (ClinicalIndicator indicator) => GFCheckboxListTile(
              titleText: indicator.name,
              size: 20,
              type: GFCheckboxType.circle,
              value: indicator.value,
              activeIcon: const Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              ),
              onChanged: (value) => setState(() => indicator.value = value),
            ),
          )
          .toList(),
    );
  }

  Widget _products() {
    return Column(
      children: productsList
          .map(
            (MedicalProduct product) => GFCheckboxListTile(
              titleText: product.name,
              size: 20,
              type: GFCheckboxType.circle,
              value: product.value,
              activeIcon: const Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              ),
              onChanged: (value) => setState(() => product.value = value),
            ),
          )
          .toList(),
    );
  }
}

class _Form2 extends StatefulWidget {
  const _Form2({Key? key}) : super(key: key);

  @override
  __Form2State createState() => __Form2State();
}

class __Form2State extends State<_Form2> {
  CreateReportController controller = CreateReportController();

  @override
  void initState() {
    super.initState();
    controller.textController10
        .addListener(() => text10 = controller.textController10.text);
    controller.textController11
        .addListener(() => text11 = controller.textController11.text);
    controller.textController12
        .addListener(() => text12 = controller.textController12.text);
    controller.textController13
        .addListener(() => text13 = controller.textController13.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          const _Title(text: 'Antecedentes ginecológicos'),
          const _Separator(text: '¿Estás embarazada actualmente? *'),
          _radioGroup8(),
          if (radioGroup8 == 1)
            const _Subtitle(text: 'Especifique meses de embarazo *'),
          if (radioGroup8 == 1)
            TextFormField(
              controller: controller.textController10,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textReportDecoration(
                context: context,
                lableText: 'Especifique',
                hintText: 'Espeficique',
              ),
              validator: (value) {
                if (radioGroup8 == 1) {
                  return Validator().validateText(value!);
                }
              },
            ),
          const _Separator(text: '¿Usa anticonceptivos? *'),
          _radioGroup9(),
          if (radioGroup9 == 1) const _Subtitle(text: 'Especifique tipo *'),
          if (radioGroup9 == 1)
            TextFormField(
              controller: controller.textController11,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textReportDecoration(
                context: context,
                lableText: 'Especifique',
                hintText: 'Espeficique',
              ),
              validator: (value) {
                if (radioGroup9 == 1) {
                  return Validator().validateText(value!);
                }
              },
            ),
          const _Separator(text: '¿Padeces climaterio? *'),
          _radioGroup10(),
          if (radioGroup10 == 1)
            const _Subtitle(text: 'Especifique síntomas *'),
          if (radioGroup10 == 1)
            TextFormField(
              controller: controller.textController12,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textReportDecoration(
                context: context,
                lableText: 'Especifique',
                hintText: 'Espeficique',
              ),
              validator: (value) {
                if (radioGroup10 == 1) {
                  return Validator().validateText(value!);
                }
              },
            ),
          const _Separator(
              text: '¿Lleva a cabo un tratamiento de reemplazo hormonal? *'),
          _radioGroup11(),
          if (radioGroup11 == 1) const _Subtitle(text: 'Especifique *'),
          if (radioGroup11 == 1)
            TextFormField(
              controller: controller.textController13,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textReportDecoration(
                context: context,
                lableText: 'Especifique',
                hintText: 'Espeficique',
              ),
              validator: (value) {
                if (radioGroup11 == 1) {
                  return Validator().validateText(value!);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _radioGroup8() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup8,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup8 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup8,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup8 = value),
        ),
      ],
    );
  }

  Widget _radioGroup9() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup9,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup9 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup9,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup9 = value),
        ),
      ],
    );
  }

  Widget _radioGroup10() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup10,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup10 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup10,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup10 = value),
        ),
      ],
    );
  }

  Widget _radioGroup11() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup11,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup11 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup11,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup11 = value),
        ),
      ],
    );
  }
}

class _Form3 extends StatefulWidget {
  const _Form3({Key? key}) : super(key: key);

  @override
  __Form3State createState() => __Form3State();
}

class __Form3State extends State<_Form3> {
  CreateReportController controller = CreateReportController();

  @override
  void initState() {
    super.initState();
    controller.textController14
        .addListener(() => text14 = controller.textController14.text);
    controller.textController15
        .addListener(() => text15 = controller.textController15.text);
    controller.textController16
        .addListener(() => text16 = controller.textController16.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          const _Title(text: 'Estilo de vida'),
          const _Separator(text: '¿Cómo es tu actividad física? *'),
          DropdownButtonFormField(
            value: lifestyle,
            decoration: MaethInputDecoration().textReportDecoration(
              context: context,
              lableText: 'Actividad física',
              hintText: 'Actividad física',
            ),
            onChanged: (String? value) => setState(() {
              lifestyle = value!;
            }),
            items: lifestyleList
                .map((value) =>
                    DropdownMenuItem(child: Text(value), value: value))
                .toList(),
            validator: (value) =>
                Validator().validateDropdown(lifestyle, lifestyleList[0]),
          ),
          const _Separator(text: '¿Haces ejercicio? *'),
          _radioGroup12(),
          if (radioGroup12 == 1) excercise(),
          const _Separator(text: '¿Fumas? *'),
          _radioGroup13(),
          if (radioGroup13 == 1) const _Subtitle(text: 'Cuánto *'),
          if (radioGroup13 == 1)
            TextFormField(
              controller: controller.textController15,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textReportDecoration(
                context: context,
                lableText: 'Especifique',
                hintText: 'Espeficique',
              ),
              validator: (value) {
                if (radioGroup13 == 1) {
                  return Validator().validateText(value!);
                }
              },
            ),
          const _Separator(text: '¿Tomas café? *'),
          _radioGroup14(),
          if (radioGroup14 == 1) const _Subtitle(text: 'Cuánto *'),
          if (radioGroup14 == 1)
            TextFormField(
              controller: controller.textController16,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textReportDecoration(
                context: context,
                lableText: 'Especifique',
                hintText: 'Espeficique',
              ),
              validator: (value) {
                if (radioGroup14 == 1) {
                  return Validator().validateText(value!);
                }
              },
            ),
        ],
      ),
    );
  }

  Column excercise() => Column(
        children: <Widget>[
          const _Subtitle(text: 'Tipo *'),
          TextFormField(
            controller: controller.textController14,
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: MaethInputDecoration().textReportDecoration(
              context: context,
              lableText: 'Especifique',
              hintText: 'Espeficique',
            ),
            validator: (value) {
              if (radioGroup12 == 1) {
                return Validator().validateText(value!);
              }
            },
          ),
          const SizedBox(height: 15),
          const _Subtitle(text: 'Días a la semana *'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GFIconButton(
                icon: const Icon(
                  FontAwesomeIcons.minus,
                  color: GFColors.PRIMARY,
                  size: 15,
                ),
                type: GFButtonType.transparent,
                onPressed: () {
                  if (excerciseDays > 1) {
                    excerciseDays--;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(width: 16),
              GFButton(
                onPressed: null,
                text: '$excerciseDays',
                type: GFButtonType.outline2x,
              ),
              const SizedBox(width: 16),
              GFIconButton(
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  color: GFColors.PRIMARY,
                  size: 15,
                ),
                type: GFButtonType.transparent,
                onPressed: () {
                  if (excerciseDays < 7) {
                    excerciseDays++;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField(
            value: time,
            decoration: MaethInputDecoration().textReportDecoration(
              context: context,
              lableText: 'Duración',
              hintText: 'Duración',
            ),
            onChanged: (String? value) => setState(() {
              time = value!;
            }),
            items: timeList
                .map((value) =>
                    DropdownMenuItem(child: Text(value), value: value))
                .toList(),
            validator: (value) {
              if (radioGroup12 == 1) {
                return Validator().validateDropdown(time, timeList[0]);
              }
            },
          ),
        ],
      );

  Widget _radioGroup12() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup12,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup12 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup12,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup12 = value),
        ),
      ],
    );
  }

  Widget _radioGroup13() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup13,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup13 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup13,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup13 = value),
        ),
      ],
    );
  }

  Widget _radioGroup14() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup14,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup14 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup14,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup14 = value),
        ),
      ],
    );
  }
}

class _Form4 extends StatefulWidget {
  const _Form4({Key? key}) : super(key: key);

  @override
  __Form4State createState() => __Form4State();
}

class __Form4State extends State<_Form4> {
  CreateReportController controller = CreateReportController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            children: <Widget>[
              const _Title(text: 'Mi rutina diaria'),
              const _Separator(text: 'Hora que me despierto *'),
              TextFormField(
                controller: controller.timeController1,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker1(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time1),
              ),
              const _Separator(text: 'Hora que desayuno *'),
              TextFormField(
                controller: controller.timeController2,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker2(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time2),
              ),
              const _Separator(text: 'Hora que como *'),
              TextFormField(
                controller: controller.timeController3,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker3(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time3),
              ),
              const _Separator(text: 'Hora que ceno *'),
              TextFormField(
                controller: controller.timeController4,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker4(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time4),
              ),
              const _Separator(text: 'Hora en que voy a dormir *'),
              TextFormField(
                controller: controller.timeController5,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker5(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time5),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              const _Title(text: 'Indicadores dietéticos'),
              const _Separator(text: '¿Cuántas comidas tienes al día? *'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.minus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      if (mealsAtDay > 0) {
                        mealsAtDay--;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  GFButton(
                    onPressed: null,
                    text: '$mealsAtDay',
                    type: GFButtonType.outline2x,
                  ),
                  const SizedBox(width: 16),
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      mealsAtDay++;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const _Subtitle(text: '¿Quién prepara tus alimentos? *'),
              const SizedBox(height: 15),
              DropdownButtonFormField(
                value: person,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Seleccione uno',
                  hintText: 'Seleccione uno',
                ),
                onChanged: (String? value) => setState(() {
                  person = value!;
                }),
                items: personsList
                    .map((value) =>
                        DropdownMenuItem(child: Text(value), value: value))
                    .toList(),
                validator: (value) =>
                    Validator().validateDropdown(person, personsList[0]),
              ),
              const _Separator(text: 'De mis comidas estre semana'),
              const _Subtitle(text: '¿Cuántas comidas comes en casa? *'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.minus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      if (mealsInHouseWeekday > 0) {
                        mealsInHouseWeekday--;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  GFButton(
                    onPressed: null,
                    text: '$mealsInHouseWeekday',
                    type: GFButtonType.outline2x,
                  ),
                  const SizedBox(width: 16),
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      mealsInHouseWeekday++;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const _Subtitle(text: '¿En qué horario? *'),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.timeController6,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker6(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time6),
              ),
              const SizedBox(height: 15),
              const _Subtitle(text: '¿Cuántas comidas comes fuera casa? *'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.minus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      if (mealsOutHouseWeekday > 0) {
                        mealsOutHouseWeekday--;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  GFButton(
                    onPressed: null,
                    text: '$mealsOutHouseWeekday',
                    type: GFButtonType.outline2x,
                  ),
                  const SizedBox(width: 16),
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      mealsOutHouseWeekday++;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const _Subtitle(text: '¿En qué horario? *'),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.timeController7,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker7(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time7),
              ),
              const _Separator(text: 'De mis comidas del fin de semana'),
              const _Subtitle(text: '¿Cuántas comidas comes en casa? *'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.minus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      if (mealsInHouseWeekend > 0) {
                        mealsInHouseWeekend--;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  GFButton(
                    onPressed: null,
                    text: '$mealsInHouseWeekend',
                    type: GFButtonType.outline2x,
                  ),
                  const SizedBox(width: 16),
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      mealsInHouseWeekend++;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const _Subtitle(text: '¿En qué horario? *'),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.timeController8,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker8(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time8),
              ),
              const SizedBox(height: 15),
              const _Subtitle(text: '¿Cuántas comidas comes fuera casa? *'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.minus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      if (mealsOutHouseWeekend > 0) {
                        mealsOutHouseWeekend--;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  GFButton(
                    onPressed: null,
                    text: '$mealsOutHouseWeekend',
                    type: GFButtonType.outline2x,
                  ),
                  const SizedBox(width: 16),
                  GFIconButton(
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: GFColors.PRIMARY,
                      size: 15,
                    ),
                    type: GFButtonType.transparent,
                    onPressed: () {
                      mealsOutHouseWeekend++;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const _Subtitle(text: '¿En qué horario? *'),
              const SizedBox(height: 15),
              TextFormField(
                controller: controller.timeController9,
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.datetime,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Hora',
                  hintText: 'Hora',
                  suffixIcon: true,
                  icon: IconButton(
                    onPressed: () => _timePicker9(context),
                    icon: const Icon(Icons.alarm),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
                validator: (value) => Validator().validateTime(time9),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _timePicker1(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time1 = value;
          controller.timeController1.text = '${time1!.hour}:${time1!.minute}';
        });
      }
    });
  }

  _timePicker2(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time2 = value;
          controller.timeController2.text = '${time2!.hour}:${time2!.minute}';
        });
      }
    });
  }

  _timePicker3(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time3 = value;
          controller.timeController3.text = '${time3!.hour}:${time3!.minute}';
        });
      }
    });
  }

  _timePicker4(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time4 = value;
          controller.timeController4.text = '${time4!.hour}:${time4!.minute}';
        });
      }
    });
  }

  _timePicker5(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time5 = value;
          controller.timeController5.text = '${time5!.hour}:${time5!.minute}';
        });
      }
    });
  }

  _timePicker6(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time6 = value;
          controller.timeController6.text = '${time6!.hour}:${time6!.minute}';
        });
      }
    });
  }

  _timePicker7(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time7 = value;
          controller.timeController7.text = '${time7!.hour}:${time7!.minute}';
        });
      }
    });
  }

  _timePicker8(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time8 = value;
          controller.timeController8.text = '${time8!.hour}:${time8!.minute}';
        });
      }
    });
  }

  _timePicker9(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return null;
      } else {
        setState(() {
          time9 = value;
          controller.timeController9.text = '${time9!.hour}:${time9!.minute}';
        });
      }
    });
  }
}

class _Form5 extends StatefulWidget {
  const _Form5({Key? key}) : super(key: key);

  @override
  __Form5State createState() => __Form5State();
}

class __Form5State extends State<_Form5> {
  CreateReportController controller = CreateReportController();

  @override
  void initState() {
    super.initState();
    controller.textController17
        .addListener(() => text17 = controller.textController17.text);
    controller.textController18
        .addListener(() => text18 = controller.textController18.text);
    controller.textController19
        .addListener(() => text19 = controller.textController19.text);
    controller.textController20
        .addListener(() => text20 = controller.textController20.text);
    controller.textController21
        .addListener(() => text21 = controller.textController21.text);
    controller.textController22
        .addListener(() => text22 = controller.textController22.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              const _Title(text: 'Indicadores dietéticos'),
              const _Separator(text: '¿Cómo es mi apetito? *'),
              DropdownButtonFormField(
                value: appetite,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Seleccione uno',
                  hintText: 'Seleccione uno',
                ),
                onChanged: (String? value) => setState(() {
                  appetite = value!;
                }),
                items: appetiteList
                    .map((value) =>
                        DropdownMenuItem(child: Text(value), value: value))
                    .toList(),
                validator: (value) =>
                    Validator().validateDropdown(appetite, appetiteList[0]),
              ),
              const _Separator(text: '¿En qué horario tienes más hambre? *'),
              DropdownButtonFormField(
                value: hungry,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Seleccione uno',
                  hintText: 'Seleccione uno',
                ),
                onChanged: (String? value) => setState(() {
                  hungry = value!;
                }),
                items: hungryList
                    .map((value) =>
                        DropdownMenuItem(child: Text(value), value: value))
                    .toList(),
                validator: (value) =>
                    Validator().validateDropdown(hungry, hungryList[0]),
              ),
              const _Separator(
                  text:
                      '¿Especifique por qué tienes más hambre en ese horario? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController17,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: <Widget>[
              const _Title(text: 'Alimentos y características'),
              const _Separator(text: 'Mis alimentos preferidos *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController18,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Alimentos preferidos',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(
                  text: 'Alimentos que no te agradan o no acostumbras comer *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController19,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Alimentos que no acostumbras o te desagrandan',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(text: 'Alimentos que te causan malestar *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController20,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Alimentos que te causan malestar',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(
                  text: '¿Eres alérgic@ y/o intolerante a algún alimento? *'),
              _radioGroup15(),
              if (radioGroup15 == 1) const _Subtitle(text: 'Especifique *'),
              if (radioGroup15 == 1)
                TextFormField(
                  autocorrect: true,
                  controller: controller.textController21,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: '',
                  ),
                  validator: (value) {
                    if (radioGroup15 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Separator(text: '¿Tomas algún suplemento alimenticio? *'),
              _radioGroup16(),
              if (radioGroup16 == 1) const _Subtitle(text: 'Especifique *'),
              if (radioGroup16 == 1)
                TextFormField(
                  autocorrect: true,
                  controller: controller.textController22,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: '',
                  ),
                  validator: (value) {
                    if (radioGroup16 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioGroup15() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup15,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup15 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup15,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup15 = value),
        ),
      ],
    );
  }

  Widget _radioGroup16() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup16,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup16 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup16,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup16 = value),
        ),
      ],
    );
  }
}

class _Form6 extends StatefulWidget {
  const _Form6({Key? key}) : super(key: key);

  @override
  __Form6State createState() => __Form6State();
}

class __Form6State extends State<_Form6> {
  CreateReportController controller = CreateReportController();

  @override
  void initState() {
    super.initState();
    controller.textController23
        .addListener(() => text23 = controller.textController23.text);
    controller.textController24
        .addListener(() => text24 = controller.textController24.text);
    controller.textController25
        .addListener(() => text25 = controller.textController25.text);
    controller.textController26
        .addListener(() => text26 = controller.textController26.text);
    controller.textController27
        .addListener(() => text27 = controller.textController27.text);
    controller.textController28
        .addListener(() => text28 = controller.textController28.text);
    controller.textController29
        .addListener(() => text29 = controller.textController29.text);
    controller.textController30
        .addListener(() => text30 = controller.textController30.text);
    controller.textController31
        .addListener(() => text31 = controller.textController31.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              const _Title(text: 'Consumo y variantes'),
              const _Separator(
                  text: '¿Agrega "Sal" a las comidas ya preparadas? *'),
              _radioGroup17(),
              if (radioGroup17 == 1)
                const _Subtitle(text: '¿Qué tipo de sal? *'),
              if (radioGroup17 == 1)
                TextFormField(
                  controller: controller.textController23,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup17 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Separator(text: '¿Ha llevado una dieta especial? *'),
              _radioGroup18(),
              if (radioGroup18 == 1)
                const _Subtitle(text: '¿Qué tipo de dieta? *'),
              if (radioGroup18 == 1)
                TextFormField(
                  controller: controller.textController24,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup18 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Separator(
                  text:
                      '¿Ha utilizado algún tipo de tratamiento para bajar de peso? *'),
              _radioGroup19(),
              if (radioGroup19 == 1)
                const _Subtitle(text: '¿Qué tipo de tratamiento? *'),
              if (radioGroup19 == 1)
                TextFormField(
                  controller: controller.textController25,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: MaethInputDecoration().textReportDecoration(
                    context: context,
                    lableText: 'Especifique',
                    hintText: 'Espeficique',
                  ),
                  validator: (value) {
                    if (radioGroup19 == 1) {
                      return Validator().validateText(value!);
                    }
                  },
                ),
              const _Separator(text: 'Aceites...??? *'),
              DropdownButtonFormField(
                value: oil,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Seleccione uno',
                  hintText: 'Seleccione uno',
                ),
                onChanged: (String? value) => setState(() {
                  oil = value!;
                }),
                items: oilsList
                    .map((value) =>
                        DropdownMenuItem(child: Text(value), value: value))
                    .toList(),
                validator: (value) =>
                    Validator().validateDropdown(oil, oilsList[0]),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: <Widget>[
              const _Title(text: 'Dieta habitual'),
              const _Separator(text: '¿Qué deasyuno? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController26,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(text: '¿Qué como de colación? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController27,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(text: '¿Qué como? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController28,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(text: '¿Qué como de colación? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController29,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(text: '¿Qué ceno? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController30,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
              const _Separator(text: '¿Qué como de colación? *'),
              TextFormField(
                autocorrect: true,
                controller: controller.textController31,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: MaethInputDecoration().textReportDecoration(
                  context: context,
                  lableText: 'Especifique',
                  hintText: '',
                ),
                validator: (value) => Validator().validateText(value!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioGroup17() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup17,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup17 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup17,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup17 = value),
        ),
      ],
    );
  }

  Widget _radioGroup18() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup18,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup18 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup18,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup18 = value),
        ),
      ],
    );
  }

  Widget _radioGroup19() {
    return Column(
      children: [
        GFRadioListTile(
          size: 20,
          value: 1,
          groupValue: radioGroup19,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'Sí',
          onChanged: (value) => setState(() => radioGroup19 = value),
        ),
        GFRadioListTile(
          size: 20,
          value: 2,
          groupValue: radioGroup19,
          activeBorderColor: GFColors.PRIMARY,
          radioColor: GFColors.PRIMARY,
          position: GFPosition.start,
          titleText: 'No',
          onChanged: (value) => setState(() => radioGroup19 = value),
        ),
      ],
    );
  }
}

// Widgets
class _Subtitle extends StatelessWidget {
  final String text;

  const _Subtitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 2,
      color: Color(0xff87D2B1),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  final String text;
  const _Separator({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        const _Divider(),
        const SizedBox(height: 10),
        _Subtitle(text: text),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CreateReportController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GFButton(
        onPressed: () => controller.createReport(context),
        text: 'Guardar',
        color: const Color(0xff01C473),
        textColor: Colors.white,
        fullWidthButton: true,
        shape: GFButtonShape.pills,
        size: GFSize.LARGE,
      ),
    );
  }
}
