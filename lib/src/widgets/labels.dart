part of 'widgets.dart';

class Labels extends StatelessWidget {
  final Widget route;
  final String title;
  final String subtitle;

  const Labels({
    Key? key,
    required this.route,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xff01C473),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => Navigator.pushReplacement(
              context,
              PageTransition(
                child: route,
                type: PageTransitionType.rightToLeft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
