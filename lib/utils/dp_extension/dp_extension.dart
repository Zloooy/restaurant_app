class DpExtension {
  static late double _devicePixelRatio;
  static double _multiplier = 1;
  DpExtension(double devicePixelRatio) {
    _devicePixelRatio = devicePixelRatio;
    _multiplier = (devicePixelRatio < 2.0) ? 2 : 1;
  }
}

extension DpExt<T extends num> on T {
  double get dp {
    return this * (DpExtension._devicePixelRatio) * DpExtension._multiplier;
  }
}
