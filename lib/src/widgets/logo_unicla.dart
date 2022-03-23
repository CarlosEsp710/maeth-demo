part of 'widgets.dart';

class LogoUnicla extends StatelessWidget {
  final Color color;

  const LogoUnicla({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'UNICLA',
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}
