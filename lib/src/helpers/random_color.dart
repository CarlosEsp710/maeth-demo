part of 'helpers.dart';

class Util {
  static Color randomColor() {
    return Color(math.Random().nextInt(0xffffffff));
  }

  static Color randomOpaqueColor() {
    return Color(math.Random().nextInt(0xffffffff)).withAlpha(0xff);
  }
}
