part of 'widgets.dart';

class NutriStatistics extends StatelessWidget {
  final Nutritionist nutritionist;

  const NutriStatistics({
    Key? key,
    required this.nutritionist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int patients = nutritionist.patientsId.length;

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildButton(context, 'Curriculum'),
          _buildDivider(),
          _buildItem(context, '$patients', 'Paciente(s)'),
        ],
      ),
    );
  }

  Widget _buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(color: Colors.black),
      );

  Widget _buildItem(BuildContext context, String value, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: const Icon(
              FontAwesomeIcons.linkedin,
              color: Colors.blueAccent,
              size: 38,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
