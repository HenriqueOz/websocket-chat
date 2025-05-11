extension StringExt on String {
  String replacePlaceholder(String replace) {
    return replaceFirst(RegExp(r'\{0}'), replace);
  }
}
