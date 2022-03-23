import 'package:flutter/material.dart';

import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:maeth_demo/src/controllers/report/create_report_controller.dart';
import 'package:maeth_demo/src/controllers/report/list_reports_controller.dart';
import 'package:maeth_demo/src/controllers/report/pdf/pdf_report.dart';

import 'package:maeth_demo/src/providers/user_provider.dart';

import 'package:maeth_demo/src/schemas/report_schema.dart';

import 'package:maeth_demo/src/views/chat/chat_view.dart';
import 'package:maeth_demo/src/views/nutritionist/nutritionist_info_view.dart';

import 'package:maeth_demo/src/widgets/widgets.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  bool _isShowDial = false;

  @override
  Widget build(BuildContext context) {
    ListReportController _listController = ListReportController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nutrición'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: _listController.getReports(context),
        builder: (context, AsyncSnapshot snapshot) {
          return (snapshot.hasData)
              ? (!snapshot.data.isEmpty)
                  ? _list(snapshot)
                  : const Center(
                      child: Text(
                        'Aún no haz creado ninguna historia clínica.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
              : _loading();
        },
      ),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  Widget _getFloatingActionButton() {
    final nutritionist =
        Provider.of<UserProvider>(context, listen: false).myNutritionist;

    CreateReportController _createController = CreateReportController();

    return SpeedDialMenuButton(
      isShowSpeedDial: _isShowDial,
      updateSpeedDialStatus: (isShow) {
        _isShowDial = isShow;
      },
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
        mini: false,
        child: const Icon(Icons.menu),
        onPressed: () {},
        tooltip: 'Mostrar opciones',
        closeMenuChild: Icon(Icons.close),
        closeMenuForegroundColor: Colors.white,
        closeMenuBackgroundColor: Colors.red,
      ),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          mini: true,
          child: const Icon(Icons.chat),
          tooltip: 'Chat con mi nutricionista',
          onPressed: () {
            setState(() {
              _isShowDial = false;
            });
            Navigator.push(
              context,
              PageTransition(
                child: ChatView(user: nutritionist!),
                type: PageTransitionType.leftToRight,
              ),
            );
          },
          backgroundColor: Colors.pink,
        ),
        FloatingActionButton(
          mini: true,
          tooltip: 'Nuevo reporte',
          child: const Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _isShowDial = !_isShowDial;
            });
            _createController.showAlert(context);
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: const Icon(Icons.person),
          tooltip: 'Mi nutricionista',
          onPressed: () {
            setState(() {
              _isShowDial = false;
            });
            Navigator.push(
              context,
              PageTransition(
                child: NutritionistInfoView(user: nutritionist!),
                type: PageTransitionType.leftToRight,
              ),
            );
          },
          backgroundColor: Colors.deepPurple,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }
}

ListView _list(AsyncSnapshot<dynamic> snapshot) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, i) => _listTileItem(context, snapshot.data![i]),
      separatorBuilder: (context, index) => const Divider(),
    );

ListTile _listTileItem(BuildContext context, Report report) {
  final user = Provider.of<UserProvider>(context, listen: false).user;

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
