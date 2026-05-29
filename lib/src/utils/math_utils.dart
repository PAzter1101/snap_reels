import 'dart:math';
import 'dart:ui';

/// Math, geometry and tween helpers.
class MathUtils {
  MathUtils._();

  /// Default 16:9 aspect ratio is returned when [height] is zero.
  static double calculateAspectRatio(double width, double height) {
    if (height == 0) return 16 / 9;
    return width / height;
  }

  /// Cubic ease-in-out curve.
  static double easeInOut(double t) {
    return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t;
  }

  /// Linear interpolation between [start] and [end] at fraction [t].
  static double lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  /// Clamps [value] into `[min, max]`.
  static T clamp<T extends num>(T value, T min, T max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Maps [value] from `[inMin, inMax]` to `[outMin, outMax]`.
  static double mapRange(
    double value,
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) {
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  /// Whether two rectangles overlap.
  static bool rectsIntersect(Rect rect1, Rect rect2) {
    return rect1.left < rect2.right &&
        rect1.right > rect2.left &&
        rect1.top < rect2.bottom &&
        rect1.bottom > rect2.top;
  }

  /// Euclidean distance between two points.
  static double getDistance(Offset point1, Offset point2) {
    final dx = point1.dx - point2.dx;
    final dy = point1.dy - point2.dy;
    return sqrt(dx * dx + dy * dy);
  }

  /// Angle (radians) of the vector from [point1] to [point2].
  static double getAngle(Offset point1, Offset point2) {
    final dx = point2.dx - point1.dx;
    final dy = point2.dy - point1.dy;
    return atan2(dy, dx);
  }

  /// Radians → degrees.
  static double radiansToDegrees(double radians) => radians * 180 / pi;

  /// Degrees → radians.
  static double degreesToRadians(double degrees) => degrees * pi / 180;
}
