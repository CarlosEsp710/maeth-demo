import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:maeth_demo/src/controllers/patient/list_patients_controller.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:maeth_demo/src/views/chat/chat_view.dart';
import 'package:maeth_demo/src/views/patient/patient_info_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';

class PatientListView extends StatelessWidget {
  const PatientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListPatientsController _controller = ListPatientsController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis pacientes'),
      ),
      body: FutureBuilder(
        future: _controller.listPatients(context),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData ? _list(snapshot) : _loading();
        },
      ),
    );
  }
}

ListView _list(AsyncSnapshot<dynamic> snapshot) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, i) => _listTileItem(context, snapshot.data![i]),
      separatorBuilder: (context, index) => const Divider(),
    );

ListTile _listTileItem(BuildContext context, User user) {
  return ListTile(
    title: Text('${user.firstName} ${user.lastName}'),
    subtitle: Text(user.email),
    leading: CircleAvatar(
      backgroundImage: NetworkImage(user.imageProfile),
    ),
    trailing: IconButton(
      icon: const Icon(Icons.message, color: Colors.pink),
      onPressed: () => Navigator.push(
        context,
        PageTransition(
          child: ChatView(user: user),
          type: PageTransitionType.leftToRight,
        ),
      ),
    ),
    onTap: () => Navigator.push(
      context,
      PageTransition(
        child: PatientInfoView(user: user),
        type: PageTransitionType.rightToLeft,
      ),
    ),
  );
}

ListView _loading() => ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: 20,
      itemBuilder: (context, index) => const _CardSkelton(),
      separatorBuilder: (context, index) => const Divider(),
    );

class _CardSkelton extends StatelessWidget {
  const _CardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleSkeleton(size: 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Skeleton(width: 80, height: 10),
              SizedBox(height: 16 / 2),
              Skeleton(height: 10),
              SizedBox(height: 16 / 2),
              Skeleton(height: 10),
              SizedBox(height: 16 / 2),
            ],
          ),
        )
      ],
    );
  }
}
