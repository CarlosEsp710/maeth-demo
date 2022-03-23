part of 'widgets.dart';

class LogoMaeth extends StatelessWidget {
  final Color? color;

  const LogoMaeth({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.heartbeat,
          color: color,
          size: 100,
        ),
        Text(
          'MAETH',
          style: TextStyle(
            color: color,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
