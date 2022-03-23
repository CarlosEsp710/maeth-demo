// ignore_for_file: unnecessary_getters_setters

part of 'widgets.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool topDots;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryBullet;
  final double secondaryBullet;
  final BoxShape shape;
  final double height;
  final double padding;

  const Slideshow({
    Key? key,
    required this.slides,
    this.topDots = false,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.primaryBullet = 12,
    this.secondaryBullet = 12,
    this.shape = BoxShape.circle,
    this.height = 1,
    this.padding = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlideshowModel>(context).primaryColor = primaryColor;
              Provider.of<_SlideshowModel>(context).secondaryColor =
                  secondaryColor;
              Provider.of<_SlideshowModel>(context).primaryBullet =
                  primaryBullet;
              Provider.of<_SlideshowModel>(context).secondaryBullet =
                  secondaryBullet;
              Provider.of<_SlideshowModel>(context).height = height;
              Provider.of<_SlideshowModel>(context).shape = shape;
              Provider.of<_SlideshowModel>(context).padding = padding;
              return _StructureSlideshow(
                topDots: topDots,
                slides: slides,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StructureSlideshow extends StatelessWidget {
  final bool topDots;
  final List<Widget> slides;

  const _StructureSlideshow({
    Key? key,
    required this.topDots,
    required this.slides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (topDots) _Dots(dots: slides.length),
        Expanded(
          child: _Slides(slides: slides),
        ),
        if (!topDots) _Dots(dots: slides.length),
      ],
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides({
    Key? key,
    required this.slides,
  }) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide: slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({
    Key? key,
    required this.slide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(ssModel.padding),
      child: slide,
    );
  }
}

class _Dots extends StatelessWidget {
  final int dots;

  const _Dots({
    Key? key,
    required this.dots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dots, (i) => _Dot(index: i))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    double size = 0;
    Color color;

    if (ssModel.currentPage >= index - 0.5 &&
        ssModel.currentPage < index + 0.5) {
      size = ssModel.primaryBullet;
      color = ssModel.primaryColor;
    } else {
      size = ssModel.secondaryBullet;
      color = ssModel.secondaryColor;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: (ssModel.shape == BoxShape.circle) ? size : ssModel.height,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        shape: ssModel.shape,
      ),
    );
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _primaryBullet = 12;
  double _secondaryBullet = 12;
  double _height = 1;
  BoxShape _shape = BoxShape.circle;
  double _padding = 30;
  double get currentPage => _currentPage;

  set currentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }

  Color get primaryColor => _primaryColor;

  set primaryColor(Color color) {
    _primaryColor = color;
  }

  Color get secondaryColor => _secondaryColor;

  set secondaryColor(Color color) {
    _secondaryColor = color;
  }

  double get primaryBullet => _primaryBullet;

  set primaryBullet(double size) {
    _primaryBullet = size;
  }

  double get secondaryBullet => _secondaryBullet;

  set secondaryBullet(double size) {
    _secondaryBullet = size;
  }

  double get height => _height;

  set height(double size) {
    _height = size;
  }

  BoxShape get shape => _shape;

  set shape(BoxShape shape) {
    _shape = shape;
  }

  double get padding => _padding;

  set padding(double size) {
    _padding = size;
  }
}
