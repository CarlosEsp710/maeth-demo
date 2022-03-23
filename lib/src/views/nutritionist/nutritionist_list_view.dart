import 'package:flutter/material.dart';
import 'package:maeth_demo/src/controllers/nutritionist/list_nutritionist_controller.dart';
import 'package:maeth_demo/src/schemas/user_schema.dart';
import 'package:maeth_demo/src/views/nutritionist/nutritionist_info_view.dart';
import 'package:maeth_demo/src/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';

class NutritionistListView extends StatelessWidget {
  const NutritionistListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListNutritionistsController _controller =
        ListNutritionistsController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un nutriólogo'),
      ),
      body: FutureBuilder(
        future: _controller.listNutritionists(context),
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
    trailing: const Icon(
      Icons.verified,
      color: Colors.blueAccent,
    ),
    onTap: () => Navigator.push(
      context,
      PageTransition(
        child: NutritionistInfoView(user: user),
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
