import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/nutritionist/get_nutritionist_controller.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';
import 'package:maeth_demo/src/schemas/nutritionist_schema.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:maeth_demo/src/views/auth/complete_profile_view.dart';
import 'package:maeth_demo/src/views/chat/chat_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class NutritionistInfoView extends StatelessWidget {
  final User user;

  const NutritionistInfoView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetNutritionistController _controller = GetNutritionistController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del nutriólogo'),
      ),
      body: FutureBuilder(
        future:
            _controller.getNutritionist(context, user.nutritionistProfileId!),
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

  ListView _profile(BuildContext context, Nutritionist profile) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      children: <Widget>[
        const SizedBox(height: 24),
        CircleImage(imagePath: user.imageProfile),
        const SizedBox(height: 24),
        buildInfo(user),
        const SizedBox(height: 24),
        (userProvider.myNutritionist == null)
            ? GFButton(
                onPressed: () {
                  userProvider.myNutritionist = user;
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      child: const CompleteProfileView(),
                      type: PageTransitionType.leftToRight,
                    ),
                    (route) => false,
                  );
                },
                text: 'Escoger como mi nutriólogo',
                color: const Color(0xff01C473),
                textColor: Colors.white,
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              )
            : GFButton(
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    child: ChatView(user: user),
                    type: PageTransitionType.leftToRight,
                  ),
                ),
                text: 'Chat directo',
                color: const Color(0xff01C473),
                textColor: Colors.white,
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
        const SizedBox(height: 24),
        NutriStatistics(nutritionist: profile),
        const SizedBox(height: 24),
        ProfileDescription(description: profile.description),
      ],
    );
  }
}
