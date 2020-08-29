import "dart:ui";

class DpExtension {
  static Window _window;
  static double _multiplier = 1;
  DpExtension(Window window) {
    _window = window;
    //really strange, but that works
    _multiplier = (_window.devicePixelRatio < 2.0) ? 2 : 1;
    print("dp extensio device pixel ratio ${_window.devicePixelRatio}");
  }
}

extension DpExt<T extends num> on T {
  double get dp {
    return this *
        (DpExtension._window?.devicePixelRatio ?? 1) *
        DpExtension._multiplier;
  }
}
