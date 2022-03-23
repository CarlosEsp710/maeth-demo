part of 'widgets.dart';

class PatientStatistics extends StatelessWidget {
  final Patient patient;

  const PatientStatistics({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final imc = patient.weight / (patient.height * patient.height);
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildItem(context, '${patient.weight} Kg', 'Peso'),
          _buildDivider(),
          _buildItem(context, '${patient.height} m', 'Estatura'),
          // _buildDivider(),
          // _buildItem(context, '$imc', 'IMC'),
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
}
